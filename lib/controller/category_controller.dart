import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/class/status_request.dart';
import '../core/functions/alert_dialog.dart';
import '../core/functions/handling_data.dart';
import '../core/functions/toast.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/category_data.dart';
import '../data/model/category_model.dart';
import '../view/widget/lottie_animation.dart';

class CategoryController extends GetxController {
  List<CategoryModel> categories = [];
  late TextEditingController categoryName;

  MyServices services = Get.find();
  CategoryData categoryData = CategoryData(Get.find());
  Rx<StatusRequest> statusRequest = Rx(StatusRequest.none);

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  get length => categories.length;

  addCategory() async {
    if (formState.currentState!.validate()) {
      statusRequest.value = StatusRequest.loading;
      update();
      var response = await categoryData.addCategory(
        adminId: services.sharedPreferences.getInt('id')!,
        name: categoryName.text,
      );
      statusRequest.value = handlingData(response);

      if (statusRequest.value == StatusRequest.success) {
        alertDialog(
          withoutButton: true,
          content: const Column(
            children: [
              LottieAnimation(),
              Text("Category Added Successfully"),
            ],
          ),
        );
        clearController();
        getAllCategories();
        update();
        Future.delayed(
          const Duration(seconds: 2),
          () {
            Get.back();
            Get.back();
          },
        );
      }
    }
    update();
  }

  updateCategory(int id) async {
    if (formState.currentState!.validate()) {
      statusRequest.value = StatusRequest.loading;
      update();
      var response = await categoryData.updateCategory(
        id: id,
        adminId: services.sharedPreferences.getInt('id')!,
        name: categoryName.text,
      );
      statusRequest.value = handlingData(response);

      if (statusRequest.value == StatusRequest.success) {
        alertDialog(
          withoutButton: true,
          content: const Column(
            children: [
              LottieAnimation(),
              Text("Category updated Successfully"),
            ],
          ),
        );
        clearController();
        getAllCategories();
        update();
        Future.delayed(
          const Duration(seconds: 2),
          () {
            Get.back();
            Get.back();
          },
        );
      }
    }
    update();
  }

  deleteCategory(int id) async {
    statusRequest.value = StatusRequest.loading;
    update();

    Get.back();
    Get.back();

    var response = await categoryData.deleteCategoryById(id);
    statusRequest.value = handlingData(response);

    if (statusRequest.value == StatusRequest.success) {
      alertDialog(
        withoutButton: true,
        content: const Column(
          children: [
            LottieAnimation(),
            Text("Category Deleted Successfully"),
          ],
        ),
      );
      clearController();
      getAllCategories();
      update();
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.back();
        },
      );
    } else {
      toast(msg: "can't be delete this category");
      getAllCategories();
    }
  }

  getAllCategories() async {
    statusRequest.value = StatusRequest.loading;
    update();
    var response = await categoryData
        .getAllCategoryByAdminId(services.sharedPreferences.getInt('id')!);
    statusRequest.value = handlingData(response);
    if (statusRequest.value == StatusRequest.success) {
      categories = response
          .map((item) => CategoryModel.fromJsom(item))
          .cast<CategoryModel>()
          .toList();
      update();
    }
    update();
  }

  clearController() {
    categoryName.clear();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    categoryName = TextEditingController();
    getAllCategories();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    categoryName.dispose();
    super.dispose();
  }
}
