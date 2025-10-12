import 'package:fitai/common_widgets/custom_back_button.dart';
import 'package:fitai/constants/text_font_style.dart';
import 'package:fitai/gen/assets.gen.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widgets/custom_elevated_button.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';

class FirstDayScreen extends StatelessWidget {
  const FirstDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///Button : Go Back
                CustomBackButton(),
                UIHelper.verticalSpace(126.h),

                ///Image : First Day Image
                Image.asset(
                  height: 320.h,
                  width: 338.w,
                  fit: BoxFit.cover,
                  Assets.images.firstDayImage.path,
                ),
                UIHelper.verticalSpace(30.h),

                ///Text : First Day
                Text(
                  "first Day",
                  style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    color: AppColors.c000000,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpace(5.h),

                ///Text : Embrace the journey,feel the joy!
                Text(
                  "Embrace the journey,feel the joy!",
                  style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    color: AppColors.c000000,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UIHelper.verticalSpace(100.h),

                ///Button : Got It
                CustomElevatedButton(
                  onTap: () {
                    NavigationService.navigateTo(Routes.navBarScreen);
                  },
                  buttonTitle: "Got It",
                  buttonWidth: 0.8.sw,
                  borderRadius: 20.r,
                  isButtonBorderUsed: true,
                  buttonBorderColor: AppColors.c000000,
                ),
                UIHelper.verticalSpace(10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
