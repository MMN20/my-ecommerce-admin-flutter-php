import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/items_data.dart';
import 'package:my_ecommerce_admin/data/model/image_model.dart';
import 'package:my_ecommerce_admin/data/model/items_model.dart';
import 'package:my_ecommerce_admin/data/model/specification.dart';
import 'package:my_ecommerce_admin/routes.dart';

class ItemDetailsPageController extends GetxController {
  RequestStatus requestStatus = RequestStatus.none;

  List<Specification> specs = [];
  List<ImageModel> images = [];
  late ItemModel currentItem;
  List<Image> flutterImages = [];
  int selectedImageIndex = 0;

  /// selected categories
  Map<String, dynamic> selectedCat = {};

  Future<void> getAllData() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response =
        await ItemsData.getItemDetails(currentItem.itemId!.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      List responseData = response['data']['specs'];

      specs = responseData.map((e) => Specification.fromJson(e)).toList();
      responseData = response['data']['images'];
      images = responseData.map((e) => ImageModel.fromJson(e)).toList();
      selectedCat = response['data']['cat'];
    }
    for (ImageModel imageModel in images) {
      flutterImages
          .add(Image.network("${APILinks.itemImages}/${imageModel.imageURL}"));
    }
    update();
  }

  void changeSelectedImageIndex(int index) {
    selectedImageIndex = index;
    update();
  }

  void goToEditItemDetailsPage() {
    Get.toNamed(AppRoutes.editItemDetailsPage,
        arguments: {"item": currentItem, "cat": selectedCat, "specs": specs});
  }

  @override
  void onInit() {
    currentItem = Get.arguments['item'];
    getAllData();
    super.onInit();
  }
}
