import 'package:fitsnap_ai/constants/app_list.dart';
import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/features/meal/widgets/custom_meal_card.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///Text : Healthy Meal Plan
              Text(
                "Healthy Meal Plan",
                style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                  fontSize: 40.sp,
                  color: AppColors.c000000,
                  fontWeight: FontWeight.w700,
                ),
              ),
              UIHelper.verticalSpace(20.h),

              ///Show Meal
              Expanded(
                child: ListView.separated(
                  itemCount: AppList.mealLit.length,
                  separatorBuilder: (context, index) =>
                      UIHelper.verticalSpace(10.h),
                  itemBuilder: (context, index) {
                    var data = AppList.mealLit[index];
                    return CustomMealCard(
                      mealType: data.mealType,
                      mealDescription: data.mealDescription,
                      mealImage: data.mealImage,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
