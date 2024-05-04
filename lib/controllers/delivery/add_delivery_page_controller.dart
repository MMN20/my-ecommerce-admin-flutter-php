import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/delivery_data.dart';

class AddDeliveryPageController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isActive = true;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  RequestStatus requestStatus = RequestStatus.none;

  void changeActiveState() {
    isActive = !isActive;
    update();
  }

  Future<void> addDeliveryAccount() async {
    if (formState.currentState!.validate()) {
      requestStatus = RequestStatus.loading;
      update();
      dynamic response = await DeliveryData.deliveryData(
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text,
        active: isActive ? "1" : "0",
      );
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          Get.back();
          Get.snackbar(
              "Success", "The delivery account was saved successfully");
        } else {}
      }
    }
    update();
  }
}
