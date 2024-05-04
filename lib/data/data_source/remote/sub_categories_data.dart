import 'package:dartz/dartz.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/core/class/crud.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';

class SubCategoriesData {
  static Future<dynamic> getAllSubCategories(String subcatID) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.allSubCategories, {"catid": subcatID});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> addSubCategory(
      String name, String desc, String catid) async {
    Either<RequestStatus, Map> response = await CRUD.post(
      APILinks.addSubCategories,
      {
        "catid": catid,
        "subcatName": name,
        "subcatDesc": desc,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> editSubCategory(
      String subcatid, String name, String desc) async {
    Either<RequestStatus, Map> response = await CRUD.post(
      APILinks.editSubCategories,
      {
        "subcatid": subcatid,
        "subcatName": name,
        "subcatDesc": desc,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> deleteSubCategory(String subcatid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.deleteSubCategories, {"subcatid": subcatid});
    return response.fold((l) => l, (r) => r);
  }
}
