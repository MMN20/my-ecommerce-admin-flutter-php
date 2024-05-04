import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/controllers/categories/add_edit_category_page_controller.dart';
import 'package:my_ecommerce_admin/core/functions/validator.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:my_ecommerce_admin/view/widgets/my_text_form_field.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class AddEditCategoryPage extends StatelessWidget {
  const AddEditCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddEditCategoryPageController());
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isAdd ? "Add category" : "Edit category"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                              return validator(s!, 1, s.length,
                                  "The Description is too short", "");
                            },
                            hintText: "Description",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (!controller.isAdd && controller.image == null)
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: controller.categoryModel.catImageUrl!
                                      .toLowerCase()
                                      .endsWith("svg")
                                  ? SvgPicture.network(
                                      "${APILinks.categoriesImages}/${controller.categoryModel.catImageUrl}",
                                    )
                                  : Image.network(
                                      "${APILinks.categoriesImages}/${controller.categoryModel.catImageUrl}",
                                    ),
                            ),
                          if (controller.image != null)
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: controller.image!.path
                                      .toLowerCase()
                                      .endsWith("svg")
                                  ? SvgPicture.file(
                                      controller.image!,
                                    )
                                  : Image.file(
                                      controller.image!,
                                    ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          GeneralButton(
                            onPressed: () {
                              controller.showImageSourceDialog();
                            },
                            child: Text(controller.isAdd
                                ? controller.image == null
                                    ? "Add"
                                    : "Change"
                                : "Change"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GeneralButton(
                            onPressed: () {
                              if (controller.isAdd) {
                                controller.addCategory();
                              } else {
                                controller
                                    .editCategory(controller.categoryModel);
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
        ),
      ),
    );
  }
}
