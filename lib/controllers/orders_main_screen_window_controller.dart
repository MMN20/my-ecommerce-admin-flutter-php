import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/main.dart';
import 'package:my_ecommerce_admin/view/screens/orders/accepted_orders_page.dart';
import 'package:my_ecommerce_admin/view/screens/orders/archive_orders_page.dart';
import 'package:my_ecommerce_admin/view/screens/orders/pending_orders_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class OrdersMainScreenWindowContrller extends GetxController {
  int currentPageIndex = 0;

  List<Widget> pages = [
    const KeepChildAlive(child: PendingOrdersPage()),
    const KeepChildAlive(child: AcceptedOrdersPage()),
    const KeepChildAlive(child: ArhiveOrdersPage()),
  ];

  PageController pageController = PageController();

  void changePageIndex(int newIndex) {
    currentPageIndex = newIndex;
    pageController.jumpToPage(newIndex);
    update();
  }
}
