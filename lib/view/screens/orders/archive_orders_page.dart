import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/archive_orders_page_controller.dart';
import 'package:my_ecommerce_admin/data/model/order_model.dart';
import 'package:my_ecommerce_admin/view/widgets/orders_pages/order_card.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class ArhiveOrdersPage extends StatelessWidget {
  const ArhiveOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ArchiveOrdersPageController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.refreshScreen();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
        title: const Text(
          "Archived orders",
        ),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return RequestStatusView(
              requestStatus: controller.requestStatus,
              onErrorTap: () {},
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
                          // controller.showConfirmDialog(order);
                        },
                        onDetailsTap: () {},
                        onAction: () {
                          controller.backToAccept(order);
                        },
                      ),
                      if (controller.isLoading &&
                          index == controller.orders.length - 1)
                        const Center(child: CircularProgressIndicator())
                    ],
                  );
                },
              ),
            );
          }),
    );
  }
}
