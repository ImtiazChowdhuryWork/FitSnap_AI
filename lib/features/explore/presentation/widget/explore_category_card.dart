import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreCategoryCard extends StatelessWidget {
  final String categoryName;
  final bool isSelected;
  final void Function()? onTap;
  const ExploreCategoryCard({
    super.key,
    required this.categoryName,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.c3B13CA : AppColors.cd9d7f8,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          categoryName,
          textAlign: TextAlign.center,
          style: isSelected
              ? TextFontStyle.textStyle16cffffffRoboto500
              : TextFontStyle.headline14w400c000000StyledmSans,
        ),
      ),
    );
  }
}
