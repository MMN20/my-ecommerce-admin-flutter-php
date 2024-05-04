import 'package:flutter/material.dart';
import 'package:my_ecommerce_admin/core/constants/colors.dart';
import 'package:my_ecommerce_admin/core/functions/get_price_and_currency.dart';
import 'package:my_ecommerce_admin/data/model/order_model.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:my_ecommerce_admin/view/widgets/orders_pages/order_data.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      this.valueStyle =
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      required this.values,
      required this.color,
      required this.orderModel,
      required this.onDeleteTap,
      required this.onDetailsTap,
      required this.onAction});
  final List<OrderValue> values;
  final TextStyle valueStyle;
  final OrderModel orderModel;
  final Color color;
  final void Function() onDeleteTap;
  final void Function() onDetailsTap;
  // this is the button the will behave for the current orderStatus
  final void Function() onAction;
  @override
  Widget build(BuildContext context) {
    String actionName = getActionName(orderModel.ordersStatusid!);

    return InkWell(
      onTap: onDetailsTap,
      child: Card(
        color: color,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ...List.generate(
                values.length,
                ((index) {
                  return Column(
                    children: [
                      OrderData(
                        name: "${values[index].name}",
                        value: values[index].value,
                      ),
                      if (index + 1 < values.length)
                        const Divider(thickness: 0.2)
                    ],
                  );
                }),
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GeneralButton(
                    onPressed: onDetailsTap,
                    child: const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text("Details"),
                    ),
                  ),
                  GeneralButton(
                    onPressed: onAction,
                    backgroundColor: actionName == "Accept"
                        ? Colors.green
                        : AppColors.thirdColor10,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(actionName),
                    ),
                  ),
                  if (orderModel.ordersStatusid! <= 2)
                    GeneralButton(
                      backgroundColor: Colors.red,
                      onPressed: onDeleteTap,
                      child: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text("Cancel"),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderForAcceptedAndPending extends StatelessWidget {
  const OrderForAcceptedAndPending(
      {super.key,
      required this.order,
      required this.index,
      required this.onCancelTap,
      required this.onDetailsTap,
      required this.onAction});
  final OrderModel order;
  final int index;
  final void Function() onCancelTap;
  final void Function() onDetailsTap;
  final void Function() onAction;

  @override
  Widget build(BuildContext context) {
    double orderPrice;
    if (order.isUsedCoupon == 1) {
      orderPrice = order.priceAfterCoupon!;
    } else {
      orderPrice = order.fullPrice!;
    }
    return OrderCard(
      values: [
        OrderValue(name: "Order ID", value: order.ordersId.toString()),
        OrderValue(name: "Status", value: order.orderStatusName!),
        if (order.addressesName != null)
          OrderValue(name: "Address", value: order.addressesName!),
        if (order.addressesName != null)
          OrderValue(name: "Address desc", value: order.addressDesc!),
        OrderValue(name: "Order type", value: order.ordersTypeName!),
        OrderValue(name: "Price", value: getPriceAndCurrency(orderPrice)),
        if (order.ordersDeliveryprice != null)
          OrderValue(
              name: "Delivering Price",
              value: getPriceAndCurrency(order.ordersDeliveryprice!)),
        OrderValue(name: "Payment method", value: order.paymentMethodsName!),
      ],
      color: index.isEven ? AppColors.secondColor30 : AppColors.mainColor60,
      orderModel: order,
      onDeleteTap: onCancelTap,
      onDetailsTap: onDetailsTap,
      onAction: onAction,
    );
  }
}

String getActionName(int currenttatusID) {
  if (currenttatusID == 1) {
    return "Accept";
  } else if (currenttatusID == 2) {
    return "Prepare";
  } else {
    return "Back to accepted";
  }
}

class OrderValue {
  final String name;
  final String value;

  const OrderValue({required this.name, required this.value});
}
