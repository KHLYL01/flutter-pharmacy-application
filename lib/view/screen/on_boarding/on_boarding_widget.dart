import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/on_boarding_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/extensions/widget_extension.dart';
import '../../../data/datasource/static/static.dart';

Widget getStartedButtonOnBoarding() {
  OnBoardingControllerImp controller = Get.find();
  return Obx(
    () => controller.currentIndex.value == onBoardingList.length - 1
        ? FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColor.style1secondary1,
              ),
              child: Text(
                'Get Started'.tr,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ).onTap(() {
            controller.getStarted();
          })
        : Container(),
  );
}

Widget indicatorOnBoarding() {
  OnBoardingControllerImp controller = Get.find();
  return Obx(
    () => Row(
      children: [
        ...List.generate(
          onBoardingList.length,
          (index) => circleIndicator(controller, index),
        ),
      ],
    ).fittedBox().align(
          alignment: const Alignment(0, 0.9),
        ),
  );
}

Widget circleIndicator(var controller, int index) {
  return AnimatedContainer(
    width: controller.currentIndex.value == index ? 20 : 16,
    height: controller.currentIndex.value == index ? 20 : 16,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: controller.currentIndex.value == index
          ? AppColor.style1secondary1
          : AppColor.style1secondary2,
    ),
    duration: const Duration(milliseconds: 700),
  )
      .onTap(
        () => controller.onClickIndicator(index),
      )
      .paddingDirectional(
        const EdgeInsetsDirectional.only(end: 8),
      );
}

Widget pageViewOnBoarding() {
  OnBoardingControllerImp controller = Get.find();
  return PageView.builder(
    controller: controller.pageController,
    itemCount: onBoardingList.length,
    onPageChanged: (value) => controller.onPageChange(value),
    itemBuilder: (context, index) => Column(
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 700),
          child: SizedBox(
            height: 320,
            child: Image.asset(
              onBoardingList[index].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FlipInY(
          delay: const Duration(milliseconds: 500),
          child: Text(
            onBoardingList[index].title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColor.style1secondary1,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FlipInX(
          delay: const Duration(milliseconds: 1000),
          child: Text(
            onBoardingList[index].description,
            textAlign: TextAlign.center,
            maxLines: 100,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              height: 1.8,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.style1main2,
            ),
          ),
        ).paddingSymmetric(vertical: 16, horizontal: 28),
      ],
    ).paddingOnly(top: 40.0, left: 16, right: 16),
  );
}

Widget skipOnBoarding() {
  OnBoardingControllerImp controller = Get.find();
  return Text(
    'Skip'.tr,
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: AppColor.style1secondary1,
    ),
  ).onTap(() {
    controller.skip();
  });
}
