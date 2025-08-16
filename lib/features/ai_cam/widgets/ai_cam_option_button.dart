import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/ui_helpers.dart';

class AiCamOptionButton extends StatelessWidget {
  final String image;
  final String title;
  final void Function()? onTap;
  const AiCamOptionButton({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ///Image : Opton Image
          Container(
            padding: EdgeInsets.all(20.sp),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.cdfe0f9,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.asset(
              width: 100.w,
              height: 100.h,
              color: AppColors.c3f421a,
              fit: BoxFit.cover,
              image,
            ),
          ),
          UIHelper.verticalSpace(10.h),

          ///Text : Option Title
          Text(
            title,
            style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
              color: AppColors.c000000,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
