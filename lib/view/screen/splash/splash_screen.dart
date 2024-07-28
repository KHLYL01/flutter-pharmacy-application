import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pharmacy_managment_system/view/widget/gradient_background.dart';

import '../../../controller/splash_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/extensions/widget_extension.dart';
import '../auth/auth_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          imageBackground(),
          FadeInDown(
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: AppColor.style1main1.withOpacity(0.5),
                // borderRadius: const BorderRadius.all(Radius.circular(50))),
              ),
              child: const Center(
                child: Text(
                  'Pharmacy System',
                  style: TextStyle(
                    color: AppColor.style1secondary2,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ).align(alignment: const Alignment(0, -0.3)),
          ),
          const SpinKitSpinningLines(
            color: Colors.white,
          ).fittedBox().align(alignment: const Alignment(0, 0.95)),
        ],
      ),
    );
  }
}
