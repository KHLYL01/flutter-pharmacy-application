import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/controller/favorate_controller.dart';
import 'package:pharmacy_managment_system/controller/home_controller.dart';
import 'package:pharmacy_managment_system/controller/order_controller.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';
import 'package:pharmacy_managment_system/view/screen/drug/search_delegate.dart';
import '../../../core/constant/color.dart';

import '../../../controller/category_controller.dart';
import '../../../core/class/view_handle.dart';
import '../../../core/constant/routes_name.dart';

class AdminScreen extends GetView<HomeController> {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DrugController drugController = Get.find();
    OrderController orderController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.region),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => ViewHandle(
          statusRequest: controller.statusRequest.value,
          onPressed: () => controller.getAllAdminsByRegion(controller.region),
          widget: controller.length == 0
              ? const Text('pharmacies are not found!!!').center()
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.length,
                  itemBuilder: (context, index) {
                    var item = controller.admins[controller.length - 1 - index];
                    return ListTile(
                      onTap: () {
                        orderController.clearOrder();
                        orderController.setAdminId(item.id);
                        drugController.getAllDrugsByAdminId(item.id);
                      },
                      title: Text(
                        item.pharmacyName,
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        item.fullName,
                      ),
                      leading: Icon(
                        MdiIcons.officeBuildingMarker,
                        size: 40,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 24);
                  },
                ),
        ),
      ),
    );
  }
}
