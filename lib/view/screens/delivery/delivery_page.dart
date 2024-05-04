import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/delivery/deliver_page_controller.dart';
import 'package:my_ecommerce_admin/view/widgets/delivery/delivery_page_card.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeliveryPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Page"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            DeliveryPageCard(
              onTap: controller.goToAddDeliveryAccountPage,
              text: "Add a Delivery Account",
              trailing: const Icon(Icons.person_2_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
