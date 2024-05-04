import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/categories_data.dart';
import 'package:my_ecommerce_admin/data/model/category_model.dart';
import 'package:my_ecommerce_admin/routes.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';

class CategoriesPageController extends GetxController {
  List<CategoryModel> categories = [];
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllCategories() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await CategoriesData.getAllCategories();
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        print(responseData);
        categories =
            responseData.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  Future<void> deleteCategory(CategoryModel categoryModel) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response =
        await CategoriesData.deleteCategory(categoryModel.catId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        categories.remove(categoryModel);
        Get.snackbar("Success", "The category has been deleted");
      } else {
        Get.snackbar("Error", "The category couldn't be deleted");
      }
    }
    update();
  }

  void showConfirmDeletingDialog(CategoryModel categoryModel) {
    Get.dialog(Dialog(
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "If you delete any category then all the items and the sub categories that are associated with it will be deleted also, Are you sure?",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GeneralButton(
                    onPressed: () {
                      Get.back();
                      deleteCategory(categoryModel);
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

  void goToAddCategoryPage() {
    Get.toNamed(AppRoutes.addEditCategory, arguments: {'categoryModel': null});
  }

  void goToEditCategoryPage(CategoryModel categoryModel) {
    Get.toNamed(AppRoutes.addEditCategory,
        arguments: {'categoryModel': categoryModel});
  }

  void goToSubCategoriesPage(CategoryModel categoryModel) {
    Get.toNamed(
      AppRoutes.subCategories,
      arguments: {'categoryModel': categoryModel},
    );
  }

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }
}
