import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/controller/favorate_controller.dart';
import 'package:pharmacy_managment_system/controller/home_controller.dart';
import 'package:pharmacy_managment_system/controller/order_controller.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';
import 'package:pharmacy_managment_system/data/model/drug_model.dart';
import 'package:pharmacy_managment_system/view/screen/drug/search_delegate.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/color.dart';

import '../../../controller/category_controller.dart';
import '../../../core/class/view_handle.dart';
import '../../../core/constant/routes_name.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DrugController drugController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Page"),
        centerTitle: true,
      ),
      body: GetBuilder<FavoriteController>(
        builder: (controller) => ViewHandle(
          statusRequest: controller.statusRequest.value,
          onPressed: () => controller.getAllFavoriteByUserId(),
          widget: controller.length == 0
              ? const Text('Favorites are not found!!!').center()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.length,
                  itemBuilder: (context, index) {
                    var item =
                        controller.favorites[controller.length - 1 - index];
                    return ListTile(
                      onTap: () async {
                        await drugController
                            .getAllDrugsByAdminId(item.drugAdminId);
                        await drugController.getDrugById(item.drug.id);
                      },
                      title: Text(
                        item.drug.name,
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        item.drugPharmacy,
                      ),
                      leading: Icon(
                        MdiIcons.medicalCottonSwab,
                        size: 40,
                      ),
                      trailing: Obx(
                        () => controller.statusRequest.value ==
                                    StatusRequest.loading &&
                                controller.drugSelectedId == item.id
                            ? IconButton(
                                onPressed: () {},
                                icon: const CircularProgressIndicator(
                                  color: AppColor.style1secondary2,
                                ))
                            : IconButton(
                                onPressed: () =>
                                    controller.removeFavorite(item.drug),
                                icon: const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                  size: 32,
                                ),
                              ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
