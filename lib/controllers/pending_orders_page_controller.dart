import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/orders_data.dart';
import 'package:my_ecommerce_admin/data/model/order_model.dart';
import 'package:my_ecommerce_admin/routes.dart';
import 'package:my_ecommerce_admin/view/widgets/orders_pages/cancel_order_dialog.dart';
import 'package:my_ecommerce_admin/view/widgets/orders_pages/delete_order_dialog.dart';

class PendingOrdersPageController extends GetxController {
  List<OrderModel> orders = [];
  RequestStatus requestStatus = RequestStatus.none;
  TextEditingController cancelController = TextEditingController();

  int maxOrders = 0;
  // this is the pagination loading
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  Future<void> fetchMoreOrders() async {
    if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels &&
        orders.length < maxOrders) {
      if (!isLoading) {
        isLoading = true;
        getPendingOrders(false);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          scrollController.position.moveTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100));
        });
      }
    }
  }

  void refreshScreen() {
    orders.clear();
    getPendingOrders();
  }

  Future<void> getPendingOrders([bool loadingStatus = true]) async {
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
        await OrdersData.getPendingOrders(currentIndex.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        // the max number of the orders in the data base (that has the status_id == 1)
        maxOrders = response['maxOrders'];
        orders.addAll(responseData.map((e) => OrderModel.fromJson(e)).toList());
      } else if (response['status'] == 'failure' && orders.isEmpty) {
        requestStatus = RequestStatus.empty;
      }
    }
    isLoading = false;
    update();
  }

  Future<void> acceptOrder(OrderModel orderModel) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.acceptOrder(
        orderModel.ordersId.toString(), orderModel.userId.toString());
    requestStatus = hanldeRequestData(response);

    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        orders.remove(orderModel);
        update();
        Get.snackbar("Sucess", "The order was accepted successfully!");
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
    Get.dialog(DeleteOrderDialog(
      controller: cancelController,
      onDeleteTap: () {
        Get.back();
        cancelOrder(orderModel);
      },
    ));
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

  void removeError() {
    requestStatus = RequestStatus.none;
    update();
  }

  void goToOrderDetailsPage(OrderModel orderModel) {
    Get.toNamed(AppRoutes.ordersDetailsPage,
        arguments: {"orderModel": orderModel});
  }

  @override
  void onInit() {
    getPendingOrders();
    scrollController.addListener(fetchMoreOrders);
    super.onInit();
  }

  @override
  void onClose() {
    cancelController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
