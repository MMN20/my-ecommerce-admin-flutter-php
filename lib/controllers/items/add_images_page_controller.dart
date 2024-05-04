import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/items_data.dart';
import 'package:my_ecommerce_admin/routes.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';

class AddImagesPageController extends GetxController {
  late Map<String, dynamic> data;
  List<File> images = [];
  int currentImageIndex = 0;
  RequestStatus requestStatus = RequestStatus.none;

  void changeCurrentImage(int newIndex) {
    currentImageIndex = newIndex;
    update();
  }

  void removeImage(int imageIndex) {
    if (imageIndex == images.length - 1) {
      currentImageIndex--;
    }
    images.removeAt(imageIndex);
    update();
  }

  void showImageSourceDialog() {
    Get.dialog(
      Dialog(
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
                        addNewImage(ImageSource.camera);
                      },
                      child: const Text("Camera")),
                  GeneralButton(
                      onPressed: () {
                        addNewImage(ImageSource.gallery);
                      },
                      child: const Text("Gallery")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addNewImage(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      images.add(File(file.path));
      Get.back();
      update();
    }
  }

  Future<void> saveItemData() async {
    // print(jsonEncode(data));
    requestStatus = RequestStatus.loading;
    update();
    dynamic response =
        await ItemsData.saveItem({'data': jsonEncode(data)}, images);
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        Get.offAllNamed(AppRoutes.mainScreen);
        Get.snackbar("Success", "The item was saved successfully");
      } else {
        Get.snackbar("Error", "The item couldn't be saved");
      }
    }
    update();
  }

  @override
  void onInit() {
    data = Get.arguments['data'];
    super.onInit();
  }
}
