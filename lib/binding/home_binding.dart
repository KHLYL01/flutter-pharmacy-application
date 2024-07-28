import 'package:get/get.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/controller/favorate_controller.dart';
import '../controller/order_controller.dart';
import '../core/class/crud.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(FavoriteController());
    Get.put(DrugController());
    Get.put(OrderController());
  }
}
