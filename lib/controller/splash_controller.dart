import 'dart:async';

import 'package:get/get.dart';

import '../core/constant/routes_name.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    Timer(
      const Duration(seconds: 4),
      () => Get.offNamed(AppRoute.onBoardingPage),
    );
    super.onInit();
  }
}
