import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMealCard extends StatelessWidget {
  final String mealType;
  final String mealDescription;
  final String mealImage;
  const CustomMealCard({
    super.key,
    required this.mealType,
    required this.mealDescription,
    required this.mealImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.sp,
      color: AppColors.cd9d9d9,
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: AppColors.cd9d9d9,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Text : Meal Type
            ///Text : Meal Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///Text : Meal Type
                  Text(
                    mealType,
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c000000,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.verticalSpace(5.h),

                  ///Text : Meal Description
                  Text(
                    mealDescription,
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c000000,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  UIHelper.verticalSpace(5.h),
                ],
              ),
            ),

            Image.asset(
              mealImage,
              width: 112.w,
              height: 106.h,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
