import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widgets/custom_elevated_button.dart';
import '../../helpers/all_routes.dart';
import '../../helpers/navigation_service.dart';

class CreateCustomizePlanScreen extends StatelessWidget {
  const CreateCustomizePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///AppBar
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            NavigationService.goBack();
          },
        ),
      ),

      ///Body
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.userChoiceImage.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 250.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),

              //
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Let’s begin with a few questions to create your customized plan",
                      textAlign: TextAlign.center,
                      style: TextFontStyle.headline25BoldcFFFFFFStyleInter
                          .copyWith(
                        fontSize: 30.sp,
                        color: AppColors.c000000,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    /// Button : Continue
                    CustomElevatedButton(
                      onTap: () {
                        NavigationService.navigateTo(Routes.onboardingScreen);
                      },
                      buttonTitle: "Continue",
                      borderRadius: 20.r,
                      buttonWidth: 0.7.sw,
                    ),
                    UIHelper.verticalSpace(20.h),

                    ///Already have an account section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "I already have an account ",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),

                        ///Button : Log in
                        InkWell(
                          onTap: () {
                            NavigationService.navigateTo(Routes.signinScreen);
                          },
                          child: Text(
                            "Sign in",
                            style: TextFontStyle.headline25BoldcFFFFFFStyleInter
                                .copyWith(
                              color: AppColors.c0000ff,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
