import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/routes_name.dart';
import '../core/services/services.dart';
import '../data/datasource/static/static.dart';

class OnBoardingControllerImp extends GetxController {
  RxInt currentIndex = 0.obs;

  late PageController pageController;

  MyServices myServices = Get.find();

  skip() {
    currentIndex.value = onBoardingList.length - 1;
    pageController.animateToPage(onBoardingList.length - 1,
        duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
  }

  onPageChange(int value) {
    currentIndex.value = value;
  }

  onClickIndicator(int index) {
    currentIndex.value = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  getStarted() {
    myServices.sharedPreferences.setString('step', '1');
    Get.offNamed(AppRoute.loginPage);
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
