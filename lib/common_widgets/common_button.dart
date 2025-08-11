import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isColor = true,
  });

  final String text;
  final VoidCallback onTap;
  final bool? isColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color:
              isColor == true ? AppColors.allPrimaryColor : AppColors.c026cb7,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(text,
              style: TextFontStyle.textStyle16c252c32Satoshi500
                  .copyWith(color: AppColors.cFFFFFF)),
        ),
      ),
    );
  }
}
