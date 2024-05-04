import 'package:get/get.dart';
import 'package:my_ecommerce_admin/routes.dart';

class HomePageController extends GetxController {
  void goToOrdersPage() {
    Get.toNamed(AppRoutes.ordersWindow);
  }

  void goToPromotionsPage() {
    Get.toNamed(AppRoutes.promotionsPage);
  }

  void goToCategoriesPage() {
    Get.toNamed(AppRoutes.categoriesPage);
  }

  void goToItemsPage() {
    Get.toNamed(AppRoutes.itemsPage);
  }

  void goToDeliveryPage() {
    Get.toNamed(AppRoutes.deliveryPage);
  }
}
