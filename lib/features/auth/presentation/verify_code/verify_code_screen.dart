import 'package:fitai/common_widgets/custom_back_button.dart';
import 'package:fitai/common_widgets/custom_elevated_button.dart';
import 'package:fitai/constants/text_font_style.dart';
import 'package:fitai/features/auth/presentation/verify_code/widget/custom_pinput.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/all_routes.dart';
import 'package:fitai/helpers/navigation_service.dart';
import 'package:fitai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

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
                ///Button : Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomBackButton(),
                ),
                UIHelper.verticalSpace(20.h),

                ///Text : Enter your code
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter your code",
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c000000,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(35.h),

                ///Pinput Box
                CustomPinInput(
                  correctPin: '1234',
                  onCompleted: (pin) {
                    if (pin == '1234') {
                      ///NavigationService.navigateTo(Routes.resetPasswordScreen);
                    } else {
                      Get.snackbar('Error', 'Incorrect PIN');
                    }
                  },
                ),
                UIHelper.verticalSpace(100.h),

                ///Button : Next Button
                CustomElevatedButton(
                  onTap: () {
                    NavigationService.navigateTo(Routes.resetPasswordScreen);
                  },
                  buttonTitle: "Next",
                  borderRadius: 250.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
