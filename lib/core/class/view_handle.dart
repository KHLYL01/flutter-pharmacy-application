import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_managment_system/core/class/status_request.dart';
import 'package:pharmacy_managment_system/core/constant/color.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';

class ViewHandle extends StatelessWidget {
  const ViewHandle({
    Key? key,
    required this.widget,
    required this.statusRequest,
    required this.onPressed,
  }) : super(key: key);

  final Widget widget;
  final StatusRequest statusRequest;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    switch (statusRequest) {
      case StatusRequest.loading:
        return const CircularProgressIndicator()
            .align(alignment: Alignment.bottomCenter)
            .paddingOnly(bottom: 32);
      case StatusRequest.serverException || StatusRequest.offlineFailure:
        return TextButton(
          onPressed: onPressed,
          child: const Row(
            children: [
              Text(
                "Reconnect",
                style: TextStyle(color: AppColor.style1secondary1),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.wifi_off_rounded,
                size: 32,
                color: AppColor.style1main2,
              ),
            ],
          ),
        )
            .fittedBox()
            .align(alignment: Alignment.bottomCenter)
            .paddingOnly(bottom: 32);
      default:
        return widget;
    }
  }
}
