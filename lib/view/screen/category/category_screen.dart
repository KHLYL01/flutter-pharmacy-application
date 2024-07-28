import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/controller/category_controller.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/core/class/view_handle.dart';
import 'package:pharmacy_managment_system/core/constant/routes_name.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';

import '../../../core/constant/color.dart';
import '../../../core/functions/alert_dialog.dart';
import '../../widget/custom_floating_action_button.dart';
import '../auth/auth_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryController());
    DrugController drugController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Page'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoute.addCategoryPage),
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<CategoryController>(
        builder: (controller) => ViewHandle(
          statusRequest: controller.statusRequest.value,
          onPressed: () => controller.getAllCategories(),
          widget: controller.length == 0
              ? const Text('categories are not found!!!').center()
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    var item =
                        controller.categories[controller.length - 1 - index];
                    return Card(
                      child: Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ).paddingSymmetric(horizontal: 8).center(),
                    ).onTap(() {
                      // Get.toNamed(AppRoute.drugPage, arguments: '${item.id}');
                      drugController.categoryId = item.id;
                      Get.toNamed(AppRoute.drugPage);
                    }).onLongPress(
                      () {
                        Get.bottomSheet(
                          BottomSheet(
                            onClosing: () => null,
                            builder: (context) => Container(
                              height: context.height / 7,
                              decoration: const BoxDecoration(
                                color: AppColor.style1secondary2,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      Get.back();
                                      controller.categoryName.text = item.name;
                                      Get.bottomSheet(
                                        BottomSheet(
                                          onClosing: () => null,
                                          builder: (context) => Container(
                                            height: context.height / 5.5,
                                            color: AppColor.style1secondary2,
                                            child: Form(
                                              key: controller.formState,
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                        'update category'.tr),
                                                    leading:
                                                        Icon(MdiIcons.fileEdit),
                                                  ).paddingSymmetric(
                                                      horizontal: 8),
                                                  Row(
                                                    children: [
                                                      customTextFormField(
                                                        hint:
                                                            "category name".tr,
                                                        icon:
                                                            Icons.text_snippet,
                                                        textController:
                                                            controller
                                                                .categoryName,
                                                        validator: (value) =>
                                                            value
                                                                    .toString()
                                                                    .isEmpty
                                                                ? "name not valid"
                                                                    .tr
                                                                : null,
                                                      ).expanded(flex: 1),
                                                      const SizedBox(width: 16),
                                                      SizedBox(
                                                        height: 72,
                                                        child:
                                                            CustomFloatingActionButton(
                                                          onPressed: () {
                                                            controller
                                                                .updateCategory(
                                                                    item.id);
                                                          },
                                                          text: 'update',
                                                        ),
                                                      )
                                                    ],
                                                  ).paddingSymmetric(
                                                      horizontal: 16),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(MdiIcons.fileEdit, size: 32),
                                        const Text(
                                          'edit',
                                          style: TextStyle(
                                              color: AppColor.style1main2),
                                        )
                                      ],
                                    ),
                                  ),
                                  MaterialButton(
                                    shape: const CircleBorder(),
                                    onPressed: () => alertDialog(
                                      middleText:
                                          'Do you want delete this category',
                                      onPressed: () {
                                        controller.deleteCategory(item.id);
                                      },
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(MdiIcons.delete, size: 32),
                                        const Text(
                                          'delete',
                                          style: TextStyle(
                                              color: AppColor.style1main2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
