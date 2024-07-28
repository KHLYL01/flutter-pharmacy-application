import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/routes_name.dart';
import '../../core/functions/handling_data.dart';
import '../../data/datasource/remote/register_data.dart';

class RegisterController extends GetxController {
  late TextEditingController fullNameController;
  late TextEditingController pharmacyNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController regionController;
  late TextEditingController phoneNumberController;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  RegisterData registerData = RegisterData(Get.find());
  Rx<StatusRequest> statusRequest = Rx(StatusRequest.none);

  PageController pageController = PageController();

  String role = "";

  register() async {
    if (formState.currentState!.validate()) {
      statusRequest.value = StatusRequest.loading;
      update();
      var response;
      if (role == "admin") {
        response = await registerData.registerAdmin(
          fullName: fullNameController.text,
          companyName: pharmacyNameController.text,
          email: emailController.text,
          password: passwordController.text,
          region: regionController.text,
          phoneNumber: phoneNumberController.text,
        );
      } else {
        response = await registerData.registerUser(
          fullName: fullNameController.text,
          email: emailController.text,
          password: passwordController.text,
        );
      }

      statusRequest.value = handlingData(response);
      if (statusRequest.value == StatusRequest.success) {
        log("message");
        Get.offNamed(AppRoute.successPage);
      } else {
        Get.defaultDialog(title: 'Warning', middleText: 'Email Not Correct');
        statusRequest.value = StatusRequest.failure;
        log(response.toString());
      }
      update();
    } else {}
  }

  goToLogin() {
    Get.offNamed(AppRoute.loginPage);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fullNameController = TextEditingController();
    pharmacyNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    regionController = TextEditingController();
    phoneNumberController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameController.dispose();
    pharmacyNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    regionController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  void getRole(String role) {
    this.role = role;
    update();
    log(this.role);
    pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
