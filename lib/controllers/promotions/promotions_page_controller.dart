import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/promotions_data.dart';
import 'package:my_ecommerce_admin/data/model/promotion_model.dart';
import 'package:my_ecommerce_admin/routes.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';

class PromotionsPageController extends GetxController {
  List<PromotionModel> promotions = [];
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllPromotions() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await PromotionsData.getAllPromotions();
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        promotions =
            responseData.map((e) => PromotionModel.fromJson(e)).toList();
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  void showDeleteDialog(PromotionModel promotionModel) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Are you sure that you want to delete this promotion?",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GeneralButton(
                  onPressed: () {
                    Get.back();
                    deletePromotion(promotionModel);
                  },
                  backgroundColor: Colors.red,
                  child: const Text("Delete"),
                ),
                const SizedBox(width: 10),
                GeneralButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel")),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future<void> deletePromotion(PromotionModel promotionModel) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await PromotionsData.deletePromotion(
        promotionModel.promotionsId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        promotions.remove(promotionModel);
        Get.snackbar("Success", "The promotion has been deleted successfully!");
      } else {
        Get.snackbar(
            "Errir", "Failed to delete the promotion! please refresh the page");
      }
    }
    update();
  }

  // add mode
  void goToAddPromotionsPage() {
    Get.toNamed(AppRoutes.addEditPromotionsPage);
  }

  // edit mode
  void goToEditPromotionPage(PromotionModel promotionModel) {
    Get.toNamed(AppRoutes.addEditPromotionsPage, arguments: promotionModel);
  }

  @override
  void onInit() {
    getAllPromotions();
    super.onInit();
  }
}
