import 'dart:developer';

import 'package:fitai/common_widgets/custom_elevated_button.dart';
import 'package:fitai/common_widgets/custom_text_form_field.dart';
import 'package:fitai/constants/text_font_style.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/all_routes.dart';
import 'package:fitai/helpers/loading_helper.dart';
import 'package:fitai/helpers/navigation_service.dart';
import 'package:fitai/provider/sign_in_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common_widgets/custom_back_button.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../../../networks/api_acess.dart';
import '../../../../networks/dio/dio.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  /// Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    DioSingleton.instance.updateForAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInScreenController>(
        builder: (context, controller, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
            child: Form(
              key: _formKey, // ✅ attach the form key here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),

                  ///Text : FitAI
                  Text(
                    "FitAI",
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c0000ff,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(65.h),

                  ///Email Field
                  CustomFormField(
                    controller: controller.emailController,
                    hintText: "Email Address",
                    borderColor: AppColors.c000000,
                    borderRadius: 8.h,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                  UIHelper.verticalSpace(20.h),

                  ///Password Field
                  CustomFormField(
                    controller: controller.passwordController,
                    hintText: "Password",
                    borderColor: AppColors.c000000,
                    borderRadius: 8.h,
                    isPass: true,
                    isObsecure: !controller.isPasswordVisible,
                    suffixIcon: IconButton(
                      onPressed: () => controller.togglePasswordVisibility(),
                      icon: Icon(controller.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  UIHelper.verticalSpace(20.h),

                  ///Button : Forgot Password?
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        NavigationService.navigateTo(
                            Routes.sendVerificationScreen);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextFontStyle.headline25BoldcFFFFFFStyleInter
                            .copyWith(
                          color: AppColors.c0000ff,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(50.h),

                  ///Button : Sign In
                  CustomElevatedButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        appData.write(
                          kEmail,
                          controller.emailController.text.trim(),
                        );

                        bool isLogedin = await postLoginRxObj
                            .postLogin(
                                email: controller.emailController.text,
                                password: controller.passwordController.text)
                            .waitingForFutureWithoutBg();
                        if (isLogedin) {
                          log("Cheaking email ===== 1 ${controller.emailController.text}");
                          controller.emailController.clear();
                          controller.passwordController.text = '';
                          // ✅ only navigate if validation passes
                          NavigationService.navigateToUntilReplacement(
                              Routes.navBarScreen);
                          CustomToastMessage(
                              title: 'Success',
                              description:
                                  'Signin succeded. Welcome to FitSnapAI');
                          log("Cheaking email ===== 2 ${controller.emailController.text}");
                        } else {
                          CustomToastMessage(
                              title: 'Error',
                              description: postLoginRxObj.message);
                        }
                      }
                    },
                    buttonTitle: "Sign in",
                    borderRadius: 250.r,
                    isButtonBorderUsed: true,
                    buttonBorderColor: AppColors.c000000,
                  ),
                  UIHelper.verticalSpace(45.h),

                  ///Text : Don’t have an account? / Sign Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
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
                          NavigationService.navigateTo(Routes.signUpScreen);
                        },
                        child: Text(
                          "Sign Up",
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
        ),
      );
    });
  }
}
