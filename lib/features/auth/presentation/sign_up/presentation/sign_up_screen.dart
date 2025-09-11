import 'package:fitsnap_ai/constants/validator.dart';
import 'package:fitsnap_ai/helpers/loading_helper.dart';
import 'package:fitsnap_ai/networks/api_acess.dart';
import 'package:fitsnap_ai/provider/sign_up_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../common_widgets/custom_back_button.dart';
import '../../../../../common_widgets/custom_elevated_button.dart';
import '../../../../../common_widgets/custom_text_form_field.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../constants/text_font_style.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../helpers/ui_helpers.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<SignUpScreenProvider>(builder: (context, controller, child) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),

                  ///Text : FitSnap AI
                  Text(
                    "FitSnap AI",
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c0000ff,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(60.h),

                  /// ✅ Wrap fields in a Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ///First Name Field
                        CustomFormField(
                          controller: controller.nameController,
                          hintText: "Enter full name",
                          borderColor: AppColors.c000000,
                          borderRadius: 8.h,
                          validator: (value) {
                            if (controller.nameController.text.isEmpty) {
                              return 'Enter your full name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        UIHelper.verticalSpace(20.h),

                        ///Last Name Field
                        // CustomFormField(
                        //   controller: controller.lastNameController,
                        //   hintText: "Enter last name",
                        //   borderColor: AppColors.c000000,
                        //   borderRadius: 8.h,
                        //   validator: (value) {
                        //     if (controller.lastNameController.text.isEmpty) {
                        //       return 'Enter your last name';
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        // ),
                        // UIHelper.verticalSpace(20.h),

                        ///Email Field
                        CustomFormField(
                          controller: controller.eamilController,
                          inputType: TextInputType.emailAddress,
                          hintText: "Enter email address",
                          borderColor: AppColors.c000000,
                          borderRadius: 8.h,
                          validator: emailValidator,
                        ),
                        UIHelper.verticalSpace(20.h),

                        ///Password Field
                        CustomFormField(
                          controller: controller.passwordController,
                          hintText: "Enter password",
                          borderColor: AppColors.c000000,
                          borderRadius: 8.h,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.setPasswordMode();
                            },
                            icon: Icon(
                              controller.passwordMode
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp(r'[^\S\r\n]')),
                          ],
                          onChanged: (value) {
                            controller.passwordController.text =
                                value.replaceAll(RegExp(r'\s+'), '');
                          },
                          validator: passwordValidator,
                        ),
                        UIHelper.verticalSpace(20.h),
                      ],
                    ),
                  ),

                  ///Button : Sign up
                  CustomElevatedButton(
                    buttonTitle: "Sign up",
                    borderRadius: 250.r,
                    isButtonBorderUsed: true,
                    buttonBorderColor: AppColors.c000000,
                    onTap: () async {
                      try {
                        if (_formKey.currentState!.validate()) {
                          bool isSuccess = await postSignUpRx
                              .signUp(
                                fullName: controller.nameController.text,
                                // lastName:
                                //     controller.lastNameController.text.toString(),
                                email: controller.eamilController.text.trim(),
                                password: controller.passwordController.text
                                    .toString(),
                              )
                              .waitingForFutureWithoutBg();

                          if (isSuccess) {
                            NavigationService.navigateTo(Routes.signinScreen);
                            CustomToastMessage(
                                title: 'Success',
                                description:
                                    'Signup succeded. Welcome to FitSnapAI');
                          } else {
                            CustomToastMessage(
                                title: 'Error',
                                description:
                                    'Signup failed. Please try again.');
                          }
                        }
                      } catch (error) {
                        // ⚠️ Catch unexpected errors
                        CustomToastMessage(
                            title: 'Error',
                            description:
                                'Something went wrong. Please try again.');
                        // Optional: log the error for debugging
                        print('Signup Error: $error');
                      }
                    },
                  ),
                  UIHelper.verticalSpace(45.h),

                  ///Text : Already have an account?
                  ///Button : Sign In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextFontStyle.headline25BoldcFFFFFFStyleInter
                            .copyWith(
                          fontSize: 20.sp,
                          color: AppColors.c000000,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      UIHelper.horizontalSpace(5.w),
                      InkWell(
                        onTap: () {
                          NavigationService.navigateTo(Routes.signinScreen);
                        },
                        child: Text(
                          "Sign in",
                          style: TextFontStyle.headline25BoldcFFFFFFStyleInter
                              .copyWith(
                            fontSize: 20.sp,
                            color: AppColors.c000000,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
