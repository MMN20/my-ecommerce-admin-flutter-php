import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/items_data.dart';
import 'package:my_ecommerce_admin/data/model/specification.dart';
import 'package:my_ecommerce_admin/routes.dart';

class EditItemSpecsPageController extends GetxController {
  late List<Specification> specs;
  late List<TextEditingController> controllers;
  late Map<String, dynamic> data;
  bool isLoading = false;

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

  void saveItemData() async {
    if (!isLoading) {
      isLoading = true;
      update();
      getJsonData();
      dynamic response = await ItemsData.updateItem({"data": jsonEncode(data)});
      RequestStatus requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        Get.offAllNamed(AppRoutes.mainScreen);
        Get.snackbar("Success", "The item was updated successfully");
      }
    }
    // Get.toNamed(AppRoutes.addImagesPage, arguments: {'data': data});
  }

  void initControllers() {
    controllers = List.generate(specs.length,
        (index) => TextEditingController(text: specs[index].specValue));

    // the empty one at the end
    controllers.add(TextEditingController());
  }

  @override
  void onInit() {
    data = Get.arguments['data'];
    specs = Get.arguments['specs'];
    initControllers();
    super.onInit();
  }
}
