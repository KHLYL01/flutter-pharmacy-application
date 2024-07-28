import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/controller/order_controller.dart';
import 'package:pharmacy_managment_system/controller/shared/image_controller.dart';
import 'package:pharmacy_managment_system/core/class/status_request.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';
import 'package:pharmacy_managment_system/core/functions/get_image_use_bottom_sheet.dart';
import 'package:pharmacy_managment_system/view/screen/image/image_screen.dart';

import '../../../core/class/view_handle.dart';
import '../../../core/constant/color.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageController imageController = Get.put(ImageController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Order Page'),
        centerTitle: true,
      ),
      body: GetBuilder<OrderController>(
        builder: (controller) => ViewHandle(
          statusRequest: controller.statusRequest.value,
          onPressed: () {
            log('hi');
            controller.statusRequest.value = StatusRequest.success;
            controller.update();
          },
          widget: controller.length == 0
              ? const Text('drugs are not found!!!').center()
              : Column(
                  children: [
                    ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.length,
                      itemBuilder: (context, index) {
                        var item = controller.orderDrugs[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColor.style1main2,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColor.style1secondary1,
                                blurRadius: 2,
                              )
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColor.style1secondary2,
                              ),
                            ),
                            subtitle: Text(
                              'price: ${item.count * item.price}',
                              style: const TextStyle(
                                color: AppColor.style1secondary2,
                              ),
                            ),
                            leading: const Icon(
                              Icons.medication_liquid_sharp,
                              size: 40,
                              color: AppColor.style1secondary1,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      controller.removeFromOrder(item),
                                  color: AppColor.style1secondary1,
                                  icon: Icon(MdiIcons.minus),
                                ),
                                Text(
                                  item.count.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColor.style1secondary2,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => controller.addToOrder(item),
                                  color: AppColor.style1secondary1,
                                  icon: Icon(MdiIcons.plus),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 24);
                      },
                    ).expanded(flex: 1),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          if (controller.isRequiredPhoto)
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: AppColor.style1main2,
                                  ),
                                  child: const Text(
                                    'Add Photo',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).center(),
                                ).onTap(
                                  () async {
                                    await getImageUseBottomSheet(
                                      imageController,
                                    );
                                    controller.imageOrderPath =
                                        imageController.selectedImagePath.value;
                                    log(controller.imageOrderPath);
                                    controller.update();
                                  },
                                ).expanded(flex: 1),
                                if (controller.imageOrderPath != '')
                                  const SizedBox(width: 1),
                                if (controller.imageOrderPath != '')
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: AppColor.style1main2,
                                    ),
                                    child: const Text(
                                      'View photo',
                                      style: TextStyle(
                                        color: AppColor.style1secondary2,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ).center(),
                                  ).onTap(() {
                                    Get.to(
                                      () => ImagePage(
                                        image: controller.imageOrderPath,
                                        isFile: true,
                                      ),
                                    );
                                  }).expanded(flex: 1),
                              ],
                            ).paddingSymmetric(horizontal: 8),
                          const SizedBox(height: 1),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColor.style1main2,
                            ),
                            child: RichText(
                              text: TextSpan(
                                  style: const TextStyle(fontSize: 20),
                                  children: [
                                    const TextSpan(
                                      text: 'Total price : ',
                                    ),
                                    TextSpan(
                                      text:
                                          controller.getTotalPrice().toString(),
                                      style: const TextStyle(
                                          color: AppColor.style1secondary1),
                                    )
                                  ]),
                            ).center(),
                          ).onTap(() {}).paddingSymmetric(horizontal: 8),
                          const SizedBox(height: 1),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColor.style1main2,
                            ),
                            child: const Text(
                              'Add Order',
                              style: TextStyle(
                                color: AppColor.style1secondary1,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ).center(),
                          )
                              .onTap(() => controller.addOrder())
                              .paddingSymmetric(horizontal: 8),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
