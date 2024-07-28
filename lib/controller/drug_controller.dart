import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharmacy_managment_system/controller/favorate_controller.dart';
import 'package:pharmacy_managment_system/core/constant/routes_name.dart';
import 'package:pharmacy_managment_system/core/functions/toast.dart';
import 'package:pharmacy_managment_system/data/datasource/remote/drug_data.dart';
import 'package:pharmacy_managment_system/data/model/drug_model.dart';

import '../core/class/status_request.dart';
import '../core/functions/alert_dialog.dart';
import '../core/functions/handling_data.dart';
import '../core/services/services.dart';
import '../data/model/favorite_model.dart';
import '../view/widget/lottie_animation.dart';

class DrugController extends GetxController {
  List<DrugModel> drugs = [];
  List<DrugModel> drugsSearch = [];
  late TextEditingController name;
  late TextEditingController companyName;
  late TextEditingController scientificName;
  late TextEditingController price;
  late TextEditingController quantity;
  late TextEditingController gauge;
  late TextEditingController form;

  RxBool isRequiredPrescription = RxBool(false);

  int categoryId = 0;

  // DrugController({required this.categoryId});

  MyServices myServices = Get.find();
  DrugData drugData = DrugData(Get.find());
  Rx<StatusRequest> statusRequest = Rx(StatusRequest.none);

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  DrugModel drugModel = DrugModel.zero();

  FavoriteController favoriteController = Get.find();

  get length => drugs.length;

  addDrug() async {
    if (formState.currentState!.validate()) {
      statusRequest.value = StatusRequest.loading;
      update();
      var response = await drugData.addDrug(
          categoryId: categoryId,
          name: name.text,
          companyName: companyName.text,
          scientificName: scientificName.text,
          price: int.parse(price.text),
          quantity: int.parse(quantity.text),
          gauge: gauge.text,
          form: form.text,
          isRequiredPrescription: isRequiredPrescription.value);
      statusRequest.value = handlingData(response);

      if (statusRequest.value == StatusRequest.success) {
        alertDialog(
          withoutButton: true,
          content: const Column(
            children: [
              LottieAnimation(),
              Text("Drug Added Successfully"),
            ],
          ),
        );
        clearController();
        getAllDrugs();
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

  updateDrug() async {
    if (formState.currentState!.validate()) {
      statusRequest.value = StatusRequest.loading;
      update();
      var response = await drugData.updateDrug(
          id: drugModel.id,
          categoryId: drugModel.categoryId,
          name: name.text,
          companyName: companyName.text,
          scientificName: scientificName.text,
          price: int.parse(price.text),
          quantity: int.parse(quantity.text),
          gauge: gauge.text,
          form: form.text,
          isRequiredPrescription: isRequiredPrescription.value);
      statusRequest.value = handlingData(response);

      if (statusRequest.value == StatusRequest.success) {
        alertDialog(
          withoutButton: true,
          content: const Column(
            children: [
              LottieAnimation(),
              Text("Drug updated Successfully"),
            ],
          ),
        );
        getAllDrugs();
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

  void deleteDrug() async {
    statusRequest.value = StatusRequest.loading;
    update();

    Get.back();

    var response = await drugData.deleteDrugById(drugModel.id);
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
      getAllDrugs();
      update();
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.back();
          Get.back();
        },
      );
    } else {
      toast(msg: "can't be delete this drug");
      getAllDrugs();
    }
  }

  getAllDrugs() async {
    statusRequest.value = StatusRequest.loading;
    update();

    var response;
    // = await drugData.getAllDrugByCategoryId(categoryId);

    if (categoryId == 0) {
      response = await drugData
          .getAllDrugByAdminId(myServices.sharedPreferences.getInt('id')!);
    } else {
      response = await drugData.getAllDrugByCategoryId(categoryId);
    }

    statusRequest.value = handlingData(response);
    if (statusRequest.value == StatusRequest.success) {
      drugs = DrugModel.map(response);
      update();
    }
    update();
  }

  //======================user==================================
  getAllDrugsByAdminId(int adminId) async {
    categoryId = 0;
    Get.toNamed(AppRoute.drugPage);
    statusRequest.value = StatusRequest.loading;
    update();
    var response = await drugData.getAllDrugByAdminIdToUser(adminId);

    statusRequest.value = handlingData(response);
    if (statusRequest.value == StatusRequest.success) {
      drugs = DrugModel.map(response);
      favoriteController.getAllFavoriteByUserId();
      stop:
      for (DrugModel drug in drugs) {
        for (FavoriteModel favorite in favoriteController.favorites) {
          if (favorite.drug.id == drug.id) {
            drug.isFavorite = true;
            continue stop;
          }
        }
        drug.isFavorite = false;
      }
      update();
    }
  }

  getDrugById(int id) {
    for (DrugModel drug in drugs) {
      if (drug.id == id) {
        drugModel = drug;
        break;
      }
    }
    name.text = drugModel.name;
    companyName.text = drugModel.companyName;
    scientificName.text = drugModel.scientificName;
    price.text = drugModel.price.toString();
    quantity.text = drugModel.quantity.toString();
    gauge.text = drugModel.gauge;
    form.text = drugModel.form;
    isRequiredPrescription(drugModel.isRequiredPrescription);
    Get.toNamed(AppRoute.displayDrugPage);
  }

  void searchDrug(String query) {
    drugsSearch.clear();
    for (DrugModel drug in drugs) {
      if (drug.name.contains(query)) {
        drugsSearch.add(drug);
      }
    }
    Future.delayed(
      Duration.zero,
      () => update(),
    );
  }

  clearController() {
    name.clear();
    companyName.clear();
    scientificName.clear();
    price.clear();
    quantity.clear();
    gauge.clear();
    form.clear();
    isRequiredPrescription(false);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    name = TextEditingController();
    companyName = TextEditingController();
    scientificName = TextEditingController();
    price = TextEditingController();
    quantity = TextEditingController();
    gauge = TextEditingController();
    form = TextEditingController();
    if (myServices.sharedPreferences.getString('role') == "ADMIN") {
      getAllDrugs();
    }
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    companyName.dispose();
    scientificName.dispose();
    price.dispose();
    quantity.dispose();
    gauge.dispose();
    form.dispose();
    super.dispose();
  }

  changeBox(bool value) {
    isRequiredPrescription(value);
  }
}
