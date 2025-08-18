import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widgets/custom_elevated_button.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';

class RegistrationSuccessfulScreen extends StatelessWidget {
  const RegistrationSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            UIHelper.kDefaulutPadding(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///Text : Hello,....User Name
              Text(
                "Hello Eshi",
                style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.c000000,
                ),
              ),
              UIHelper.verticalSpace(15.h),

              ///Text : Your registion successfully completed
              Text(
                "Your registration successfully completed",
                textAlign: TextAlign.center,
                style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.c000000,
                ),
              ),
              UIHelper.verticalSpace(120.h),

              ///Button : Continue
              CustomElevatedButton(
                onTap: () {
                  NavigationService.navigateTo(Routes.navBarScreen);
                },
                buttonTitle: "Continue",
                borderRadius: 250.r,
                isButtonBorderUsed: true,
                buttonBorderColor: AppColors.c000000,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
