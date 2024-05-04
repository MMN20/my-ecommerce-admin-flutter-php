import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/orders_data.dart';
import 'package:my_ecommerce_admin/data/model/order_model.dart';
import 'package:my_ecommerce_admin/routes.dart';

class ArchiveOrdersPageController extends GetxController {
  RequestStatus requestStatus = RequestStatus.none;
  List<OrderModel> orders = [];

  void refreshScreen() {
    orders.clear();
    getArchivedOrders();
  }

  ScrollController scrollController = ScrollController();

  int maxAcceptedOrders = 0;
  bool isLoading = false;

  Future<void> loadMoreOrders() async {
    if (orders.length < maxAcceptedOrders &&
        scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
      if (!isLoading) {
        isLoading = true;
        getArchivedOrders(false);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          scrollController.position
              .moveTo(scrollController.position.maxScrollExtent);
        });
      }
    }
  }

  Future<void> getArchivedOrders([bool loadingStatus = true]) async {
    int currentIndex;
    if (orders.length == 0) {
      currentIndex = 1;
    } else {
      currentIndex = orders[orders.length - 1].ordersId!;
    }

    if (loadingStatus) {
      requestStatus = RequestStatus.loading;
    }
    update();
    dynamic response =
        await OrdersData.getArchivedOrders(currentIndex.toString());
    print(response);
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        maxAcceptedOrders = response['maxOrders'];
        List responseData = response['data'];
        orders.addAll(responseData.map((e) => OrderModel.fromJson(e)).toList());
      } else if (response['status'] == 'failure' && orders.isEmpty) {
        requestStatus = RequestStatus.empty;
      }
    }
    isLoading = false;
    update();
  }

  Future<void> backToAccept(OrderModel orderModel) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.backToAcceptOrder(
        orderModel.ordersId.toString(), orderModel.userId.toString());
    requestStatus = hanldeRequestData(response);

    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        orders.remove(orderModel);
        update();
        Get.snackbar("Success", "The order went back to accepted orders!");
      } else {
        Get.snackbar("Failure", "An error occurred!");
      }
    }
    update();
  }

  void goToOrderDetailsPage(OrderModel orderModel) {
    Get.toNamed(AppRoutes.ordersDetailsPage,
        arguments: {"orderModel": orderModel});
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    getArchivedOrders();
    scrollController.addListener(loadMoreOrders);
    super.onInit();
  }
}
