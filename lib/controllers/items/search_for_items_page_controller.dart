import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/items_data.dart';
import 'package:my_ecommerce_admin/data/model/items_model.dart';
import 'package:my_ecommerce_admin/routes.dart';

class SearhcForItemsPageController extends GetxController {
  List<ItemModel> searchItems = [];
  TextEditingController searchController = TextEditingController();

  Future<void> searchForItems() async {
    dynamic response = await ItemsData.search(searchController.text);
    RequestStatus requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        searchItems = responseData.map((e) => ItemModel.fromJson(e)).toList();
      } else {
        searchItems.clear();
      }
    }
    update();
  }

  void search() {
    if (searchController.text.isNotEmpty) {
      searchForItems();
    } else {
      searchItems.clear();
      update();
    }
  }

  void goToItemDetailsPage(ItemModel itemModel) {
    Get.toNamed(AppRoutes.itemDetailsPage, arguments: {'item': itemModel});
  }
}
