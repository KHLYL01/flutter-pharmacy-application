import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/controller/home_controller.dart';
import 'package:pharmacy_managment_system/controller/order_controller.dart';
import 'package:pharmacy_managment_system/core/constant/color.dart';
import 'package:pharmacy_managment_system/core/constant/routes_name.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';
import 'package:pharmacy_managment_system/core/functions/valid_input.dart';
import '../../../core/class/status_request.dart';
import '../../../core/functions/alert_dialog.dart';
import '../../widget/custom_add_page.dart';
import '../../widget/custom_dropdown_form_field.dart';
import '../auth/auth_widget.dart';

class DisplayDrugScreen extends GetView<DrugController> {
  const DisplayDrugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    OrderController orderController = Get.find();

    return Scaffold(
      body: CustomAddPage(
        title: 'Drug Information',
        column: Form(
          key: controller.formState,
          child: Column(
            children: [
              FlipInX(
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 500),
                child: customTextFormField(
                  hint: 'Name',
                  label: 'Name',
                  isEnable: homeController.role != "USER",
                  icon: Icons.title,
                  textController: controller.name,
                  validator: (value) => validInput(value, 2, 0, 'password'),
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 500),
                child: customTextFormField(
                  hint: 'Company Name',
                  label: 'Company Name',
                  isEnable: homeController.role != "USER",
                  icon: Icons.subtitles,
                  textController: controller.companyName,
                  validator: (value) => validInput(value, 2, 0, 'password'),
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 1300),
                duration: const Duration(milliseconds: 500),
                child: customTextFormField(
                  hint: 'Scientific Name',
                  label: 'Scientific Name',
                  isEnable: homeController.role != "USER",
                  icon: Icons.science,
                  textController: controller.scientificName,
                  validator: (value) => validInput(value, 2, 0, 'password'),
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 1600),
                duration: const Duration(milliseconds: 500),
                child: customTextFormField(
                  hint: 'price',
                  label: 'price',
                  isEnable: homeController.role != "USER",
                  keyboardType: TextInputType.number,
                  icon: Icons.price_change,
                  textController: controller.price,
                  validator: (value) => validInput(value, 1, 0, 'password'),
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 1900),
                duration: const Duration(milliseconds: 500),
                child: customTextFormField(
                  hint: 'quantity',
                  label: 'quantity',
                  isEnable: homeController.role != "USER",
                  keyboardType: TextInputType.number,
                  icon: Icons.production_quantity_limits,
                  textController: controller.quantity,
                  validator: (value) => validInput(value, 1, 0, 'password'),
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 2200),
                duration: const Duration(milliseconds: 500),
                child: Row(
                  children: [
                    customTextFormField(
                      hint: 'Gauge',
                      label: 'Gauge',
                      icon: MdiIcons.gaugeLow,
                      keyboardType: homeController.role == "USER"
                          ? TextInputType.none
                          : TextInputType.number,
                      textController: controller.gauge,
                      validator: (value) => validInput(value, 1, 0, 'password'),
                    ).expanded(flex: 6),
                    const SizedBox(width: 8),
                    CustomDropDownFormField(
                      controller: controller.form,
                      icon: MdiIcons.medicalCottonSwab,
                      isEnable: homeController.role != "USER",
                      list: const [
                        'Select Form',
                        'Liquid',
                        'Solid',
                        'Capsules',
                        'Injections',
                        'Drops',
                        'Suppositories',
                        'Topical medicines',
                        'Inhalers',
                      ],
                    ).expanded(flex: 8),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 2500),
                duration: const Duration(milliseconds: 500),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.style1main2,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Obx(
                    () => CheckboxListTile(
                      title: const Text(
                        "Required Prescription",
                        style: TextStyle(color: AppColor.style1secondary2),
                      ),
                      checkboxShape: const CircleBorder(),
                      value: controller.isRequiredPrescription.value,
                      onChanged: homeController.role == "USER"
                          ? null
                          : (value) => controller.changeBox(value!),
                    ),
                  ).paddingAll(8),
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 2800),
                duration: const Duration(milliseconds: 500),
                child: homeController.role == "ADMIN"
                    ? Obx(
                        () => controller.statusRequest.value ==
                                StatusRequest.loading
                            ? customCircularProgressIndicatorButton(
                                color: AppColor.style1secondary1,
                              )
                            : Row(
                                children: [
                                  customButton(
                                    title: 'delete',
                                    color: Colors.redAccent,
                                    onTap: () {
                                      alertDialog(
                                        middleText:
                                            'Do you want delete this drug',
                                        onPressed: () {
                                          controller.deleteDrug();
                                        },
                                      );
                                    },
                                  ).expanded(flex: 1),
                                  customButton(
                                    title: 'update',
                                    onTap: () {
                                      controller.updateDrug();
                                    },
                                  ).expanded(flex: 1),
                                ],
                              ),
                      )
                    : Row(
                        children: [
                          Obx(
                            () => controller.statusRequest.value ==
                                    StatusRequest.loading
                                ? customCircularProgressIndicatorButton()
                                : customButton(
                                    title: 'Add To Card',
                                    onTap: () {
                                      orderController
                                          .addToOrder(controller.drugModel);
                                      orderController.requiredPhoto();
                                    },
                                  ),
                          ).expanded(flex: 5),
                          Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                color: AppColor.style1secondary2,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    orderController.cardCount.toString(),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  Icon(
                                    MdiIcons.shopping,
                                    color: AppColor.style1secondary1,
                                    size: 36,
                                  )
                                ],
                              ),
                            ).onTap(() => Get.toNamed(AppRoute.addOrderPage)),
                          ).expanded(flex: 1),
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
