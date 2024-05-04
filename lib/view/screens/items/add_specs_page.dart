import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/items/add_specs_page_controller.dart';
import 'package:my_ecommerce_admin/view/widgets/my_text_form_field.dart';

class AddSpecsPage extends StatelessWidget {
  const AddSpecsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddSpecsPageController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                controller.goToImagesPage();
              },
              icon: const Icon(Icons.arrow_forward)),
        ],
        title: const Text("Specifications"),
      ),
      body: SafeArea(
        child: GetBuilder(
            init: controller,
            builder: (controller) {
              return ListView.builder(
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
                        onChange: controller.controllers.length == index + 1
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
