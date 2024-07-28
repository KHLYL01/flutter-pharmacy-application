import 'package:get/get.dart';

class ObscureController extends GetxController {
  bool obscure = true;

  changeObscure() {
    obscure = !obscure;
    update();
  }
}
