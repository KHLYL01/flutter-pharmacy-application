import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/view/widget/gradient_background.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/extensions/widget_extension.dart';
import 'auth_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          imageBackground(),
          FadeInDown(
            child: Form(
              key: controller.formState,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.style1main1.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: AppColor.style1secondary2,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlipInX(
                          delay: const Duration(milliseconds: 700),
                          duration: const Duration(milliseconds: 500),
                          child: customTextFormField(
                            hint: 'Email',
                            icon: MdiIcons.emailLockOutline,
                            keyboardType: TextInputType.emailAddress,
                            textController: controller.emailController,
                            validator: (value) => validInput(
                              controller.emailController.text,
                              8,
                              30,
                              'email',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        FlipInX(
                          delay: const Duration(milliseconds: 1000),
                          duration: const Duration(milliseconds: 500),
                          child: customTextFormField(
                            hint: 'Password',
                            icon: MdiIcons.keyOutline,
                            textController: controller.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            isSecret: true,
                            validator: (value) => validInput(
                              controller.passwordController.text,
                              6,
                              20,
                              'password',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FlipInX(
                          delay: const Duration(milliseconds: 1300),
                          duration: const Duration(milliseconds: 500),
                          child: Obx(
                            () => controller.statusRequest.value ==
                                    StatusRequest.loading
                                ? customCircularProgressIndicatorButton()
                                : customButton(
                                    title: 'Login',
                                    onTap: () {
                                      controller.login();
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ).expanded(
                    flex: 1,
                  ),
                  SizedBox(
                    height: context.height / 16,
                  ),
                  textRow(
                    title: 'Not registered yet? ',
                    body: 'Sign Up',
                    onTap: () {
                      controller.goToSignUp();
                    },
                  ).paddingOnly(bottom: 20),
                ],
              ).paddingOnly(top: 50, left: 16, right: 16, bottom: 16),
            ),
          ).align(
            alignment: Alignment.bottomCenter,
          ),
        ],
      ).makeSafeArea().willPopScope(),
    );
  }
}
