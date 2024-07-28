import 'dart:developer';

import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class RegisterData {
  Crud crud;
  RegisterData(this.crud);

  registerAdmin({
    required String fullName,
    required String companyName,
    required String email,
    required String password,
    required String region,
    required String phoneNumber,
  }) async {
    Map<String, dynamic> body = {
      "fullName": fullName,
      "pharmacyName": companyName,
      "email": email,
      "password": password,
      "region": region,
      "phoneNumber": phoneNumber,
    };
    var response = await crud.postDataWithoutToken(AppLink.registerAdmin, body);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  registerUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> body = {
      "fullName": fullName,
      "email": email,
      "password": password,
    };
    var response = await crud.postDataWithoutToken(AppLink.registerUser, body);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  // getData(String id) async {
  //   var response = await crud.getData('${AppLink.expertGet}/$id');
  //   print(response);
  //   return response.fold((l) => l, (r) => r);
  // }
}
