import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/items/edit_item_specs_controller.dart';
import 'package:my_ecommerce_admin/view/widgets/my_text_form_field.dart';

class EditItemSpecsPage extends StatelessWidget {
  const EditItemSpecsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditItemSpecsPageController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              controller.saveItemData();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("Save"),
            ),
          ),
        ],
        title: const Text("Specifications"),
      ),
      body: SafeArea(
        child: GetBuilder(
            init: controller,
            builder: (controller) {
              return controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: controller.controllers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(height: 10),
                            MyTextFormField(
                              labelText: "Specfication",
                              icon: const Icon(Icons.description_outlined),
                              controller: controller.controllers[index],
                              onChange:
                                  controller.controllers.length == index + 1
                                      ? (val) {
                                          controller.addNewTextField();
                                        }
                                      : null,
                            ),
                          ],
                        );
                      },
                    );
            }),
      ),
    );
  }
}
