import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widgets/custom_back_button.dart';
import '../../../../common_widgets/custom_elevated_button.dart';
import '../../../../common_widgets/custom_text_form_field.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    color: AppColors.c0000ff,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.sp,
                  ),
                ),
                UIHelper.verticalSpace(60.h),

                ///First Name Field
                CustomFormField(
                  hintText: "First name",
                  borderColor: AppColors.c000000,
                  borderRadius: 8.h,
                ),
                UIHelper.verticalSpace(20.h),

                ///Last Name Field
                CustomFormField(
                  hintText: "Last name",
                  borderColor: AppColors.c000000,
                  borderRadius: 8.h,
                ),
                UIHelper.verticalSpace(20.h),

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

                ///Button : Sign up
                CustomElevatedButton(
                  buttonTitle: "Sign up",
                  borderRadius: 250.r,
                  isButtonBorderUsed: true,
                  buttonBorderColor: AppColors.c000000,
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
      ),
    );
  }
}
