import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Alignment? alignment;
  final Color? borderColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  const CustomContainer({
    super.key,
    required this.child,
    this.padding,
    this.alignment,
    this.borderColor,
    this.borderRadius,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 1.sw,
      height: height,
      padding: padding ?? EdgeInsets.all(10.sp),
      alignment: alignment ?? Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.c0000ff.withAlpha(20),
        border: Border.all(
          width: 0.2.sp,
          color: borderColor ?? AppColors.c0000ff,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
      ),
      child: child,
    );
  }
}
