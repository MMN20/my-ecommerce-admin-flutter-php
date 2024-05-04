import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/items/add_images_page_controller.dart';
import 'package:my_ecommerce_admin/core/constants/colors.dart';
import 'package:my_ecommerce_admin/main.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class AddImagesPage extends StatelessWidget {
  const AddImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddImagesPageController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Images"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.saveItemData();
              },
              icon: const Icon(Icons.arrow_forward)),
        ],
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return RequestStatusView(
              onErrorTap: () {},
              requestStatus: controller.requestStatus,
              child: Column(
                children: [
                  Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              onPageChanged: (value) {
                                controller.changeCurrentImage(value);
                              },
                              itemCount: controller.images.length,
                              itemBuilder: (context, index) {
                                return KeepChildAlive(
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image.file(
                                          controller.images[index],
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: IconButton(
                                          onPressed: () {
                                            controller.removeImage(index);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List<Widget>.generate(
                                controller.images.length,
                                (index) {
                                  bool isCurrentIndex =
                                      index == controller.currentImageIndex;
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        color: AppColors.thirdColor10
                                            .withOpacity(
                                                isCurrentIndex ? 1 : 0.3),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GeneralButton(
                        minSize: const Size(double.infinity, 40),
                        onPressed: () {
                          controller.showImageSourceDialog();
                        },
                        child: const Text("Add image"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }),
    );
  }
}
