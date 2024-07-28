import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/controller/favorate_controller.dart';
import 'package:pharmacy_managment_system/controller/home_controller.dart';
import 'package:pharmacy_managment_system/core/class/status_request.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';
import 'package:pharmacy_managment_system/view/screen/drug/search_delegate.dart';
import '../../../core/constant/color.dart';

import '../../../core/class/view_handle.dart';
import '../../../core/constant/routes_name.dart';

class DrugScreen extends StatelessWidget {
  const DrugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoriteController favoriteController = Get.find();
    HomeController homeController = Get.find();
    DrugController controller = Get.find();

    controller.getAllDrugs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('drug Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: MySearchDelegate()),
            icon: const Icon(Icons.search),
          ).paddingOnly(right: 8),
        ],
      ),
      floatingActionButton: controller.categoryId == 0
          ? null
          : FloatingActionButton(
              onPressed: () {
                controller.clearController();
                Get.toNamed(AppRoute.addDrugPage);
              },
              child: const Icon(Icons.add),
            ),
      body: GetBuilder<DrugController>(
        builder: (controller) => ViewHandle(
          statusRequest: controller.statusRequest.value,
          // onPressed: () => controller.getAllCategories(),
          onPressed: () => controller.getAllDrugs(),
          widget: controller.length == 0
              ? const Text('drugs are not found!!!').center()
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.length,
                  itemBuilder: (context, index) {
                    var item = controller.drugs[controller.length - 1 - index];
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColor.style1main2,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: AppColor.style1secondary1, blurRadius: 2)
                        ],
                      ),
                      child: ListTile(
                        onTap: () => controller.getDrugById(item.id),
                        title: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColor.style1secondary2,
                          ),
                        ),
                        subtitle: Text(
                          item.form,
                          style: const TextStyle(
                            color: AppColor.style1secondary2,
                          ),
                        ),
                        leading: const Icon(
                          Icons.medication_liquid_sharp,
                          size: 40,
                          color: AppColor.style1secondary1,
                        ),
                        trailing: homeController.role == "USER"
                            ? Obx(() => favoriteController
                                            .statusRequest.value ==
                                        StatusRequest.loading &&
                                    favoriteController.drugSelectedId == item.id
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const CircularProgressIndicator(
                                      color: AppColor.style1secondary2,
                                    ))
                                : IconButton(
                                    onPressed: () => item.isFavorite
                                        ? favoriteController
                                            .removeFavorite(item)
                                        : favoriteController.addFavorite(item),
                                    icon: Icon(
                                      Icons.favorite_rounded,
                                      color: item.isFavorite
                                          ? Colors.red
                                          : AppColor.style1secondary2,
                                      size: 32,
                                    ),
                                  ))
                            : const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.style1secondary2,
                              ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
                ),
        ),
      ),
    );
  }
}
