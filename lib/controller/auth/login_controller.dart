import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/routes_name.dart';
import '../../core/functions/handling_data.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/login_data.dart';

class LoginControllerImp extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  LoginData loginData = LoginData(Get.find());
  Rx<StatusRequest> statusRequest = Rx(StatusRequest.none);
  MyServices myServices = Get.find();

  login() async {
    if (formState.currentState!.validate()) {
      statusRequest.value = StatusRequest.loading;
      update();

      var response = await loginData.postData(
        email: emailController.text,
        password: passwordController.text,
      );

      statusRequest.value = handlingData(response);

      if (statusRequest.value == StatusRequest.success) {
        if (response['token'].toString().isNotEmpty) {
          myServices.saveToken(response['token']);
          myServices.saveToken(response['refreshToken']);

          myServices.sharedPreferences.setInt(
            'id',
            response['id'],
          );
          myServices.sharedPreferences.setString(
            'name',
            '${response['name']}',
          );
          myServices.sharedPreferences.setString(
            'email',
            '${response['email']}',
          );

          myServices.sharedPreferences.setString(
            'role',
            '${response['role']}',
          );

          log(response['role']);
          if (response['role'] == "ADMIN") {
            myServices.sharedPreferences.setString(
              'pharmacy_name',
              '${response['pharmacyName']}',
            );

            myServices.sharedPreferences.setString(
              'region',
              '${response['region']}',
            );

            myServices.sharedPreferences.setString(
              'phone_number',
              '${response['phone_number']}',
            );
          }
          log(myServices.getToken());

          // InitialBinding().dependencies();

          myServices.sharedPreferences.setString('step', '2');
          Get.offNamed(AppRoute.homePage);
        }
      } else {
        Get.defaultDialog(
            title: 'Warning', middleText: 'Email or password Not Correct');
        statusRequest.value = StatusRequest.failure;
        log(response.toString());
      }
      update();
    } else {}
  }

  goToSignUp() {
    Get.offNamed(AppRoute.registerPage);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
