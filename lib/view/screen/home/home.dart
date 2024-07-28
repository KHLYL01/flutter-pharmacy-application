import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/controller/order_controller.dart';
import 'package:pharmacy_managment_system/core/constant/color.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';

import '../../../controller/home_controller.dart';
import '../../../core/constant/routes_name.dart';
import '../../widget/custom_drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    OrderController orderController = Get.find();
    DrugController drugController = Get.find();
    return Scaffold(
      drawerEdgeDragWidth: 200,
      drawer: const CustomDrawerWidget(),
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: controller.role == "ADMIN"
          ? ListView(
              children: [
                ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.categoryPage);
                  },
                  title: const Text("Display Category"),
                  subtitle: const Text(
                    'Adding categories and organizing medications',
                    style: TextStyle(fontSize: 12),
                  ),
                  leading: const Icon(Icons.category_outlined),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () {
                    orderController.getAllAdminOrders();
                    Get.toNamed(AppRoute.orderPage);
                  },
                  title: const Text("Display Orders"),
                  subtitle: const Text(
                    'Update Orders State',
                    style: TextStyle(fontSize: 12),
                  ),
                  leading: Icon(MdiIcons.orderBoolAscending),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () {
                    drugController.categoryId = 0;
                    Get.toNamed(AppRoute.drugPage);
                  },
                  title: const Text("Display drugs"),
                  subtitle: const Text(
                    'display all drug and search on it',
                    style: TextStyle(fontSize: 12),
                  ),
                  leading: Icon(MdiIcons.medicalCottonSwab),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.regions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1),
              itemBuilder: (context, index) => Card(
                child: Text(
                  controller.regions[index],
                  style: const TextStyle(
                    color: AppColor.style1main2,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ).center(),
              ).onTap(
                () =>
                    controller.getAllAdminsByRegion(controller.regions[index]),
              ),
            ).paddingAll(16),
    ).willPopScope();
  }
}
