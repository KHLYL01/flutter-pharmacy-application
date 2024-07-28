import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_managment_system/core/constant/color.dart';

import '../../controller/shared/image_controller.dart';

Future getImageUseBottomSheet(ImageController controller) {
  return Get.bottomSheet(
    enableDrag: true,
    Container(
      decoration: const BoxDecoration(
        color: AppColor.style1main2,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 32,
            decoration: BoxDecoration(
              color: AppColor.style1secondary2,
              borderRadius: BorderRadius.circular(50),
            ),
          ).paddingOnly(top: 8),
          ListTile(
            title: const Text(
              'camera',
              style: TextStyle(color: AppColor.style1secondary2),
            ),
            leading: const Icon(Icons.camera, color: AppColor.style1secondary1),
            onTap: () async {
              await controller.getImage(ImageSource.camera);
              Get.back();
            },
          ),
          ListTile(
            title: const Text(
              'gallery',
              style: TextStyle(color: AppColor.style1secondary2),
            ),
            leading: const Icon(Icons.image, color: AppColor.style1secondary1),
            onTap: () async {
              await controller.getImage(ImageSource.gallery);
              Get.back();
            },
          ),
        ],
      ).paddingOnly(bottom: 8),
    ),
  );
}
