import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';

import '../../core/constant/color.dart';
import '../screen/auth/auth_widget.dart';
import 'gradient_background.dart';

class CustomAddPage extends StatelessWidget {
  const CustomAddPage({
    Key? key,
    required this.title,
    required this.column,
  }) : super(key: key);

  final String title;
  final Widget column;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          imageBackground(),
          FadeInDown(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.style1main1.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: AppColor.style1secondary2,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(child: column).expanded(flex: 1),
              ],
            ).paddingOnly(top: 50, left: 16, right: 16, bottom: 16),
          ),
        ],
      ).makeSafeArea(),
    );
  }
}
