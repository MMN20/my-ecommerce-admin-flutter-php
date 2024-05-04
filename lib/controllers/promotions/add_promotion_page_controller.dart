import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_ecommerce_admin/controllers/promotions/promotions_page_controller.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/promotions_data.dart';
import 'package:my_ecommerce_admin/data/model/promotion_model.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';

class AddPromotionPageController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  File? image;
  RequestStatus requestStatus = RequestStatus.none;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  late bool isAddMode;
  // if != null then this is the edit mode
  PromotionModel? promotionModel;

  Future<void> pickAnImage(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      image = File(file.path);
    }
    update();
  }

  void imageSourceDialog() {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GeneralButton(
                onPressed: () {
                  Get.back();
                  pickAnImage(ImageSource.gallery);
                },
                child: const Text("From Gallery"),
              ),
              const SizedBox(width: 10),
              GeneralButton(
                onPressed: () {
                  Get.back();
                  pickAnImage(ImageSource.camera);
                },
                child: const Text("From Camera"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePromotionsPage(PromotionModel? promotionModel) {
    final controller = Get.find<PromotionsPageController>();
    if (promotionModel != null) {
      controller.promotions.add(promotionModel);
    }
    controller.update();
  }

  Future<void> addPromotion() async {
    if (globalKey.currentState!.validate()) {
      if (image == null) {
        Get.snackbar("Error", "Please choose an image");
        return;
      }
      requestStatus = RequestStatus.loading;
      update();
      dynamic response = await PromotionsData.addPromotion(
          image!, titleController.text, bodyController.text);
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          updatePromotionsPage(PromotionModel(
              promotionsTitle: titleController.text,
              promotionsBody: bodyController.text,
              promotionsId: int.parse(response['newID'].toString()),
              promotionsImageUrl: response['imageUrl']));
          Get.back();
          Get.snackbar("Success", "The promotion has been added successfully!");
        } else {
          Get.snackbar("Failure", "The promotion couldn't be added!");
        }
      }
      update();
    }
  }

  Future<void> updatePromotion() async {
    if (globalKey.currentState!.validate()) {
      requestStatus = RequestStatus.loading;
      update();

      dynamic response = await PromotionsData.updatePromotion(
        image,
        promotionModel!.promotionsId.toString(),
        titleController.text,
        bodyController.text,
      );

      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          promotionModel!.promotionsTitle = titleController.text;
          promotionModel!.promotionsBody = bodyController.text;

          if (image != null) {
            promotionModel!.promotionsImageUrl = response['imageUrl'];
          }
          updatePromotionsPage(null);

          Get.back();
          Get.snackbar(
              "Success", "The promotion has been updated successfully!");
        } else {
          Get.snackbar("Failure", "The promotion couldn't be added!");
        }
      }
      update();
    }
  }

  void initData() {
    promotionModel = Get.arguments;
    if (promotionModel == null) {
      isAddMode = true;
    } else {
      titleController.text = promotionModel!.promotionsTitle!;
      bodyController.text = promotionModel!.promotionsBody!;
      isAddMode = false;
    }
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
