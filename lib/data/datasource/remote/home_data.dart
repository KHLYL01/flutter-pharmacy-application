import 'dart:developer';

import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);

  getAllAdminsByRegion(String region) async {
    var response = await crud.getAllData('${AppLink.admins}/$region');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }
}
