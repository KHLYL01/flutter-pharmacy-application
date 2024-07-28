import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_managment_system/view/widget/gradient_background.dart';

import '../../../controller/auth/success_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/extensions/widget_extension.dart';

import '../../widget/lottie_animation.dart';
import 'auth_widget.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SuccessControllerImp controller = Get.put(SuccessControllerImp());
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          imageBackground(),
          FadeInUp(
            delay: const Duration(milliseconds: 1500),
            child: const Text(
              'go to login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColor.style1secondary1,
              ),
            ).onTap(() {
              controller.goToLogin();
            }),
          ).align(
            alignment: const Alignment(0, 0.9),
          ),
          ElasticIn(
            delay: const Duration(milliseconds: 1000),
            duration: const Duration(milliseconds: 1000),
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                color: AppColor.style1secondary2,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.style1main1,
                    offset: Offset(3, 3),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: AppColor.style1main1,
                    offset: Offset(-3, -3),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ).align(
            alignment: const Alignment(0, -0.7),
          ),
          const LottieAnimation().align(
            alignment: const Alignment(0, -0.7),
          ),
          FadeInUp(
            delay: const Duration(seconds: 1),
            child: const Text(
              'Done!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: AppColor.style1main1,
              ),
            ),
          ).align(
            alignment: const Alignment(0, -0.3),
          ),
        ],
      ).makeSafeArea().willPopScope(),
    );
  }
}
