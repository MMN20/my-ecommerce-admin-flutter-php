import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/categories/sub_categories_page_controller.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/sub_categories_data.dart';
import 'package:my_ecommerce_admin/data/model/category_model.dart';
import 'package:my_ecommerce_admin/data/model/sub_category_model.dart';

class AddEditSubCategoryPageController extends GetxController {
  late CategoryModel categoryModel;
  late SubCategoryModel subcategoryModel;
  late bool isAdd;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  // for the new file
  RequestStatus requestStatus = RequestStatus.none;
  GlobalKey<FormState> globalKey = GlobalKey();

  void setCurrentMode() {
    SubCategoryModel? category = Get.arguments['subcategoryModel'];
    categoryModel = Get.arguments['categoryModel'];
    print(categoryModel.catId);
    if (category != null) {
      isAdd = false;
      subcategoryModel = category;
      nameController.text = subcategoryModel.subcatName!;
      descController.text = subcategoryModel.subcatDesc!;
    } else {
      subcategoryModel = SubCategoryModel();
      isAdd = true;
    }
  }

  Future<void> addSubCategory() async {
    if (globalKey.currentState!.validate()) {
      requestStatus = RequestStatus.loading;
      update();
      dynamic response = await SubCategoriesData.addSubCategory(
          nameController.text,
          descController.text,
          categoryModel.catId.toString());
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          subcategoryModel.subcatName = nameController.text;
          subcategoryModel.subcatDesc = descController.text;
          subcategoryModel.catId = int.parse(response['newID'].toString());
          refreshSubCategoriesPage();
          Get.back();
          Get.snackbar("Success", "The category has been saved!");
        } else {
          Get.snackbar("Error", "The image couldn't be saved!");
        }
      }
      update();
    }
  }

  Future<void> editSubCategory(SubCategoryModel subcategoryModel) async {
    if (globalKey.currentState!.validate()) {
      requestStatus = RequestStatus.loading;
      update();
      dynamic response = await SubCategoriesData.editSubCategory(
        subcategoryModel.subcatId.toString(),
        nameController.text,
        descController.text,
      );
      requestStatus = hanldeRequestData(response);
      print(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          subcategoryModel.subcatName = nameController.text;
          subcategoryModel.subcatDesc = descController.text;
          refreshSubCategoriesPage();
          Get.back();
          Get.snackbar("Success", "The category has been saved!");
        }
      }
      update();
    }
  }

  void refreshSubCategoriesPage() {
    final controller = Get.find<SubCategoriesPageController>();
    if (isAdd) {
      controller.subCategories.add(subcategoryModel);
    }
    controller.refresh();
  }

  @override
  void onInit() {
    setCurrentMode();
    super.onInit();
  }
}
