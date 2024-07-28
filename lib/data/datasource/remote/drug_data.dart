import 'dart:developer';

import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class DrugData {
  Crud crud;
  DrugData(this.crud);

  addDrug({
    required int categoryId,
    required String name,
    required String companyName,
    required String scientificName,
    required int price,
    required int quantity,
    required String gauge,
    required String form,
    required bool isRequiredPrescription,
  }) async {
    Map<String, dynamic> body = {
      'categoryId': categoryId,
      'name': name,
      'companyName': companyName,
      'scientificName': scientificName,
      'price': price,
      'quantity': quantity,
      'gauge': gauge,
      'form': form,
      'requiredPrescription': isRequiredPrescription,
    };
    var response = await crud.postData(AppLink.drug, body);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  updateDrug({
    required int id,
    required int categoryId,
    required String name,
    required String companyName,
    required String scientificName,
    required int price,
    required int quantity,
    required String gauge,
    required String form,
    required bool isRequiredPrescription,
  }) async {
    Map<String, dynamic> body = {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'companyName': companyName,
      'scientificName': scientificName,
      'price': price,
      'quantity': quantity,
      'gauge': gauge,
      'form': form,
      'requiredPrescription': isRequiredPrescription,
    };
    var response = await crud.postData(AppLink.drug, body);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  getAllDrugByCategoryId(int categoryId) async {
    var response =
        await crud.getAllData('${AppLink.drug}/category/$categoryId');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  getAllDrugByAdminId(int adminId) async {
    var response = await crud.getAllData('${AppLink.drug}/admin/$adminId');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  getAllDrugByAdminIdToUser(int adminId) async {
    var response = await crud.getAllData('${AppLink.userDrug}/admin/$adminId');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  deleteDrugById(id) async {
    var response = await crud.deleteData('${AppLink.drug}/$id');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }
}
