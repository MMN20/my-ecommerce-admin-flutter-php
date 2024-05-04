import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/core/class/crud.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';

class CategoriesData {
  static Future<dynamic> getAllCategories() async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.allCategories, {});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> addCategory(
    File? file,
    String name,
    String desc,
  ) async {
    Either<RequestStatus, Map<String, dynamic>> response =
        await CRUD.uploadSingleFile(
            file,
            {
              "catName": name,
              "catDesc": desc,
            },
            APILinks.addCategories);
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> editCategory(
    File? file,
    String catid,
    String name,
    String desc,
  ) async {
    Either<RequestStatus, Map<String, dynamic>> response =
        await CRUD.uploadSingleFile(
            file,
            {
              "catid": catid,
              "catName": name,
              "catDesc": desc,
            },
            APILinks.editCategories);
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> deleteCategory(String catid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.deleteCategories, {"catid": catid});
    return response.fold((l) => l, (r) => r);
  }
}
