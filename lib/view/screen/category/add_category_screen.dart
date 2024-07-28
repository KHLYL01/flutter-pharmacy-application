import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_managment_system/core/functions/valid_input.dart';
import '../../../controller/category_controller.dart';
import '../../../core/class/status_request.dart';
import '../../widget/custom_add_page.dart';
import '../auth/auth_widget.dart';

class AddCategoryScreen extends GetView<CategoryController> {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAddPage(
        title: 'Add Category',
        column: Form(
          key: controller.formState,
          child: Column(
            children: [
              FlipInX(
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 500),
                child: customTextFormField(
                  hint: 'Category Name',
                  icon: Icons.category_outlined,
                  textController: controller.categoryName,
                  validator: (value) => validInput(value, 2, 0, 'password'),
                ),
              ),
              const SizedBox(height: 16),
              FlipInX(
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 500),
                child: Obx(
                  () => controller.statusRequest.value == StatusRequest.loading
                      ? customCircularProgressIndicatorButton()
                      : customButton(
                          title: 'Add Category',
                          onTap: () {
                            controller.addCategory();
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
