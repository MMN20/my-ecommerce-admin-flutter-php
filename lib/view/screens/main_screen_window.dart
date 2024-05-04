import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/main_screen_window_controller.dart';
import 'package:my_ecommerce_admin/view/widgets/main_screen_window/custom_navigation_bar.dart';

class MainScreenWindow extends StatelessWidget {
  const MainScreenWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainScreenWindowController());
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              IndexedStack(
                index: controller.currentPageIndex,
                children: List.generate(
                  controller.pages.length,
                  (index) {
                    return controller.pages[index]['widget']!;
                  },
                ),
              ),
              CustomNavigationBar(
                children: List.generate(controller.pages.length, (index) {
                  return InkWell(
                    onTap: () {
                      controller.changeCurrentPage(index);
                    },
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: index == controller.currentPageIndex ? 1.2 : 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          controller.pages[index]['icon']!,
                          color: index == controller.currentPageIndex
                              ? Colors.white
                              : null,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
