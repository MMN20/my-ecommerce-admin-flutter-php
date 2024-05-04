import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/controllers/promotions/add_promotion_page_controller.dart';
import 'package:my_ecommerce_admin/core/functions/validator.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:my_ecommerce_admin/view/widgets/my_text_form_field.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class AddPromotionPage extends StatelessWidget {
  const AddPromotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddPromotionPageController());
    return Scaffold(
      body: Form(
        key: controller.globalKey,
        child: GetBuilder(
            init: controller,
            builder: (controller) {
              return RequestStatusView(
                onErrorTap: () {},
                requestStatus: controller.requestStatus,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextFormField(
                        labelText: "Title",
                        icon: const Icon(Icons.title_rounded),
                        controller: controller.titleController,
                        validator: (s) {
                          return validator(
                              s!, 1, s.length, "Please enter the title", "");
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Body",
                        icon: const Icon(Icons.description),
                        controller: controller.bodyController,
                      ),
                      if (controller.image != null)
                        Image.file(controller.image!, height: 200, width: 200),
                      if (controller.image == null && !controller.isAddMode)
                        Image.network(
                          "${APILinks.promotionImages}/${controller.promotionModel!.promotionsImageUrl!}",
                          height: 200,
                          width: 200,
                          // color: Colors.grey,
                          // colorBlendMode: BlendMode.clear,
                        ),
                      const SizedBox(height: 10),
                      GeneralButton(
                        onPressed: () {
                          controller.imageSourceDialog();
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Pick an image"),
                            SizedBox(width: 10),
                            Icon(Icons.upload)
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      GeneralButton(
                        onPressed: () {
                          if (controller.isAddMode) {
                            controller.addPromotion();
                          } else {
                            controller.updatePromotion();
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
