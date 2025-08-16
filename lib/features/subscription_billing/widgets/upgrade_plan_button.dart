import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';

class UpgradePlanButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const UpgradePlanButton({
    super.key,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: AppColors.cdfe0f9,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            title,
            style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
              color: AppColors.c000000,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
