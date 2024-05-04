import 'package:dartz/dartz.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/core/class/crud.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';

class DeliveryData {
  static Future<dynamic> deliveryData(
      {required String email,
      required String username,
      required String password,
      required String active}) async {
    Either<RequestStatus, Map> response = await CRUD.post(
        APILinks.addDelivery, {
      "email": email,
      "username": username,
      "password": password,
      "active": active
    });
    return response.fold((l) => l, (r) => r);
  }
}
