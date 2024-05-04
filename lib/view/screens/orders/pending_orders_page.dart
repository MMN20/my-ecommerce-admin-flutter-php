import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/pending_orders_page_controller.dart';
import 'package:my_ecommerce_admin/data/model/order_model.dart';
import 'package:my_ecommerce_admin/view/widgets/orders_pages/order_card.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class PendingOrdersPage extends StatelessWidget {
  const PendingOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PendingOrdersPageController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                controller.refreshScreen();
              },
              icon: const Icon(Icons.refresh))
        ],
        title: const Text(
          "Pending Orders",
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder(
            init: controller,
            builder: (controller) {
              return RequestStatusView(
                onErrorTap: () {
                  controller.removeError();
                },
                requestStatus: controller.requestStatus,
                child: ListView.separated(
                  controller: controller.scrollController,
                  itemCount: controller.orders.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                  itemBuilder: (context, index) {
                    OrderModel order = controller.orders[index];
                    return Column(
                      children: [
                        OrderForAcceptedAndPending(
                          order: order,
                          index: index,
                          onCancelTap: () {
                            controller.showConfirmDialog(order);
                          },
                          onDetailsTap: () {
                            controller.goToOrderDetailsPage(order);
                          },
                          onAction: () {
                            controller.acceptOrder(order);
                          },
                        ),
                        if (controller.isLoading &&
                            index == controller.orders.length - 1)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
