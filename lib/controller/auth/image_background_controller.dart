import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageBackgroundController extends GetxController {
  late ScrollController scrollController;

  @override
  void onInit() {
    scrollController = ScrollController();
    Future.delayed(
      const Duration(milliseconds: 0),
      () => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        //250
        duration: const Duration(seconds: 5000),
        curve: Curves.linear,
      ),
    );
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
