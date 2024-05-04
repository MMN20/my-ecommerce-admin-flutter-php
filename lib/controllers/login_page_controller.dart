import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/auth_data.dart';
import 'package:my_ecommerce_admin/main.dart';
import 'package:my_ecommerce_admin/routes.dart';

class LoginPageController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> login() async {
    if (globalKey.currentState!.validate()) {
      requestStatus = RequestStatus.loading;
      update();
      dynamic response =
          await AuthData.login(emailController.text, passwordController.text);
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          int adminID = response['data']['admins_id'];
          String email = response['data']['admins_email'];
          String username = response['data']['admins_username'];
          goToMainScreenPage(adminID, email, username);
        } else {
          incorrectSnackBar();
        }
      }
      update();
    }
  }

  void incorrectSnackBar() {
    Get.snackbar("Error", "The email or the password was incorrect!");
  }

  void saveDataToSharedPrefs(int adminID, String email, String username) {
    sharedPref.setInt("id", adminID);
    sharedPref.setString("email", email);
    sharedPref.setString("username", username);
  }

  void goToMainScreenPage(int adminID, String email, String username) {
    saveDataToSharedPrefs(adminID, email, username);
    Get.toNamed(AppRoutes.mainScreen);
  }
}
