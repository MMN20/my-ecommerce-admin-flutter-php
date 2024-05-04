import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/sub_categories_data.dart';
import 'package:my_ecommerce_admin/data/model/category_model.dart';
import 'package:my_ecommerce_admin/data/model/sub_category_model.dart';
import 'package:my_ecommerce_admin/routes.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';

class SubCategoriesPageController extends GetxController {
  // the parent category
  late CategoryModel category;
  List<SubCategoryModel> subCategories = [];

  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllSubCategories() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response =
        await SubCategoriesData.getAllSubCategories(category.catId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        print(responseData);
        subCategories =
            responseData.map((e) => SubCategoryModel.fromJson(e)).toList();
        // for (var s in subCategories) {
        //   print(s.catId);
        // }
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  void goToAddSubCategory() {
    Get.toNamed(AppRoutes.addEditSubCategories, arguments: {
      "subcategoryModel": null,
      "categoryModel": category,
    });
  }

  void goToEditSubCategory(SubCategoryModel subCategoryModel) {
    Get.toNamed(AppRoutes.addEditSubCategories, arguments: {
      "subcategoryModel": subCategoryModel,
      "categoryModel": category,
    });
  }

  Future<void> deleteSubCategory(SubCategoryModel subcategoryModel) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await SubCategoriesData.deleteSubCategory(
        subcategoryModel.subcatId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        subCategories.remove(subcategoryModel);
        Get.snackbar("Success", "The category has been deleted");
      } else {
        Get.snackbar("Error", "The category couldn't be deleted");
      }
    }
    update();
  }

  void showConfirmDeletingDialog(SubCategoryModel subcategoryModel) {
    Get.dialog(Dialog(
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "If you delete any subcategory then all the items associated with it will be deleted also, Are you sure?",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GeneralButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      Get.back();
                      deleteSubCategory(subcategoryModel);
                    },
                    child: const Text("Delete")),
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

  @override
  void onInit() {
    category = Get.arguments['categoryModel'];
    getAllSubCategories();
    super.onInit();
  }
}
