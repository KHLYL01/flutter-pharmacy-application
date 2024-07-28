import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  getToken() {
    return sharedPreferences.getString('token') ?? '';
  }
}

initialServices() async {
  await Get.putAsync(
    () => MyServices().init(),
  );
}
