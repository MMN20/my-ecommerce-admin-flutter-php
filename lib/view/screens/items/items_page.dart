import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/items/items_page_controller.dart';
import 'package:my_ecommerce_admin/view/widgets/items/items_page_card.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemsPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ItemsPageCard(
              onTap: () {
                controller.goToSearchForItemsPage();
              },
              text: "Search for items",
              trailing: const Icon(Icons.search),
            ),
            const SizedBox(height: 5),
            ItemsPageCard(
              onTap: () {
                controller.goToAddNewItemPage();
              },
              text: "Add new item",
              trailing: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
