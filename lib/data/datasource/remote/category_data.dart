import 'dart:developer';

import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class CategoryData {
  Crud crud;
  CategoryData(this.crud);

  addCategory({
    required int adminId,
    required String name,
  }) async {
    Map<String, dynamic> body = {
      "adminId": adminId,
      "name": name,
    };
    var response = await crud.postData(AppLink.category, body);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  updateCategory({
    required int id,
    required int adminId,
    required String name,
  }) async {
    Map<String, dynamic> body = {
      "id": id,
      "adminId": adminId,
      "name": name,
    };
    var response = await crud.postData(AppLink.category, body);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  getAllCategoryByAdminId(int id) async {
    var response = await crud.getAllData('${AppLink.category}/$id');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  deleteCategoryById(int id) async {
    var response = await crud.deleteData('${AppLink.category}/$id');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }
}
