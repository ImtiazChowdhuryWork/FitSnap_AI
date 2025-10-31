import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/responsive_helper.dart';

/// Custom elevated button with gradient background
/// Used throughout onboarding and other screens
class CustomElevatedButton extends StatelessWidget {
  final String buttonTitle;
  final double? buttonWidth;
  final Color? buttonColor;
  final VoidCallback? onTap;

  const CustomElevatedButton({
    super.key,
    required this.buttonTitle,
    this.buttonWidth,
    this.buttonColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: buttonWidth ?? double.infinity,
          height: ResponsiveHelper.spacing(context, 50),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: buttonColor != null
                  ? [buttonColor!, buttonColor!.withOpacity(0.8)]
                  : [AppColors.c0000ff, AppColors.c5454FF],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              buttonTitle,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveHelper.fontSize(context, 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom card widget with tap interaction
/// Used for selectable options in onboarding
class CustomCard extends StatelessWidget {
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Widget? child;

  const CustomCard({
    super.key,
    this.onTap,
    this.width,
    this.height,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? AppColors.cE6E8ED,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Custom container widget with shadow and rounded corners
/// Generic container for various content
class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const CustomContainer({
    super.key,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
