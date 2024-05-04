class APILinks {
  // add the link of your server here
  static const String _server = "https://example.com/myecommerce/admin";
  static const String itemImages =
      "https://mustafa2000.com/myecommerce/upload/items";

  static const String categoriesImages =
      "https://mustafa2000.com/myecommerce/upload/categories";

  static const String promotionImages =
      "https://mustafa2000.com/myecommerce/upload/promotions";

  // Auth
  static const String login = "$_server/auth/login.php";

  // Orders
  static const String pendingOrder = "$_server/orders/get_pending_orders.php";
  static const String getAcceptedOrders =
      "$_server/orders/get_accepted_orders.php";
  static const String getOrderItems = "$_server/orders/get_order_items.php";
  static const String acceptOrder = "$_server/orders/accept_order.php";
  static const String prepareOrder = "$_server/orders/prepare_order.php";
  static const String archivedOrders = "$_server/orders/get_archived_order.php";
  static const String backToAcceptOrder = "$_server/orders/back_to_accept.php";
  static const String cancelOrder = "$_server/orders/cancel_order.php";
  // Categories
  static const String allCategories = "$_server/categories/all_categories.php";
  static const String addCategories = "$_server/categories/add_category.php";
  static const String editCategories = "$_server/categories/edit_category.php";
  static const String deleteCategories =
      "$_server/categories/delete_category.php";

  // SubCategories
  static const String allSubCategories =
      "$_server/sub_categories/all_subcategories.php";
  static const String addSubCategories =
      "$_server/sub_categories/add_subcategory.php";
  static const String deleteSubCategories =
      "$_server/sub_categories/delete_subcategory.php";
  static const String editSubCategories =
      "$_server/sub_categories/edit_subcategory.php";

  // Items
  static const String addItems = "$_server/items/add_items.php";
  static const String searchForItems = "$_server/items/search.php";
  static const String itemDetails = "$_server/items/item_details.php";
  static const String updateItem = "$_server/items/update_item.php";

  // Promotions
  static const String allPromotions = "$_server/promotions/all_promotions.php";
  static const String addPromotion = "$_server/promotions/add_promotion.php";
  static const String deletePromotion =
      "$_server/promotions/delete_promotion.php";
  static const String updatePromotion =
      "$_server/promotions/update_promotion.php";

  // Delivery
  static const String addDelivery = "$_server/delivery/add_delivery.php";
}
