import 'dart:developer';

import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class OrderData {
  Crud crud;
  OrderData(this.crud);

  addOrder({
    required int adminId,
    required int userId,
    required double totalPrice,
    required List<Map<String, dynamic>> orderItems,
  }) async {
    Map<String, dynamic> body = {
      'adminId': adminId,
      'userId': userId,
      'totalPrice': totalPrice,
      'orderItems': orderItems,
    };
    var response = await crud.postData(AppLink.userOrders, body);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  getAllOrderByUserId(int userId) async {
    var response = await crud.getAllData('${AppLink.userOrders}/user/$userId');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  getAllOrderByAdminId(int adminId) async {
    var response = await crud.getAllData('${AppLink.orders}/admin/$adminId');
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  updateOrder({
    required int id,
    required String status,
  }) async {
    Map<String, dynamic> body = {
      'status': status,
    };
    var response = await crud.postData('${AppLink.orders}/$id', body);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  addImage(int orderId, String imageOrderPath) async {
    log('1');
    var response =
        await crud.postImage('${AppLink.image}/$orderId', imageOrderPath);
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

  // updateDrug({
  //   required int id,
  //   required int categoryId,
  //   required String name,
  //   required String companyName,
  //   required String scientificName,
  //   required int price,
  //   required int quantity,
  //   required String gauge,
  //   required String form,
  //   required bool isRequiredPrescription,
  // }) async {
  //   Map<String, dynamic> body = {
  //     'id': id,
  //     'categoryId': categoryId,
  //     'name': name,
  //     'companyName': companyName,
  //     'scientificName': scientificName,
  //     'price': price,
  //     'quantity': quantity,
  //     'gauge': gauge,
  //     'form': form,
  //     'requiredPrescription': isRequiredPrescription,
  //   };
  //   var response = await crud.postData(AppLink.drug, body);
  //   log(response.toString());
  //   return response.fold((l) => l, (r) => r);
  // }
  //
  // getAllDrugByCategoryId(int categoryId) async {
  //   var response =
  //       await crud.getAllData('${AppLink.drug}/category/$categoryId');
  //   log(response.toString());
  //   return response.fold((l) => l, (r) => r);
  // }
  //

  //
  // getAllDrugByAdminIdToUser(int adminId) async {
  //   var response = await crud.getAllData('${AppLink.userDrug}/admin/$adminId');
  //   log(response.toString());
  //   return response.fold((l) => l, (r) => r);
  // }
  //
  // deleteDrugById(id) async {
  //   var response = await crud.deleteData('${AppLink.drug}/$id');
  //   log(response.toString());
  //   return response.fold((l) => l, (r) => r);
  // }
}
