import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import '../../../common_widgets/custom_radius_button.dart';

class Subscriptiontypewidget extends StatelessWidget {
  final int index;
  final String subscriptionType;
  final String subscriptionPrice;

  const Subscriptiontypewidget({
    super.key,
    required this.index,
    required this.subscriptionType,
    required this.subscriptionPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.cd9d9d9,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Trial Type + Cost
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subscriptionType,
                style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                  color: AppColors.c000000,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              UIHelper.verticalSpace(5.h),
              Text(
                "BDT $subscriptionPrice.0",
                style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                  color: AppColors.c000000,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          /// Select Button
          CustomRadiusButtonWidget(index: index),
        ],
      ),
    );
  }
}
