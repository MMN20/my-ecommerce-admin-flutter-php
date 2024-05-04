import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/main.dart';
import 'package:my_ecommerce_admin/routes.dart';

class LoginMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (sharedPref.getInt("id") != null) {
      return const RouteSettings(name: AppRoutes.mainScreen);
    }
    return null;
  }
}
