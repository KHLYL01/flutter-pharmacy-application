import 'package:get/get.dart';
import 'package:pharmacy_managment_system/core/constant/routes_name.dart';

import '../core/class/status_request.dart';
import '../core/functions/handling_data.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/home_data.dart';
import '../data/model/admin_model.dart';

class HomeController extends GetxController {
  late String role;

  List<AdminModel> admins = [];

  List<String> regions = [
    'الكاشف',
    'السبيل',
    'المطار',
    'شمال الخط',
    'القصور',
    'السحاري',
  ];

  late String region;

  HomeData homeData = HomeData(Get.find());
  MyServices myServices = Get.find();
  Rx<StatusRequest> statusRequest = Rx(StatusRequest.none);

  get length => admins.length;

  getAllAdminsByRegion(String region) async {
    this.region = region;
    Get.toNamed(AppRoute.adminPage);
    statusRequest.value = StatusRequest.loading;
    update();
    var response = await homeData.getAllAdminsByRegion(region);
    statusRequest.value = handlingData(response);
    if (statusRequest.value == StatusRequest.success) {
      admins = AdminModel.map(response);
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    role = myServices.sharedPreferences.getString('role')!;
    region = regions[0];
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
