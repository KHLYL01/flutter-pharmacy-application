import 'dart:developer';

import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class FavoriteData {
  Crud crud;
  FavoriteData(this.crud);

  addFavorite({
    required int userId,
    required int drugId,
  }) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'drugId': drugId,
    };
    var response = await crud.postData(AppLink.favorites, body);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  deleteFavorite(int id) async {
    var response = await crud.deleteData('${AppLink.favorites}/$id');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  getAllFavoriteByUserId(int userId) async {
    var response = await crud.getAllData('${AppLink.favorites}/$userId');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }
}
