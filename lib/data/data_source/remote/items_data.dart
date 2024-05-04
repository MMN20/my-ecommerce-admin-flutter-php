import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/core/class/crud.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';

class ItemsData {
  static Future<dynamic> saveItem(
      Map<String, String> data, List<File> files) async {
    Either<RequestStatus, Map> response = await CRUD.uploadMultipleFiles(files,
        data, "https://mustafa2000.com/myecommerce/admin/items/add_item.php");
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> search(String word) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.searchForItems, {'word': word});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> getItemDetails(String itemid) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.itemDetails, {'itemid': itemid});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> updateItem(Map<String, String> data) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.updateItem, data);
    return response.fold((l) => l, (r) => r);
  }
}
