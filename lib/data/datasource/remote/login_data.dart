import 'dart:developer';

import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);

  postData({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    var response = await crud.postDataWithoutToken(AppLink.login, body);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  // getData(String id) async {
  //   var response = await crud.getData('${AppLink.expertGet}/$id');
  //   print(response);
  //   return response.fold((l) => l, (r) => r);
  // }
}
