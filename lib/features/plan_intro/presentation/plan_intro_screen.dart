import 'package:fitsnap_ai/common_widgets/custom_elevated_button.dart';
import 'package:fitsnap_ai/constants/app_constants.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/all_routes.dart';
import 'package:fitsnap_ai/constants/app_list.dart';
import 'package:fitsnap_ai/helpers/di.dart';
import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import '../../../helpers/ui_helpers.dart';

class PlanIntroScreen extends StatelessWidget {
  final String userName;

  const PlanIntroScreen({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF5F5F5, // Light background for better contrast
      bottomNavigationBar: Container(
        width: 1.sw,
        height: 80.h,
        padding: EdgeInsets.symmetric(
          horizontal: UIHelper.kDefaulutPadding(),
          vertical: 12.h,
        ),
        child: CustomElevatedButton(
          onTap: () {
            NavigationService.navigateTo(Routes.signUpScreen);
          },
            buttonTitle: "Subscribe Now",
            // buttonStyle removed as it was invalid
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Welcome Header
                Text(
                  "Welcome to FitSnap AI",
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 32.sp,
                    color: AppColors.c0000ff,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    shadows: [
                      Shadow(
                        color: AppColors.c0000ff.withOpacity(0.08),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                UIHelper.verticalSpace(12.h),

                // Personalized Greeting
                Text(
                  "Hello, ${appData.read(kKeyNickName) ?? userName}!",
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 28.sp,
                    color: AppColors.c000000,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                UIHelper.verticalSpace(20.h),

                // Welcome Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    Assets.images.twoMenWomenHoldingWelcomeSign.path,
                    height: 280.h,
                    width: 0.9.sw,
                    fit: BoxFit.cover,
                  ),
                ),
                UIHelper.verticalSpace(24.h),

                // AI Insights Header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.c0000ff.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "Your Personalized AI Insights",
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 24.sp,
                      color: AppColors.c3B13CA,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(16.h),

                // AI Response Markdown
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.c0000ff.withOpacity(0.07),
                        blurRadius: 12.r,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: GptMarkdown(
                    appData.read(kKeygptResponse) ?? 'No AI response available.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 17.sp,
                      color: AppColors.c000000,
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(24.h),

                // Plan Suggestions Header
                Text(
                  "Recommended Plans for You",
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 22.sp,
                    color: AppColors.c000000,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                UIHelper.verticalSpace(16.h),

                // Plan Suggestions List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: AppList.planSuggestionList.length,
                  separatorBuilder: (context, index) => UIHelper.verticalSpace(12.h),
                  itemBuilder: (context, index) {
                    var data = AppList.planSuggestionList[index];
                    return Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.c0000ff.withOpacity(0.2)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.c0000ff,
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              data,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.sp,
                                color: AppColors.c000000,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                UIHelper.verticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}