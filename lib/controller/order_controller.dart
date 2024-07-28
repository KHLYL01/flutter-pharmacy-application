import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_managment_system/core/constant/routes_name.dart';
import 'package:pharmacy_managment_system/core/functions/toast.dart';
import 'package:pharmacy_managment_system/data/model/drug_model.dart';
import 'package:pharmacy_managment_system/data/model/order_drug_model.dart';
import 'package:pharmacy_managment_system/data/model/order_model.dart';

import '../core/class/status_request.dart';
import '../core/functions/alert_dialog.dart';
import '../core/functions/handling_data.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/order_data.dart';
import '../view/widget/lottie_animation.dart';

class OrderController extends GetxController {
  List<OrderModel> orders = [];

  List<DrugModel> orderDrugs = [];

  String imageOrderPath = '';

  RxInt cardCount = 0.obs;

  int adminId = 0;

  int orderPressedId = 0;

  bool isRequiredPhoto = false;

  MyServices myServices = Get.find();
  OrderData orderData = OrderData(Get.find());
  Rx<StatusRequest> statusRequest = Rx(StatusRequest.none);

  int get length => orderDrugs.length;
  int get orderLength => orders.length;

  setAdminId(int adminId) {
    this.adminId = adminId;
  }

  requiredPhoto() {
    for (DrugModel drug in orderDrugs) {
      if (drug.isRequiredPrescription) {
        isRequiredPhoto = true;
        update();
        return true;
      }
    }
    isRequiredPhoto = false;
    update();
    return false;
  }

  void addToOrder(DrugModel drugModel) {
    if (drugModel.count >= drugModel.quantity) {
      toast(msg: 'quantity is ${drugModel.quantity}');
      return;
    }
    if (drugModel.count == 0) {
      orderDrugs.add(drugModel);
    }

    drugModel.count++;
    cardCount(cardCount.value + 1);
    update();
  }

  void removeFromOrder(DrugModel drugModel) {
    drugModel.count--;
    cardCount(cardCount.value - 1);
    if (drugModel.count == 0) {
      orderDrugs.remove(drugModel);
      requiredPhoto();
    }
    update();
  }

  clearOrder() {
    orderDrugs.clear();
    imageOrderPath = '';
    cardCount(0);
  }

  getTotalPrice() {
    double totalPrice = 0;
    for (DrugModel drug in orderDrugs) {
      totalPrice += drug.count * drug.price;
    }
    log("totalPrice : $totalPrice");
    return totalPrice;
  }

  addOrder() async {
    if (requiredPhoto() && imageOrderPath == '') {
      toast(msg: 'you must add a prescription');
      return;
    }

    statusRequest.value = StatusRequest.loading;
    update();

    List<OrderDrugModel> orderItems = [];
    for (DrugModel drug in orderDrugs) {
      orderItems.add(OrderDrugModel(
        drugId: drug.id,
        drugName: drug.name,
        quantity: drug.count,
        price: drug.price,
      ));
    }

    double totalPrice = getTotalPrice();

    var response = await orderData.addOrder(
      adminId: adminId,
      userId: myServices.sharedPreferences.getInt('id')!,
      totalPrice: totalPrice,
      orderItems: OrderDrugModel.unMap(orderItems),
    );

    if (imageOrderPath != '') {
      OrderModel orderModel = OrderModel.fromJsom(response);

      toast(msg: "photo is being uploaded", isLong: true);

      response = await orderData.addImage(orderModel.id, imageOrderPath);
    }
    statusRequest.value = handlingData(response);

    if (statusRequest.value == StatusRequest.success) {
      alertDialog(
        withoutButton: true,
        content: const Column(
          children: [
            LottieAnimation(),
            Text("Order Added Successfully"),
          ],
        ),
      );
      clearOrder();
      // getAllDrugs();
      update();
      Future.delayed(
        const Duration(seconds: 2),
        () async {
          Get.back();
          Get.back();
          Get.back();
          Get.back();
          Get.back();
          Get.toNamed(AppRoute.orderPage);
          await getAllUserOrders();
        },
      );
    }
  }

  getAllUserOrders() async {
    statusRequest.value = StatusRequest.loading;
    update();

    var response = await orderData
        .getAllOrderByUserId(myServices.sharedPreferences.getInt('id')!);

    statusRequest.value = handlingData(response);
    if (statusRequest.value == StatusRequest.success) {
      orders = OrderModel.map(response);
      update();
    }
    update();
  }

  getAllAdminOrders() async {
    statusRequest.value = StatusRequest.loading;
    update();

    var response = await orderData
        .getAllOrderByAdminId(myServices.sharedPreferences.getInt('id')!);

    statusRequest.value = handlingData(response);
    if (statusRequest.value == StatusRequest.success) {
      orders = OrderModel.map(response);
      update();
    }
    update();
  }

  changeStatusController(int id) {
    for (OrderModel orderModel in orders) {
      if (orderModel.id == id) {
        // orderPressedId = id;
        orderModel.isOpen = !orderModel.isOpen;
        break;
      }
    }
    update();
  }

  updateOrderStatus(OrderModel orderModel, String status) async {
    if (orderModel.status == 'Done') {
      toast(msg: 'order is Done');
      return;
    }

    if (orderModel.status == status) {
      toast(msg: 'order is already $status');
      return;
    }

    statusRequest.value = StatusRequest.loading;
    update();

    var response =
        await orderData.updateOrder(id: orderModel.id, status: status);
    statusRequest.value = handlingData(response);

    if (statusRequest.value == StatusRequest.success) {
      alertDialog(
        withoutButton: true,
        content: const Column(
          children: [
            LottieAnimation(),
            Text("Order Updated Successfully"),
          ],
        ),
      );
      clearOrder();
      getAllAdminOrders();
      update();
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.back();
        },
      );
    }
  }
}
