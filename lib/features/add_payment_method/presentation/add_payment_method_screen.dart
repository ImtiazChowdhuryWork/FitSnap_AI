import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/all_routes.dart';
import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ///Top Image Section
            Container(
              height: 0.3.sh,
              width: 1.sw,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: 0.3,
                  image: AssetImage(
                    Assets.images.addPaymentMethodScreenImage.path,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///Text : Design your Trial
                  Text(
                    "Design your Trial",
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c0000ff,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),

                  Text(
                    "1. Personalized workout plans",
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c000000,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),

                  ///Text : Personalized workout plans
                  Text(
                    "2. Unlimited access to all exercises",
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c000000,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(50.h),

            ///Text : Google Play Section
            Container(
              width: 1.sw,
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(color: AppColors.cd9d7f8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Text : Google Play
                  Text(
                    "Google Play",
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c000000,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),

                  ///Text : Add payment method to your Account
                  Text(
                    "Add payment method to your Account",
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c000000,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                ],
              ),
            ),
            UIHelper.verticalSpace(50.h),

            ///Add Card Section
            InkWell(
              onTap: () {
                NavigationService.navigateTo(Routes.wellDoneScreen);
              },
              child: Container(
                width: 0.9.sw,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // How much it spreads
                      blurRadius: 5, // Softness of shadow
                      offset: Offset(0, 3), // Horizontal, Vertical movement
                    ),
                  ],
                  border: Border.all(
                    color: AppColors.c0000ff,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///Card Icon
                    Image.asset(
                      height: 44.h,
                      width: 44.w,
                      fit: BoxFit.cover,
                      color: AppColors.c000000,
                      Assets.images.cardIcon.path,
                    ),

                    ///Text : Add Card
                    Text(
                      "Add Card",
                      style: TextFontStyle.headline25BoldcFFFFFFStyleInter
                          .copyWith(
                        color: AppColors.c000000,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    ///Rainbox Circle Icon
                    Image.asset(
                      height: 44.h,
                      width: 44.w,
                      fit: BoxFit.cover,
                      Assets.images.rainboxCircleIcon.path,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
