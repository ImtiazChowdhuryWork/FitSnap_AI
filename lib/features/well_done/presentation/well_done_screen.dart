import 'package:fitai/common_widgets/custom_back_button.dart';
import 'package:fitai/constants/text_font_style.dart';
import 'package:fitai/gen/assets.gen.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/all_routes.dart';
import 'package:fitai/helpers/navigation_service.dart';
import 'package:fitai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WellDoneScreen extends StatelessWidget {
  const WellDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c0000ff,
      body: SafeArea(
        child: InkWell(
          onTap: () {
            NavigationService.navigateToReplacement(Routes.firstDayScreen);
          },
          child: Padding(
            padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Button : Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(
                      iconColor: AppColors.cFFFFFF,
                    ),
                  ),
                  UIHelper.verticalSpace(140.h),

                  Image.asset(
                    width: 195.w,
                    height: 206.h,
                    fit: BoxFit.cover,
                    Assets.images.tropyImage.path,
                  ),
                  UIHelper.verticalSpace(50.h),

                  ///Text : Well Done
                  Text(
                    "Well Done!",
                    textAlign: TextAlign.center,
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      fontSize: 60.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.verticalSpace(60.h),

                  ///Text : You’re off to an excellent start!
                  Text(
                    "You’re off to an excellent start!",
                    textAlign: TextAlign.center,
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.verticalSpace(25.h),

                  ///We’re creating personalized plan just for you!
                  Text(
                    "We’re creating personalized plan just for you!",
                    textAlign: TextAlign.center,
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
