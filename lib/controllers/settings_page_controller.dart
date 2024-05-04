import 'package:get/get.dart';
import 'package:my_ecommerce_admin/main.dart';
import 'package:my_ecommerce_admin/routes.dart';

class SettingsPageController extends GetxController {
  void singOut() async {
    await sharedPref.clear();
    Get.offAllNamed(AppRoutes.loginPage);
  }
}
