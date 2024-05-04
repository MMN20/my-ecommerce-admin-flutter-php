import 'package:get/get.dart';
import 'package:my_ecommerce_admin/routes.dart';

class ItemsPageController extends GetxController {
  void goToAddNewItemPage() {
    Get.toNamed(AppRoutes.addNewItemPage);
  }

  void goToSearchForItemsPage() {
    Get.toNamed(AppRoutes.searchForItems);
  }
}
