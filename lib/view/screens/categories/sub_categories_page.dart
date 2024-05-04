import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/categories/sub_categories_page_controller.dart';
import 'package:my_ecommerce_admin/data/model/category_model.dart';
import 'package:my_ecommerce_admin/data/model/sub_category_model.dart';
import 'package:my_ecommerce_admin/view/widgets/categories/category_card.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class SubCategoriesPage extends StatelessWidget {
  const SubCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubCategoriesPageController());
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.category.catName!),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddSubCategory();
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder(
        init: controller,
        builder: (controller) {
          return RequestStatusView(
            onErrorTap: () {},
            requestStatus: controller.requestStatus,
            child: ListView.builder(
              itemCount: controller.subCategories.length,
              itemBuilder: (context, index) {
                SubCategoryModel subCategoryModel =
                    controller.subCategories[index];
                print(subCategoryModel.catId);
                CategoryModel categoryModel =
                    controller.subCategories[index].toCategoryModel();
                if (index == controller.subCategories.length - 1) {
                  return Column(
                    children: [
                      CategoryCard(
                        categoryModel: categoryModel,
                        onDeleteTap: () {
                          controller
                              .showConfirmDeletingDialog(subCategoryModel);
                        },
                        onInfoTap: () {
                          controller.goToEditSubCategory(subCategoryModel);
                        },
                        onTap: () {},
                      ),
                      const SizedBox(height: 100)
                    ],
                  );
                }
                return CategoryCard(
                  categoryModel: categoryModel,
                  onDeleteTap: () {
                    controller.showConfirmDeletingDialog(subCategoryModel);
                  },
                  onInfoTap: () {
                    print(controller.subCategories[index].subcatId);
                    controller.goToEditSubCategory(subCategoryModel);
                  },
                  onTap: () {},
                );
              },
            ),
          );
        },
      ),
    );
  }
}
