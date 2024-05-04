import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/categories/add_edit_subcategory_page_controller.dart';
import 'package:my_ecommerce_admin/core/functions/validator.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:my_ecommerce_admin/view/widgets/my_text_form_field.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class AddEditSubCategoryPage extends StatelessWidget {
  const AddEditSubCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddEditSubCategoryPageController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GetBuilder(
            init: controller,
            builder: (controller) {
              return RequestStatusView(
                onErrorTap: () {},
                requestStatus: controller.requestStatus,
                child: Form(
                  key: controller.globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextFormField(
                        labelText: "Name",
                        icon: const Icon(Icons.category),
                        controller: controller.nameController,
                        validator: (s) {
                          return validator(
                              s!, 1, s.length, "The name is too short", "");
                        },
                        hintText: "Name",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField(
                        labelText: "Description",
                        icon: const Icon(Icons.description),
                        controller: controller.descController,
                        validator: (s) {
                          return validator(s!, 0, s.length, "", "", true);
                        },
                        hintText: "Description",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GeneralButton(
                        onPressed: () {
                          if (controller.isAdd) {
                            controller.addSubCategory();
                          } else {
                            print(controller.subcategoryModel.catId);
                            controller
                                .editSubCategory(controller.subcategoryModel);
                          }
                        },
                        child: const Text("Save"),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
