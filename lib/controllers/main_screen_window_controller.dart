import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/view/screens/home_page.dart';
import 'package:my_ecommerce_admin/view/screens/settings_page.dart';

class MainScreenWindowController extends GetxController {
  int currentPageIndex = 0;

  List<Map<String, dynamic>> pages = [
    {
      "widget": const HomePage(),
      "icon": Icons.home,
    },
    {
      "widget": const SettingsPage(),
      "icon": Icons.settings,
    },
  ];

  void changeCurrentPage(int newIndex) {
    currentPageIndex = newIndex;
    update();
  }

  StreamSubscription? prepareingOrdersTopic;

  void listenToPreparingOrdersTopic() {
    FirebaseMessaging.instance.subscribeToTopic("adminOrders");
    prepareingOrdersTopic = FirebaseMessaging.onMessage.listen((event) {
      Get.snackbar("Order ${event.data['orderid']}", "There is a new order");
    });
  }

  @override
  void onInit() {
    listenToPreparingOrdersTopic();
    super.onInit();
  }

  @override
  void onClose() {
    if (prepareingOrdersTopic != null) {
      prepareingOrdersTopic!.cancel();
    }
    super.onClose();
  }
}
