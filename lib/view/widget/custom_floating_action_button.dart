import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';

import '../../core/constant/color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.style1main2,
      onPressed: onPressed,
      shape: const CircleBorder(),
      child: Text(
        text.tr,
        style: const TextStyle(fontSize: 12, color: AppColor.style1secondary2),
        textAlign: TextAlign.center,
      ),
    ).fittedBox();
  }
}
