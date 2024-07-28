import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/core/constant/color.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';
import 'package:pharmacy_managment_system/core/functions/valid_input.dart';
import '../../../controller/category_controller.dart';
import '../../../core/class/status_request.dart';
import '../../widget/custom_add_page.dart';
import '../../widget/custom_dropdown_form_field.dart';
import '../auth/auth_widget.dart';

class AddDrugScreen extends GetView<DrugController> {
  const AddDrugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAddPage(
        title: 'Add Drug',
        column: Form(
          key: controller.formState,
          child: Column(
            children: [
              FlipInX(
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 500),
                child: customTextFormField(
                  hint: 'Name',
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
                  icon: Icons.subtitles,
                  textController: controller.companyName,
                  validator: (value) => null,
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 1300),
                duration: const Duration(milliseconds: 500),
                child: customTextFormField(
                  hint: 'Scientific Name',
                  icon: Icons.science,
                  textController: controller.scientificName,
                  validator: (value) => null,
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 1600),
                duration: const Duration(milliseconds: 500),
                child: customTextFormField(
                  hint: 'price',
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
                      keyboardType: TextInputType.number,
                      icon: MdiIcons.gaugeLow,
                      textController: controller.gauge,
                      validator: (value) => null,
                    ).expanded(flex: 6),
                    const SizedBox(width: 8),
                    CustomDropDownFormField(
                      controller: controller.form,
                      icon: MdiIcons.medicalCottonSwab,
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
                      onChanged: (value) => controller.changeBox(value!),
                    ),
                  ).paddingAll(8),
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 2800),
                duration: const Duration(milliseconds: 500),
                child: Obx(
                  () => controller.statusRequest.value == StatusRequest.loading
                      ? customCircularProgressIndicatorButton()
                      : customButton(
                          title: 'Add Drug',
                          onTap: () {
                            controller.addDrug();
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
