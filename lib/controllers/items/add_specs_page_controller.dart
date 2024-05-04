import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/data/model/specification.dart';
import 'package:my_ecommerce_admin/routes.dart';

class AddSpecsPageController extends GetxController {
  List<Specification> specs = [];
  List<TextEditingController> controllers = [TextEditingController()];
  late Map<String, dynamic> data;

  void addNewTextField() {
    if (controllers[controllers.length - 1].text.isNotEmpty) {
      controllers.add(TextEditingController());
      update();
    }
  }

  void getJsonData() {
    List<Map<String, String>> jsonSpecs = [];
    for (int i = 0; i < controllers.length; i++) {
      if (controllers[i].text.isNotEmpty) {
        jsonSpecs.add({
          "name": "",
          "value": controllers[i].text,
        });
      }
    }

    data['specs'] = jsonSpecs;
  }

  void goToImagesPage() {
    getJsonData();
    Get.toNamed(AppRoutes.addImagesPage, arguments: {'data': data});
  }

  @override
  void onInit() {
    data = Get.arguments['data'];
    super.onInit();
  }
}
