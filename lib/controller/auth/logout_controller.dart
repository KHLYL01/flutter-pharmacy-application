import 'package:get/get.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/controller/favorate_controller.dart';
import 'package:pharmacy_managment_system/controller/order_controller.dart';

import '../../core/constant/routes_name.dart';
import '../../core/functions/alert_dialog.dart';
import '../../core/services/services.dart';

class LogoutController extends GetxController {
  MyServices myServices = Get.find();
  void logout() {
    alertDialog(
      middleText: 'do you already want logout',
      onPressed: () {
        myServices.sharedPreferences
            .setString('pharmacy_name', null.toString());

        myServices.sharedPreferences.setString('region', null.toString());
        myServices.sharedPreferences.setString('phone_number', null.toString());
        myServices.sharedPreferences.setString('step', '1');
        //
        // Get.delete<OrderController>();
        // Get.delete<DrugController>();
        // Get.delete<FavoriteController>();

        Get.offAllNamed(AppRoute.loginPage);
      },
    );
  }
}
