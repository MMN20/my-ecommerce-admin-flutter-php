import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/items/add_new_item_page_controller.dart';
import 'package:my_ecommerce_admin/core/functions/validator.dart';
import 'package:my_ecommerce_admin/data/model/category_model.dart';
import 'package:my_ecommerce_admin/data/model/sub_category_model.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:my_ecommerce_admin/view/widgets/my_text_form_field.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class AddNewItemPage extends StatelessWidget {
  const AddNewItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddNewItemPageController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                controller.goToSpecsPage();
              },
              icon: const Icon(Icons.arrow_forward)),
        ],
        title: const Text("Item Information"),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () {
          controller.allertAboutClosingCurrentTree();
          return Future.value(false);
        },
        child: SafeArea(
          child: GetBuilder(
              init: controller,
              builder: (controller) {
                return RequestStatusView(
                  onErrorTap: () {},
                  requestStatus: controller.requestStatus,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Name",
                        icon: const Icon(Icons.description),
                        controller: controller.nameController,
                        validator: (s) {
                          return validator(
                              s!, 2, s.length, "The name is too short", "");
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Description",
                        icon: const Icon(Icons.description),
                        controller: controller.descController,
                        validator: (s) {
                          return validator(s!, 2, s.length,
                              "The description is too short", "");
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Price",
                        icon: const Icon(Icons.attach_money_sharp),
                        controller: controller.priceController,
                        validator: (s) {
                          if (double.tryParse(s!) == null) {
                            return "Please enter a valid number";
                          }
                          return validator(
                              s, 1, s.length, "The number is too short", "");
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Quantity",
                        icon: const Icon(Icons.production_quantity_limits),
                        controller: controller.qtyController,
                        validator: (s) {
                          if (int.tryParse(s!) == null) {
                            return "Please enter a valid number";
                          }
                          return validator(
                              s, 1, s.length, "The quantity is too short", "");
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text("Active: "),
                          Checkbox(
                            value: controller.isActive,
                            onChanged: (val) {
                              controller.changeActiveStatus(val!);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Discount",
                        icon: const Icon(Icons.discount),
                        controller: controller.discountController,
                        validator: (s) {
                          if (double.tryParse(s!) == null) {
                            return "Please enter a valid number";
                          }
                          return validator(
                              s, 1, s.length, "The discount is too short", "");
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text("Category"),
                      DropdownButton<CategoryModel>(
                        value: controller.selectedCategory,
                        items: [
                          ...controller.categories.map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.catName!),
                              ))
                        ],
                        onChanged: (cat) {
                          controller.changeCurrentCategory(cat!);
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text("Subcategory"),
                      DropdownButton<SubCategoryModel>(
                        value: controller.selectedSubCategory,
                        items: [
                          ...controller.subCategories.map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.subcatName!),
                            ),
                          ),
                        ],
                        onChanged: (subcat) {
                          controller.selectSubCategory(subcat!);
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
