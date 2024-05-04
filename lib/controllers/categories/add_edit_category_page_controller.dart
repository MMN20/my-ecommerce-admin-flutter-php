import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_ecommerce_admin/controllers/categories/categories_page_controller.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/categories_data.dart';
import 'package:my_ecommerce_admin/data/model/category_model.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';

class AddEditCategoryPageController extends GetxController {
  late CategoryModel categoryModel;
  late bool isAdd;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  // for the new file
  File? image;
  RequestStatus requestStatus = RequestStatus.none;
  GlobalKey<FormState> globalKey = GlobalKey();

  void setCurrentMode() {
    CategoryModel? category = Get.arguments['categoryModel'];
    if (category != null) {
      isAdd = false;
      categoryModel = category;
      nameController.text = categoryModel.catName!;
      descController.text = categoryModel.catDesc!;
    } else {
      categoryModel = CategoryModel();
      isAdd = true;
    }
  }

  void showImageSourceDialog() {
    Get.dialog(Dialog(
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Choose the source of the image"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GeneralButton(
                    onPressed: () {
                      setNewImage(ImageSource.camera);
                    },
                    child: const Text("Camera")),
                GeneralButton(
                    onPressed: () {
                      setNewImage(ImageSource.gallery);
                    },
                    child: const Text("Gallery")),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future<void> setNewImage(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      image = File(file.path);
      Get.back();
      print(image!.path);
      update();
    }
  }

  Future<void> addCategory() async {
    if (globalKey.currentState!.validate()) {
      if (isAdd && image == null) {
        Get.snackbar("Warning", "Please choose an image!");
        return;
      }
      requestStatus = RequestStatus.loading;
      update();
      dynamic response = await CategoriesData.addCategory(
          image!, nameController.text, descController.text);
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          categoryModel.catName = nameController.text;
          categoryModel.catDesc = descController.text;
          categoryModel.catImageUrl = response['image'];
          categoryModel.catId = int.parse(response['newID'].toString());
          refreshCategoriesPage();
          Get.back();
          Get.snackbar("Success", "The category has been saved!");
        } else {
          Get.snackbar("Error", "The image couldn't be saved!");
        }
      }
      update();
    }
  }

  Future<void> editCategory(CategoryModel categoryModel) async {
    if (globalKey.currentState!.validate()) {
      if (isAdd && image == null) {
        Get.snackbar("Warning", "Please choose an image!");
        return;
      }
      requestStatus = RequestStatus.loading;
      update();
      dynamic response = await CategoriesData.editCategory(
        image!,
        categoryModel.catId.toString(),
        nameController.text,
        descController.text,
      );
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          categoryModel.catName = nameController.text;
          categoryModel.catDesc = descController.text;
          categoryModel.catImageUrl = response['image'];
          refreshCategoriesPage();
          Get.back();
          Get.snackbar("Success", "The category has been saved!");
        } else {
          Get.snackbar("Error", "The image couldn't be saved!");
        }
      }
      update();
    }
  }

  void refreshCategoriesPage() {
    final controller = Get.find<CategoriesPageController>();
    if (isAdd) {
      controller.categories.add(categoryModel);
    }
    controller.refresh();
  }

  @override
  void onInit() {
    setCurrentMode();
    super.onInit();
  }
}
