import 'package:fitai/common_widgets/custom_back_button.dart';
import 'package:fitai/common_widgets/custom_elevated_button.dart';
import 'package:fitai/common_widgets/custom_text_form_field.dart';
import 'package:fitai/constants/text_font_style.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/all_routes.dart';
import 'package:fitai/helpers/navigation_service.dart';
import 'package:fitai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendVerificatinCodeScreen extends StatelessWidget {
  const SendVerificatinCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Button : Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomBackButton(),
                ),
                UIHelper.verticalSpace(20.h),

                ///Text : Enter your email
                Text(
                  "Enter your email",
                  style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    color: AppColors.c000000,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                UIHelper.verticalSpace(40.h),

                ///Email Field
                CustomFormField(
                  hintText: "Email Address",
                  borderColor: AppColors.c000000,
                ),
                UIHelper.verticalSpace(20.h),

                ///Text : We’ll mail you a code to verify really you.
                Text(
                  "We’ll mail you a code to verify really you.",
                  style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    color: AppColors.c000000,
                    fontSize: 18.sp,
                  ),
                ),
                UIHelper.verticalSpace(100.h),

                ///Button : Next
                CustomElevatedButton(
                  onTap: () {
                    NavigationService.navigateTo(Routes.verifyCodeScreen);
                  },
                  buttonTitle: "Next",
                  borderRadius: 250.r,
                  isButtonBorderUsed: true,
                  buttonBorderColor: AppColors.c000000,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
