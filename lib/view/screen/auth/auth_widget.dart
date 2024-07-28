import 'package:flutter/services.dart';

import '../../../controller/auth/obscureController.dart';
import '../../../core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/image_background_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/image_assets.dart';

Widget imageBackground({
  String image = AppImageAssets.background,
  bool isSuccess = true,
}) {
  ImageBackgroundController controller = Get.put(ImageBackgroundController());
  return Stack(
    children: [
      GridView.count(
        controller: controller.scrollController,
        crossAxisCount: 2,
        addAutomaticKeepAlives: true,
        scrollDirection: Axis.vertical,
        children: List.generate(
          1000,
          (index) => SizedBox(
            height: Get.context!.height / 2,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      isSuccess
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            )
          : Container(
              color: Colors.white.withOpacity(0),
            ),
    ],
  );
}

Widget gradientBackground() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          // AppColor.mainColor.withOpacity(0.5),
          // // AppColor.mainColor,
          // AppColor.style1secondary1.withOpacity(0.3),
          // AppColor.style1secondary1.withOpacity(0.7),
          AppColor.style1secondary1,
          AppColor.style1secondary1,
        ],
        begin: AlignmentDirectional.topCenter,
        end: AlignmentDirectional.bottomCenter,
      ),
    ),
  );
}

Widget textRow({
  required String title,
  required String body,
  required GestureTapCallback onTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      Text(
        body,
        style: const TextStyle(
          // color: AppColor.mainColor.withOpacity(0.9),
          color: AppColor.style1secondary1,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ).onTap(
        onTap,
      ),
    ],
  );
}

Widget customButton({
  required String title,
  GestureTapCallback? onTap,
  Color color = AppColor.style1secondary1,
  double radius = 50,
}) {
  return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, AppColor.style1main2],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ).paddingSymmetric(vertical: 16, horizontal: 16),
          )).paddingSymmetric(horizontal: 8).onTap(
        onTap ?? () {},
      );
}

Widget customCircularProgressIndicatorButton({
  double radius = 50,
  Color color = AppColor.style1secondary1,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, AppColor.style1main2],
        begin: AlignmentDirectional.topStart,
        end: AlignmentDirectional.bottomEnd,
      ),
      borderRadius: BorderRadius.circular(radius),
    ),
    child: Center(
        child: const CircularProgressIndicator(color: Colors.white)
            .paddingSymmetric(vertical: 16, horizontal: 16)),
  ).paddingSymmetric(horizontal: 8);
}

Widget customTextFormField({
  required String hint,
  required IconData icon,
  required TextEditingController textController,
  required FormFieldValidator? validator,
  String tag = '',
  bool isEnable = true,
  String? label,
  bool isSecret = false,
  bool isWritable = true,
  int maxLines = 1,
  double radius = 50,
  double prefIconPadding = 0,
  ValueChanged<String>? onChange,
  FocusNode? focusNode,
  TextInputType? keyboardType,
  GestureTapCallback? onTap,
}) {
  Get.put(ObscureController());
  return GetBuilder<ObscureController>(
    builder: (controller) => TextFormField(
      style: const TextStyle(
          color: AppColor.style1secondary2, fontWeight: FontWeight.bold),
      focusNode: focusNode, textAlign: TextAlign.start,
      maxLines: maxLines, minLines: 1, validator: validator,
      controller: textController,
      obscureText: isSecret ? controller.obscure : false,
      onTap: onTap ?? () => null,
      keyboardType: keyboardType != TextInputType.number
          ? isWritable
              ? keyboardType
              : TextInputType.none
          : TextInputType.number,
      inputFormatters: keyboardType == TextInputType.number
          ? [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
              TextInputFormatter.withFunction((oldValue, newValue) {
                final text = newValue.text;
                return text.isEmpty
                    ? newValue
                    : double.tryParse(text) == null
                        ? oldValue
                        : newValue;
              }),
            ]
          : null,
      onFieldSubmitted: onChange,
      // onChanged: onChange,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: prefIconPadding),
          child: Icon(
            icon,
            color: AppColor.style1secondary2,
          ),
        ),
        suffixIcon: isSecret
            ? IconButton(
                onPressed: () => controller.changeObscure(),
                icon: Icon(
                  controller.obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: controller.obscure
                      ? AppColor.style1secondary2
                      : AppColor.style1secondary1,
                ),
              ).paddingDirectional(
                const EdgeInsetsDirectional.only(end: 8),
              )
            : null,
        fillColor: AppColor.style1main2,
        filled: true,
        label: label != null
            ? Container(
                decoration: BoxDecoration(
                  color: AppColor.style1secondary2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColor.style1secondary1,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ).paddingSymmetric(horizontal: 16),
              )
            : null,
        enabled: isEnable,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            // color: Colors.grey,
            color: AppColor.style1main2,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            // color: Colors.grey,
            color: AppColor.style1main2,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            // color: Colors.grey,
            color: AppColor.style1secondary1,
            width: 2,
          ),
        ),
        errorStyle: const TextStyle(
          backgroundColor: Colors.white,
        ),
      ),
      cursorColor: AppColor.style1secondary1,
    ),
  );
}
