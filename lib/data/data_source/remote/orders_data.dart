import 'package:dartz/dartz.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/core/class/crud.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';

class OrdersData {
  static Future<dynamic> getPendingOrders(String currentIndex) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.pendingOrder, {"currentIndex": currentIndex});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> getAcceptedOrders(String currentIndex) async {
    Either<RequestStatus, Map> response = await CRUD
        .post(APILinks.getAcceptedOrders, {"currentIndex": currentIndex});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> getArchivedOrders(String currentIndex) async {
    Either<RequestStatus, Map> response = await CRUD
        .post(APILinks.archivedOrders, {"currentIndex": currentIndex});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> getOrderItems(String orderID) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.getOrderItems, {"orderid": orderID});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> prepareOrder(String orderID, String userid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.prepareOrder, {
      "orderid": orderID,
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> acceptOrder(String orderID, String userid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.acceptOrder, {
      "orderid": orderID,
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  // back from Preparing to accept
  static Future<dynamic> backToAcceptOrder(
      String orderID, String userid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.backToAcceptOrder, {
      "orderid": orderID,
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  // back from Preparing to accept
  static Future<dynamic> cancelOrder(
      String orderID, String userid, String message) async {
    Either<RequestStatus, Map> response = await CRUD.post(APILinks.cancelOrder,
        {"orderid": orderID, "userid": userid, 'message': message});
    return response.fold((l) => l, (r) => r);
  }
}
