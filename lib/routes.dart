import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_ecommerce_admin/core/middleware/login_middleware.dart';
import 'package:my_ecommerce_admin/main.dart';
import 'package:my_ecommerce_admin/view/screens/categories/add_edit_subcategory_page.dart';
import 'package:my_ecommerce_admin/view/screens/categories/sub_categories_page.dart';
import 'package:my_ecommerce_admin/view/screens/categories/add_edit_category_page.dart';
import 'package:my_ecommerce_admin/view/screens/categories/categories_page.dart';
import 'package:my_ecommerce_admin/view/screens/delivery/add_delivery_page.dart';
import 'package:my_ecommerce_admin/view/screens/delivery/delivery_page.dart';
import 'package:my_ecommerce_admin/view/screens/home_page.dart';
import 'package:my_ecommerce_admin/view/screens/items/add_images_page.dart';
import 'package:my_ecommerce_admin/view/screens/items/add_new_item_page.dart';
import 'package:my_ecommerce_admin/view/screens/items/add_specs_page.dart';
import 'package:my_ecommerce_admin/view/screens/items/edit_item_details_page.dart';
import 'package:my_ecommerce_admin/view/screens/items/edit_item_specs_page.dart';
import 'package:my_ecommerce_admin/view/screens/items/item_details_page.dart';
import 'package:my_ecommerce_admin/view/screens/items/items_page.dart';
import 'package:my_ecommerce_admin/view/screens/items/search_for_items_page.dart';
import 'package:my_ecommerce_admin/view/screens/login_page.dart';
import 'package:my_ecommerce_admin/view/screens/main_screen_window.dart';
import 'package:my_ecommerce_admin/view/screens/orders/order_details_page.dart';
import 'package:my_ecommerce_admin/view/screens/orders/orders_main_screen_window.dart';
import 'package:my_ecommerce_admin/view/screens/orders/pending_orders_page.dart';
import 'package:my_ecommerce_admin/view/screens/other_page.dart';
import 'package:my_ecommerce_admin/view/screens/promotions/add_promotion_page.dart';
import 'package:my_ecommerce_admin/view/screens/promotions/promotions_page.dart';

class AppRoutes {
  static const String mainScreen = "/mainScreen";
  static const String homePage = "/homePage";
  static const String otherPage = "/otherPage";
  static const String ordersPage = "/ordersPage";
  static const String ordersDetailsPage = "/ordersDetailsPage";
  static const String ordersWindow = "/ordersWindow";
  static const String loginPage = "/";
  // categories
  static const String categoriesPage = "/categoriesPage";
  static const String addEditCategory = "/addEditCategory";

  // SubCategories
  static const String subCategories = "/subCategories";
  static const String addEditSubCategories = "/addEditSubCategories";

  // items
  static const String itemsPage = "/itemsPage";
  static const String addNewItemPage = "/addNewItemPage";
  static const String addSpecsPage = "/addSpecsPage";
  static const String addImagesPage = "/addImagesPage";
  static const String searchForItems = "/searchForItems";
  static const String itemDetailsPage = "/itemDetailsPage";
  static const String editItemDetailsPage = "/editItemDetailsPage";
  static const String editItemSpecsPage = "/editItemSpecsPage";
  static const String promotionsPage = "/promotionsPage";
  static const String addEditPromotionsPage = "/addPromotionsPage";
  static const String deliveryPage = "/deliveryPage";
  static const String addDeliveryPage = "/addDeliveryPage";
}

List<GetPage> pages = [
  GetPage(name: AppRoutes.mainScreen, page: () => const MainScreenWindow()),
  GetPage(name: AppRoutes.homePage, page: () => const HomePage()),
  GetPage(name: AppRoutes.otherPage, page: () => const OtherPage()),
  GetPage(name: AppRoutes.ordersPage, page: () => const PendingOrdersPage()),
  GetPage(
      name: AppRoutes.ordersDetailsPage, page: () => const OrderDetailsPage()),
  GetPage(
      name: AppRoutes.ordersWindow, page: () => const OrdersMainScreenWindow()),
  GetPage(name: AppRoutes.categoriesPage, page: () => const CategoriesPage()),
  GetPage(
      name: AppRoutes.addEditCategory, page: () => const AddEditCategoryPage()),
  GetPage(name: AppRoutes.subCategories, page: () => const SubCategoriesPage()),
  GetPage(
      name: AppRoutes.addEditSubCategories,
      page: () => const AddEditSubCategoryPage()),
  GetPage(name: AppRoutes.itemsPage, page: () => const ItemsPage()),
  GetPage(name: AppRoutes.addNewItemPage, page: () => const AddNewItemPage()),
  GetPage(name: AppRoutes.addSpecsPage, page: () => const AddSpecsPage()),
  GetPage(name: AppRoutes.addImagesPage, page: () => const AddImagesPage()),
  GetPage(
      name: AppRoutes.searchForItems, page: () => const SearhcForItemsPage()),
  GetPage(name: AppRoutes.itemDetailsPage, page: () => const ItemDetailsPage()),
  GetPage(
      name: AppRoutes.editItemSpecsPage, page: () => const EditItemSpecsPage()),
  GetPage(
      name: AppRoutes.editItemDetailsPage,
      page: () => const EditItemDetailsPage()),
  GetPage(name: AppRoutes.promotionsPage, page: () => const PromotionsPage()),
  GetPage(name: AppRoutes.deliveryPage, page: () => const DeliveryPage()),
  GetPage(name: AppRoutes.addDeliveryPage, page: () => const AddDeliveryPage()),
  GetPage(
      name: AppRoutes.addEditPromotionsPage,
      page: () => const AddPromotionPage()),
  GetPage(
    name: AppRoutes.loginPage,
    page: () => const LoginPage(),
    middlewares: [LoginMiddleWare()],
  ),
];
