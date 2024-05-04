import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/orders_data.dart';
import 'package:my_ecommerce_admin/data/model/order_model.dart';
import 'package:my_ecommerce_admin/routes.dart';
import 'package:my_ecommerce_admin/view/widgets/orders_pages/cancel_order_dialog.dart';
import 'package:my_ecommerce_admin/view/widgets/orders_pages/delete_order_dialog.dart';

class AcceptedOrdersPageController extends GetxController {
  RequestStatus requestStatus = RequestStatus.none;
  List<OrderModel> orders = [];
  TextEditingController cancelController = TextEditingController();

  void refreshScreen() {
    orders.clear();
    getAcceptedOrders();
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
        getAcceptedOrders(false);

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          scrollController.position
              .moveTo(scrollController.position.maxScrollExtent);
        });
      }
    }
  }

  Future<void> getAcceptedOrders([bool loadingStatus = true]) async {
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
        await OrdersData.getAcceptedOrders(currentIndex.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        maxAcceptedOrders = response['maxOrders'];
        // orders.clear();
        List responseData = response['data'];
        orders.addAll(responseData.map((e) => OrderModel.fromJson(e)).toList());
      } else if (response['status'] == 'failure' && orders.isEmpty) {
        requestStatus = RequestStatus.empty;
      }
    }
    isLoading = false;
    update();
  }

  Future<void> prepareOrder(OrderModel orderModel) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.prepareOrder(
        orderModel.ordersId.toString(), orderModel.userId.toString());
    requestStatus = hanldeRequestData(response);

    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        orders.remove(orderModel);
        update();
        Get.snackbar("Sucess", "The order has been prepared!");
      } else {
        Get.snackbar("Failure", "An error occurred while accepting the order!");
      }
    }
    update();
  }

  void showConfirmDialog(OrderModel orderModel) {
    Get.dialog(
      ConfirmOrderCancelingDialog(
        onYes: () {
          Get.back();
          _showDeletingDialog(orderModel);
        },
        onNo: () {
          Get.back();
        },
      ),
    );
  }

  void _showDeletingDialog(OrderModel orderModel) {
    Get.dialog(
      DeleteOrderDialog(
        controller: cancelController,
        onDeleteTap: () {
          Get.back();
          cancelOrder(orderModel);
        },
      ),
    );
  }

  Future<void> cancelOrder(OrderModel orderModel) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.cancelOrder(
        orderModel.ordersId.toString(),
        orderModel.userId.toString(),
        cancelController.text);
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        Get.snackbar("Sucess", "The order was cancelled!");
        orders.remove(orderModel);
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
    getAcceptedOrders();
    scrollController.addListener(loadMoreOrders);
    super.onInit();
  }
}
