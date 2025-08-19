import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/ui_helpers.dart';

class SubcriptionPackageType extends StatelessWidget {
  final String subscriptionPackageType;
  final double subscriptonPackagePrice;
  final String subscriptionPackageLength;
  const SubcriptionPackageType({
    super.key,
    required this.subscriptionPackageType,
    required this.subscriptonPackagePrice,
    required this.subscriptionPackageLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subscriptionPackageType,
          style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
            color: AppColors.c000000,
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(10.h),

        ///Text : $500/ month
        Text(
          "\$$subscriptonPackagePrice/$subscriptionPackageLength",
          style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
            color: AppColors.c000000,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
