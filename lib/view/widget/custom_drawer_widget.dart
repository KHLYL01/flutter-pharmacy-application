import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/controller/home_controller.dart';
import 'package:pharmacy_managment_system/controller/order_controller.dart';
import 'package:pharmacy_managment_system/core/constant/routes_name.dart';

import '../../controller/auth/logout_controller.dart';
import '../../core/constant/color.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogoutController logoutController = Get.put(LogoutController());
    OrderController orderController = Get.find();
    HomeController homeController = Get.find();
    String pharmacyName = '';
    if (logoutController.myServices.sharedPreferences
        .getString('pharmacy_name')!
        .isEmpty) {
      pharmacyName =
          '(${logoutController.myServices.sharedPreferences.getString('pharmacy_name')})';
    }

    return Drawer(
      // backgroundColor: Colors.black,
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: AppColor.style1secondary1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  MdiIcons.accountCircle,
                  color: Colors.white,
                  size: 84,
                ),
                const SizedBox(height: 8),
                Text(
                  '${logoutController.myServices.sharedPreferences.getString('name')} $pharmacyName',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  logoutController.myServices.sharedPreferences
                      .getString('email')
                      .toString(),
                  style: const TextStyle(
                      color: AppColor.style1secondary2, fontSize: 12),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Scaffold.of(context).closeDrawer();
              if (homeController.role == "ADMIN") {
                orderController.getAllAdminOrders();
              } else {
                orderController.getAllUserOrders();
              }
              Get.toNamed(AppRoute.orderPage);
            },
            title: const Text("Orders"),
            leading: Icon(
              MdiIcons.orderBoolAscending,
            ),
            minLeadingWidth: 10,
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.1,
          ),
          if (homeController.role == "USER")
            ListTile(
              onTap: () {
                Scaffold.of(context).closeDrawer();
                Get.toNamed(AppRoute.favoritePage);
              },
              title: const Text("Favorite"),
              leading: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              minLeadingWidth: 10,
            ),
          if (homeController.role == "USER")
            const Divider(
              color: Colors.black,
              thickness: 0.1,
            ),
          ListTile(
            onTap: () {
              Scaffold.of(context).closeDrawer();
              logoutController.logout();
            },
            title: const Text("Logout"),
            leading: Icon(
              MdiIcons.logoutVariant,
            ),
            minLeadingWidth: 10,
          ),
        ],
      ),
    );
  }
}
