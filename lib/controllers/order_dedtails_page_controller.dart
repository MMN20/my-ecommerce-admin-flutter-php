import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/orders_data.dart';
import 'package:my_ecommerce_admin/data/model/items_model.dart';
import 'package:my_ecommerce_admin/data/model/order_model.dart';

class OrderDetailsPageController extends GetxController {
  late OrderModel orderModel;
  List<ItemModel> items = [];
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllItems() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response =
        await OrdersData.getOrderItems(orderModel.ordersId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        items = List.generate(responseData.length,
            (index) => ItemModel.fromJson(responseData[index]));
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  //! implement later
  // void goToItemDetailsPage(ItemModel item) {
  //   Get.toNamed(AppRoutes.itemDetails, arguments: {"item": item});
  // }

  Future<void> openGoogleMaps() async {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(orderModel.addressLat!, orderModel.addressLong!),
      zoom: 14,
    );
    Set<Marker> makers = {
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(orderModel.addressLat!, orderModel.addressLong!),
      ),
    };

    Get.dialog(
      Material(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: cameraPosition,
              markers: makers,
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    orderModel = Get.arguments['orderModel'];
    print(orderModel.ordersId);
    getAllItems();
    super.onInit();
  }
}
