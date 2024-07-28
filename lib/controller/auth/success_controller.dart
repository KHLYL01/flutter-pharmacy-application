import 'package:get/get.dart';

import '../../core/constant/routes_name.dart';

class SuccessControllerImp extends GetxController {
  goToLogin() {
    Get.offNamed(AppRoute.loginPage);
  }
}
