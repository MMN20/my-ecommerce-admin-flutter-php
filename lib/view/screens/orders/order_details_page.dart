import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_ecommerce_admin/controllers/order_dedtails_page_controller.dart';
import 'package:my_ecommerce_admin/core/functions/get_price_and_currency.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:my_ecommerce_admin/view/widgets/order_details_page/item_card.dart';
import 'package:my_ecommerce_admin/view/widgets/orders_pages/order_data.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsPageController());
    double orderPrice;

    if (controller.orderModel.priceAfterCoupon == null) {
      orderPrice = controller.orderModel.fullPrice!;
    } else {
      orderPrice = controller.orderModel.priceAfterCoupon!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order details"),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderData(
                        name: "Order ID",
                        value: controller.orderModel.ordersId.toString(),
                      ),
                      const Divider(thickness: 0.2),
                      OrderData(
                        name: "Order Status",
                        value: controller.orderModel.orderStatusName!,
                      ),
                      const Divider(thickness: 0.2),
                      if (controller.orderModel.addressesName != null)
                        Column(
                          children: [
                            OrderData(
                              name: "Order Address",
                              value: controller.orderModel.addressesName!,
                            ),
                            const Divider(thickness: 0.2),
                          ],
                        ),
                      OrderData(
                        name: "Delivery Type",
                        value: controller.orderModel.ordersTypeName!,
                      ),
                      const Divider(thickness: 0.2),
                      OrderData(
                        name: "Used a Coupon?",
                        value: controller.orderModel.isUsedCoupon == 1
                            ? "Yes"
                            : "No",
                      ),
                      const Divider(thickness: 0.2),
                      OrderData(
                        name: "Delivery Type",
                        value: controller.orderModel.ordersTypeName!,
                      ),
                      const Divider(thickness: 0.2),
                      OrderData(
                        name: "Payment Method",
                        value: controller.orderModel.paymentMethodsName!,
                      ),
                      const Divider(thickness: 0.2),
                      OrderData(
                        name: "Date Ordered",
                        value:
                            Jiffy.parse(controller.orderModel.ordersDatetime!)
                                .format(pattern: "dd-MM-yyyy hh:mm a"),
                      ),
                      const Divider(thickness: 0.2),
                      if (controller.orderModel.priceAfterCoupon != null)
                        Column(
                          children: [
                            OrderData(
                              name: "Price without coupon",
                              value: getPriceAndCurrency(
                                  controller.orderModel.fullPrice!),
                            ),
                            const Divider(thickness: 0.2),
                          ],
                        ),
                      if (controller.orderModel.ordersTypeid == 1)
                        Column(
                          children: [
                            OrderData(
                              name: "Delivering price",
                              value: getPriceAndCurrency(
                                  controller.orderModel.ordersDeliveryprice!),
                            ),
                            const Divider(thickness: 0.2),
                          ],
                        ),
                      OrderData(
                        name: "Price",
                        value: getPriceAndCurrency(orderPrice),
                      ),
                      if (controller.orderModel.ordersAddressid != null)
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: GeneralButton(
                                  onPressed: () {
                                    controller.openGoogleMaps();
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Map location"),
                                      SizedBox(width: 5),
                                      Icon(Icons.location_on_sharp)
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      const Text("Items"),
                    ],
                  ),
                ),
                RequestStatusView(
                  onErrorTap: () {},
                  requestStatus: controller.requestStatus,
                  child: Column(
                    children: [
                      ...List.generate(
                          controller.items.length,
                          (index) => ItemCard(
                                item: controller.items[index],
                                onCartTap: () {
                                  //! implement
                                  // controller.goToItemDetailsPage(
                                  //     controller.items[index].item);
                                },
                                amount: controller.items[index].cartAmount!,
                              ))
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
