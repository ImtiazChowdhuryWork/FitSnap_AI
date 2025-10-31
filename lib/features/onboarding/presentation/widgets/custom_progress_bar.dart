import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/responsive_helper.dart';

/// Custom progress bar widget for onboarding flow
/// Shows current step progress with gradient fill and percentage
class CustomProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double height;
  final Color backgroundColor;
  final List<Color> gradientColors;

  const CustomProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.height = 14.0,
    this.backgroundColor = AppColors.cE6E8ED,
    this.gradientColors = const [
      AppColors.c3B13CA,
      AppColors.c0000ff,
      AppColors.c5454FF,
    ],
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress: 0% for first step, 100% for last step
    final progress = totalSteps > 1 ? (currentStep) / (totalSteps - 1) : 0.0;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: ResponsiveHelper.fontSize(context, 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ResponsiveHelper.spacing(context, 8)),
          Text(
            "Step $currentStep of $totalSteps",
            style: TextStyle(
              color: AppColors.c000000,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveHelper.fontSize(context, 12),
            ),
          ),
        ],
      ),
    );
  }
}
