import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/on_boarding_controller.dart';
import '../../../core/extensions/widget_extension.dart';
import 'on_boarding_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          pageViewOnBoarding(),
          indicatorOnBoarding(),
          skipOnBoarding()
              .align(
                alignment: AlignmentDirectional.topEnd,
              )
              .paddingDirectional(
                const EdgeInsetsDirectional.only(
                  top: 16,
                  end: 16,
                ),
              ),
          getStartedButtonOnBoarding().align(
            alignment: const Alignment(0, 0.725),
          ),
        ],
      ).makeSafeArea().willPopScope(),
    );
  }
}
