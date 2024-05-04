import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/categories/categories_page_controller.dart';
import 'package:my_ecommerce_admin/view/widgets/categories/category_card.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesPageController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddCategoryPage();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return RequestStatusView(
              onErrorTap: () {},
              requestStatus: controller.requestStatus,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...controller.categories.map(
                      (e) => Card(
                        child: CategoryCard(
                          categoryModel: e,
                          onDeleteTap: () {
                            controller.showConfirmDeletingDialog(e);
                          },
                          onInfoTap: () {
                            controller.goToEditCategoryPage(e);
                          },
                          onTap: () {
                            controller.goToSubCategoriesPage(e);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            );
          }),
    );
  }
}
