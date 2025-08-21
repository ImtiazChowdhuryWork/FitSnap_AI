import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  final Widget child;
  double? width;
  double? height;
  Color? color;
  Function()? onTap;

  CustomCard({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 1.sw,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppColors.cFFFFFF,
          boxShadow: [
            BoxShadow(
              color: AppColors.c000000.withValues(alpha: 0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: child,
      ),
    );
  }
}
