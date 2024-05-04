import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/home_page_controller.dart';
import 'package:my_ecommerce_admin/core/constants/app_assets.dart';
import 'package:my_ecommerce_admin/view/widgets/home_page/item_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());
    return Scaffold(
      body: SafeArea(
        child: GridView(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85, crossAxisCount: 3),
          children: [
            ItemCard(
              assets: AppAssets.items,
              name: "Items",
              onTap: () {
                controller.goToItemsPage();
              },
            ),
            ItemCard(
              assets: AppAssets.categories,
              name: "Categories",
              onTap: () {
                controller.goToCategoriesPage();
              },
            ),
            ItemCard(
              assets: AppAssets.orders,
              name: "Orders",
              onTap: () {
                controller.goToOrdersPage();
              },
            ),
            ItemCard(
              assets: AppAssets.promotions,
              name: "Promotions",
              onTap: () {
                controller.goToPromotionsPage();
              },
            ),
            ItemCard(
              assets: AppAssets.delivery,
              name: "Deliverers",
              onTap: () {
                controller.goToDeliveryPage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
