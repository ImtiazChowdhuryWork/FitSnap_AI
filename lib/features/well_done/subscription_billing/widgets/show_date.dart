import 'package:fitai/constants/text_font_style.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowDate extends StatelessWidget {
  final String title;
  final String date;
  const ShowDate({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Title
        Text(
          title,
          style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
            color: AppColors.c5D5C5C,
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        UIHelper.verticalSpace(5.h),

        ///Date
        Text(
          date,
          style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
            color: AppColors.c5D5C5C,
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
