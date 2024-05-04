import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_ecommerce_admin/controllers/orders_main_screen_window_controller.dart';
import 'package:my_ecommerce_admin/core/constants/colors.dart';
import 'package:my_ecommerce_admin/main.dart';

class OrdersMainScreenWindow extends StatelessWidget {
  const OrdersMainScreenWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersMainScreenWindowContrller());
    return Scaffold(
      bottomNavigationBar: GetBuilder(
          init: controller,
          builder: (controller) {
            return Theme(
              data: ThemeData(
                  backgroundColor: AppColors.secondColor30,
                  splashFactory: NoSplash.splashFactory),
              child: BottomNavigationBar(
                selectedItemColor: AppColors.thirdColor10,
                currentIndex: controller.currentPageIndex,
                onTap: (newIndex) {
                  controller.changePageIndex(newIndex);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.circle, color: Colors.orange),
                    label: "Pending",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.circle, color: Colors.green),
                    label: "Accepted",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.circle),
                    label: "Archive",
                  ),
                ],
              ),
            );
          }),
      body: KeepChildAlive(
        child: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.pages,
          onPageChanged: (value) {},
        ),
      ),
    );
  }
}
