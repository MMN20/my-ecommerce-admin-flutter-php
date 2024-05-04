import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/core/class/crud.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';

class PromotionsData {
  static Future<dynamic> getAllPromotions() async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.allPromotions, {});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> addPromotion(
      File file, String title, String body) async {
    Either<RequestStatus, Map> response = await CRUD.uploadSingleFile(
        file,
        {
          'title': title,
          'body': body,
        },
        APILinks.addPromotion);
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> updatePromotion(
      File? file, String promotionsId, String title, String body) async {
    Either<RequestStatus, Map> response = await CRUD.uploadSingleFile(
        file,
        {'title': title, 'body': body, 'id': promotionsId},
        APILinks.updatePromotion);
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> deletePromotion(String promotionID) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.deletePromotion, {"id": promotionID});
    return response.fold((l) => l, (r) => r);
  }
}
