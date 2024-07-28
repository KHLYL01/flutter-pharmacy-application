import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/controller/drug_controller.dart';
import 'package:pharmacy_managment_system/core/class/view_handle.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';

class MySearchDelegate extends SearchDelegate {
  DrugController controller = Get.find();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
            // Get.to(SplashPage());
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      controller.searchDrug(query);
    });

    if (controller.drugsSearch.isEmpty) {
      return const Text('drugs are not found!!!').center();
    }
    return GetBuilder<DrugController>(
      builder: (controller) => ViewHandle(
        statusRequest: controller.statusRequest.value,
        onPressed: () => null,
        widget: ListView.builder(
          itemCount: controller.drugsSearch.length,
          itemBuilder: (context, index) {
            return drug(
              controller.drugsSearch[index].id,
              controller.drugsSearch[index].name,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.searchDrug(query);
    if (controller.drugsSearch.isEmpty) {
      return const Text('drugs are not found!!!').center();
    }
    return ListView.builder(
      itemCount: controller.drugsSearch.length,
      itemBuilder: (context, index) {
        return drug(
          controller.drugsSearch[index].id,
          controller.drugsSearch[index].name,
        );
      },
    );
  }

  Widget drug(int id, String name) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(MdiIcons.medicalCottonSwab),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        title: Text(
          name,
          style: const TextStyle(
            // fontWeight: FontWeight.bold,
            color: Colors.black54,
            fontSize: 24,
          ),
        ),
        onTap: () {
          Get.back();
          controller.getDrugById(id);
        },
      ),
    );
  }
}
