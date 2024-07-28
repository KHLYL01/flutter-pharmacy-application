import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

alertExitApp() {
  return Get.defaultDialog(
    title: 'alert',
    middleText: 'do you want exit from application',
    actions: [
      ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: () {
          exit(0);
        },
        child: const Text('Confirm'),
      ),
    ],
  );
}
