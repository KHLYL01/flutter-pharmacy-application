import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/controller/home_controller.dart';
import 'package:pharmacy_managment_system/controller/order_controller.dart';
import 'package:pharmacy_managment_system/core/class/status_request.dart';
import 'package:pharmacy_managment_system/core/constant/routes_name.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';
import 'package:pharmacy_managment_system/link_api.dart';
import 'package:pharmacy_managment_system/view/screen/auth/auth_widget.dart';
import 'package:pharmacy_managment_system/view/screen/drug/search_delegate.dart';
import '../../../core/constant/color.dart';

import '../../../core/class/view_handle.dart';
import '../image/image_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Page'),
        centerTitle: true,
      ),
      body: GetBuilder<OrderController>(
        builder: (controller) => ViewHandle(
          statusRequest: controller.statusRequest.value,
          onPressed: () => null,
          widget: controller.orderLength == 0
              ? const Text('orders are not found!!!').center()
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.orderLength,
                  itemBuilder: (context, index) {
                    var item =
                        controller.orders[controller.orderLength - 1 - index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              item.pharmacyName,
                              style: const TextStyle(
                                fontSize: 18,
                                // color: AppColor.style1secondary2,
                              ),
                            ),
                            leading: Icon(
                              MdiIcons.hospitalBuilding,
                              size: 40,
                              color: AppColor.style1secondary1,
                            ),
                          ),
                          ...List.generate(
                            item.orderItems.length,
                            (index) {
                              var orderItem = item.orderItems[index];
                              return ListTile(
                                // dense: true,
                                title: Text(
                                  orderItem.drugName,
                                ),
                                subtitle: Text(
                                  'price: ${orderItem.price}',
                                ),
                                leading: Icon(
                                  MdiIcons.medicalCottonSwab,
                                  size: 32,
                                  color: AppColor.style1secondary1,
                                ),
                                trailing: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: const BoxDecoration(
                                    color: AppColor.style1secondary1,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${orderItem.quantity}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: AppColor.style1secondary2),
                                  ).center(),
                                ),
                              ).paddingOnly(left: 16);
                            },
                          ),
                          const SizedBox(height: 8),
                          if (item.imageUrl != '')
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: context.height / 4,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image.network(
                                '${AppLink.baseUrl}${item.imageUrl}',
                                fit: BoxFit.cover,
                              ),
                            ).paddingSymmetric(horizontal: 16).onTap(() {
                              Get.to(() => ImagePage(
                                    image: '${AppLink.baseUrl}${item.imageUrl}',
                                    isFile: false,
                                  ));
                            }),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: AppColor.style1main2,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(text: 'Total Price: '),
                                      TextSpan(
                                        text: item.totalPrice.toString(),
                                        style: const TextStyle(
                                            color: AppColor.style1secondary1),
                                      ),
                                    ],
                                  ),
                                ).center(),
                              ).expanded(flex: 1),
                              const SizedBox(width: 4),
                              Container(
                                height: 60,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: AppColor.style1secondary1,
                                ),
                                child: Text(
                                  item.status,
                                  style: const TextStyle(
                                    color: AppColor.style1secondary2,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).center(),
                              ).expanded(flex: 1),
                            ],
                          ),
                          if (homeController.role == "ADMIN")
                            const SizedBox(height: 4),
                          if (homeController.role == "ADMIN")
                            Container(
                              height: 60,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: AppColor.style1main2,
                              ),
                              child: const Text(
                                'Change Status',
                                style: TextStyle(
                                  color: AppColor.style1secondary2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).center(),
                            ).onTap(
                              () => controller.changeStatusController(item.id),
                            ),
                          if (homeController.role == "ADMIN" &&
                              // controller.orderPressedId == item.id
                              // &&
                              item.isOpen)
                            SizedBox(
                              height: 128,
                              child: Column(
                                children: [
                                  const SizedBox(height: 4),
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: AppColor.style1main2,
                                    ),
                                    child: const Text(
                                      'Waiting',
                                      style: TextStyle(
                                        color: AppColor.style1secondary1,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ).center(),
                                  ).onTap(
                                    () => controller.updateOrderStatus(
                                        item, 'Waiting'),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: AppColor.style1main2,
                                    ),
                                    child: const Text(
                                      'Done',
                                      style: TextStyle(
                                        color: AppColor.style1secondary1,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ).center(),
                                  ).onTap(
                                    () => controller.updateOrderStatus(
                                      item,
                                      'Done',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
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
