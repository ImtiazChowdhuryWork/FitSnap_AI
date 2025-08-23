import 'package:fitsnap_ai/common_widgets/custom_elevated_button.dart';
import 'package:fitsnap_ai/constants/app_list.dart';
import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/all_routes.dart';
import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      ///Button : Subscribe Button
      bottomNavigationBar: Container(
        width: 1.sw,
        height: 100.h,
        color: Colors.transparent,
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        child: CustomElevatedButton(
          onTap: () {
            NavigationService.navigateTo(Routes.signUpScreen);
          },
          buttonTitle: "Subscribe",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Wellcome User Name
                Text(
                  "Welcome ${userName.isNotEmpty ? userName : 'User'}",
                  style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    fontSize: 36.sp,
                    color: AppColors.c0000ff,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpace(10.h),

                ///Image : Welcom Sign
                Image.asset(
                  height: 330.h,
                  width: 1.sw,
                  fit: BoxFit.cover,
                  Assets.images.twoMenWomenHoldingWelcomeSign.path,
                ),
                UIHelper.verticalSpace(5.h),

                ///Text : Hellow, User Name
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Hello ${userName.isNotEmpty ? userName : 'User'}",
                    textAlign: TextAlign.center,
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      fontSize: 30.sp,
                      color: AppColors.c0000ff,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),

                ///Text : What can be understood from the information you provided
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "What can be understood from the information you provided:",
                    textAlign: TextAlign.center,
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      fontSize: 25.sp,
                      color: AppColors.c000000,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(40.h),

                ///AI Generated Plan Suggestions
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: AppList.planSuggestionList.length,
                  separatorBuilder: (context, index) =>
                      UIHelper.verticalSpace(20.h),
                  itemBuilder: (context, index) {
                    var data = AppList.planSuggestionList[index];
                    return Text(
                      data,
                      style: TextFontStyle.headline25BoldcFFFFFFStyleInter
                          .copyWith(
                        fontSize: 20.sp,
                        color: AppColors.c000000,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
