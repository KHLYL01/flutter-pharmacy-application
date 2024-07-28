import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class CustomDropDownFormField extends StatelessWidget {
  CustomDropDownFormField({
    Key? key,
    required this.controller,
    required this.list,
    required this.icon,
    this.isEnable = true,
  }) : super(key: key);

  final TextEditingController controller;
  final List<String> list;
  final IconData icon;
  bool isEnable;

  @override
  Widget build(BuildContext context) {
    if (controller.text == '') {
      controller.text = list[0];
    }
    return SizedBox(
      height: 60,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          style: const TextStyle(
            color: AppColor.style1secondary2,
            fontWeight: FontWeight.bold,
          ),
          isExpanded: false,
          alignment: Alignment.center,
          borderRadius: BorderRadius.circular(20),
          dropdownColor: AppColor.style1main2,
          decoration: InputDecoration(
            fillColor: AppColor.style1main2,
            filled: true,
            prefixIcon: Icon(
              icon,
              color: AppColor.style1secondary2,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                // color: Colors.grey,
                color: AppColor.style1main2,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                // color: Colors.grey,
                color: AppColor.style1main2,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                // color: Colors.grey,
                color: AppColor.style1secondary1,
                width: 2,
              ),
            ),
          ),
          value: controller.text,
          icon: Transform.rotate(
            angle: 3.1415 / 2,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.style1secondary2,
            ),
          ),
          items: [
            ...List.generate(
              list.length,
              (index) => DropdownMenuItem(
                value: list[index],
                child: Text(
                  list[index],
                ),
              ),
            ),
          ],
          onChanged: isEnable ? (value) => controller.text = value! : null,
        ),
      ),
    );
  }
}
