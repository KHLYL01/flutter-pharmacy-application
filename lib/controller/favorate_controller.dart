import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/data/model/drug_model.dart';

import '../core/class/status_request.dart';
import '../core/functions/handling_data.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/favorite_data.dart';
import '../data/model/favorite_model.dart';

class FavoriteController extends GetxController {
  List<FavoriteModel> favorites = [];

  MyServices services = Get.find();
  FavoriteData favoriteData = FavoriteData(Get.find());
  Rx<StatusRequest> statusRequest = Rx(StatusRequest.none);

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  // DrugController drugController = Get.find();

  int drugSelectedId = 0;

  get length => favorites.length;

  addFavorite(DrugModel drugModel) async {
    drugSelectedId = drugModel.id;
    statusRequest.value = StatusRequest.loading;
    update();
    var response = await favoriteData.addFavorite(
      userId: services.sharedPreferences.getInt('id')!,
      drugId: drugModel.id,
    );
    statusRequest.value = handlingData(response);

    if (statusRequest.value == StatusRequest.success) {
      getAllFavoriteByUserId();
      drugModel.isFavorite = true;
      update();
    }
    update();
  }

  removeFavorite(DrugModel drugModel) async {
    drugSelectedId = drugModel.id;

    int favoriteId = 0;

    for (FavoriteModel favorite in favorites) {
      if (favorite.drug.id == drugModel.id) {
        favoriteId = favorite.id;
        break;
      }
    }

    statusRequest.value = StatusRequest.loading;
    update();

    var response = await favoriteData.deleteFavorite(favoriteId);
    statusRequest.value = handlingData(response);

    if (statusRequest.value == StatusRequest.success) {
      getAllFavoriteByUserId();
      drugModel.isFavorite = false;
      update();
    }
  }

  getAllFavoriteByUserId() async {
    statusRequest.value = StatusRequest.loading;
    update();
    var response = await favoriteData
        .getAllFavoriteByUserId(services.sharedPreferences.getInt('id')!);
    statusRequest.value = handlingData(response);
    if (statusRequest.value == StatusRequest.success) {
      favorites = FavoriteModel.map(response);

      update();
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getAllFavoriteByUserId();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // categoryName.dispose();
    super.dispose();
  }
}
