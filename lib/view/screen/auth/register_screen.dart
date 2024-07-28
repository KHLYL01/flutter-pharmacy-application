import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_managment_system/view/widget/custom_dropdown_form_field.dart';
import 'package:pharmacy_managment_system/view/widget/gradient_background.dart';

import '../../../controller/auth/register_controller.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/extensions/widget_extension.dart';
import 'auth_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());
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
                        'Sign Up',
                        style: TextStyle(
                            color: AppColor.style1secondary2,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Flexible(
                    child: GetBuilder<RegisterController>(
                      builder: (controller) => PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlipInX(
                                delay: const Duration(milliseconds: 700),
                                duration: const Duration(milliseconds: 500),
                                child: customButton(
                                    title: 'Admin',
                                    onTap: () {
                                      controller.getRole("admin");
                                    }),
                              ),
                              const SizedBox(height: 24),
                              FlipInX(
                                delay: const Duration(milliseconds: 1000),
                                duration: const Duration(milliseconds: 500),
                                child: customButton(
                                    title: 'User',
                                    onTap: () {
                                      controller.getRole("user");
                                    }),
                              ),
                              const SizedBox(height: 64),
                            ],
                          ).paddingSymmetric(horizontal: 32),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlipInX(
                                  delay: const Duration(milliseconds: 700),
                                  duration: const Duration(milliseconds: 500),
                                  child: customTextFormField(
                                    hint: 'Full Name',
                                    icon: MdiIcons.accountOutline,
                                    textController:
                                        controller.fullNameController,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 12),
                                FlipInX(
                                  delay: const Duration(milliseconds: 1000),
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
                                  delay: const Duration(milliseconds: 1300),
                                  duration: const Duration(milliseconds: 500),
                                  child: customTextFormField(
                                    hint: 'Password',
                                    icon: MdiIcons.keyOutline,
                                    keyboardType: TextInputType.visiblePassword,
                                    textController:
                                        controller.passwordController,
                                    isSecret: true,
                                    validator: (value) => validInput(
                                      controller.emailController.text,
                                      6,
                                      20,
                                      'password',
                                    ),
                                  ),
                                ),
                                controller.role == 'admin'
                                    ? const SizedBox(height: 16)
                                    : Container(),
                                controller.role == 'admin'
                                    ? FlipInX(
                                        delay:
                                            const Duration(milliseconds: 1600),
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: customTextFormField(
                                          hint: 'Pharmacy Name',
                                          icon: Icons.local_pharmacy_outlined,
                                          textController:
                                              controller.pharmacyNameController,
                                          validator: (value) {
                                            return null;
                                          },
                                        ),
                                      )
                                    : Container(),
                                controller.role == 'admin'
                                    ? const SizedBox(height: 12)
                                    : Container(),
                                controller.role == 'admin'
                                    ? FlipInX(
                                        delay:
                                            const Duration(milliseconds: 1900),
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: customTextFormField(
                                          hint: 'Phone Number',
                                          icon: MdiIcons.phoneOutline,
                                          keyboardType: TextInputType.phone,
                                          textController:
                                              controller.phoneNumberController,
                                          validator: (value) => validInput(
                                            controller.emailController.text,
                                            6,
                                            20,
                                            'password',
                                          ),
                                        ),
                                      )
                                    : Container(),
                                controller.role == 'admin'
                                    ? const SizedBox(height: 16)
                                    : Container(),
                                controller.role == 'admin'
                                    ? FlipInX(
                                        delay:
                                            const Duration(milliseconds: 2200),
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: CustomDropDownFormField(
                                          controller:
                                              controller.regionController,
                                          icon: Icons.location_on_outlined,
                                          list: const [
                                            'Select Region',
                                            'الكاشف',
                                            'السبيل',
                                            'المطار',
                                            'شمال الخط',
                                            'القصور',
                                            'السحاري',
                                          ],
                                        ),
                                      )
                                    : Container(),
                                const SizedBox(height: 16),
                                FlipInX(
                                  delay: Duration(
                                    milliseconds: controller.role == 'admin'
                                        ? 2500
                                        : 1600,
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                  child: Obx(
                                    () => controller.statusRequest.value ==
                                            StatusRequest.loading
                                        ? customCircularProgressIndicatorButton()
                                        : customButton(
                                            title: 'Sign Up',
                                            onTap: () {
                                              controller.register();
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  textRow(
                    title: 'Already have account? ',
                    body: 'Login',
                    onTap: () {
                      controller.goToLogin();
                    },
                  ).paddingOnly(bottom: 20),
                ],
              ),
            ).paddingOnly(top: 50, left: 16, right: 16, bottom: 16),
          ).align(
            alignment: Alignment.bottomCenter,
          ),
        ],
      ).makeSafeArea().willPopScope(),
    );
  }
}
