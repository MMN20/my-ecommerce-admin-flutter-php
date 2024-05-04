import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/controllers/promotions/promotions_page_controller.dart';
import 'package:my_ecommerce_admin/data/model/promotion_model.dart';
import 'package:my_ecommerce_admin/main.dart';
import 'package:my_ecommerce_admin/view/widgets/promotions/promotion_card.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PromotionsPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Promotions"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddPromotionsPage();
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: GetBuilder(
            init: controller,
            builder: (controller) {
              return RequestStatusView(
                onErrorTap: () {},
                requestStatus: controller.requestStatus,
                child: ListView.separated(
                  itemCount: controller.promotions.length,
                  itemBuilder: (context, index) {
                    PromotionModel promotion = controller.promotions[index];
                    return KeepChildAlive(
                      child: PromotionTile(
                        onTap: () {
                          controller.goToEditPromotionPage(promotion);
                        },
                        onLongPress: () {
                          controller.showDeleteDialog(promotion);
                        },
                        promotion: promotion,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0.1,
                      color: Colors.grey,
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
