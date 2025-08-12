import 'package:fitsnap_ai/common_widgets/custom_elevated_button.dart';
import 'package:fitsnap_ai/common_widgets/custom_text_form_field.dart';
import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/all_routes.dart';
import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widgets/custom_back_button.dart';
import '../../helpers/ui_helpers.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
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
                style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                  color: AppColors.c0000ff,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
              UIHelper.verticalSpace(65.h),

              ///Email Field
              CustomFormField(
                hintText: "Email Address",
                borderColor: AppColors.c000000,
                borderRadius: 8.h,
              ),
              UIHelper.verticalSpace(20.h),

              ///Password Field
              CustomFormField(
                hintText: "Password",
                borderColor: AppColors.c000000,
                borderRadius: 8.h,
                suffixIcon: Icon(Icons.visibility),
              ),
              UIHelper.verticalSpace(20.h),

              ///Button : Forgot Password?
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    NavigationService.navigateTo(Routes.sendVerificationScreen);
                  },
                  child: Text(
                    "Forgot Password?",
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
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
                onTap: () {
                  NavigationService.navigateTo(Routes.navBarScreen);
                },
                buttonTitle: "Sign in",
                borderRadius: 250.r,
                isButtonBorderUsed: true,
                buttonBorderColor: AppColors.c000000,
              ),
              UIHelper.verticalSpace(45.h),

              ///Text : Don’t have an account?
              ///Button : Sign Up

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account?",
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
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
    );
    ;
  }
}
