import 'dart:developer';

import 'package:fitsnap_ai/helpers/loading_helper.dart';
import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widgets/custom_elevated_button.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/di.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../../../networks/api_acess.dart';

class SignOutBottomSheet extends StatelessWidget {
  const SignOutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 0.35.sh,
      padding: EdgeInsets.only(
        top: 40.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        border: Border.all(
          width: 0.2.sp,
          color: AppColors.c0000ff,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          ///Text : Sign Out
          Text(
            "Sign Out",
            style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
              color: AppColors.c000000,
            ),
          ),
          UIHelper.verticalSpace(20.h),

          ///Text : Are you sure do you want to sign out?
          Text(
            "Are you sure do you want to sign out?",
            textAlign: TextAlign.center,
            style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
              fontSize: 20.sp,
              color: AppColors.c0000ff,
              fontWeight: FontWeight.w500,
            ),
          ),
          UIHelper.verticalSpace(40.h),

          ///Button : Cancel
          ///Button : Sign Out
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///Button : Cancel Button
              Expanded(
                child: CustomElevatedButton(
                  onTap: () {
                    NavigationService.goBack;
                  },
                  buttonTitle: "Cancel",
                  textStyle:
                      TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    color: AppColors.c000000,
                    fontSize: 20.sp,
                  ),
                  isButtonBorderUsed: true,
                  buttonBorderColor: AppColors.c000000,
                  buttonColor: AppColors.cFFFFFF,
                ),
              ),
              UIHelper.horizontalSpace(20.w),

              ///Button : Sign Out
              Expanded(
                child: CustomElevatedButton(
                  onTap: () async {
                    await postLogOutRX
                        .logOut()
                        .waitingForFutureWithoutBg()
                        .then((value) {
                      if (value) {
                        NavigationService.navigateToUntilReplacement(
                            Routes.signinScreen);
                        appData.write(kKeyfirstTime, false);
                        appData.write(kKeyIsLoggedIn, false);
                        log("User First Time after logingout : ${appData.read(kKeyfirstTime)}");
                        log("User Logged In after logingout: ${appData.read(kKeyIsLoggedIn)}");
                      } else {
                        // Show some error message
                        CustomToastMessage(
                            title: value ? "Success" : "Error",
                            description: "Logout failed. Please try again.");
                        log("Logout failed. Please try again.");
                        log("User First Time : ${appData.read(kKeyfirstTime)}");
                        log("User Logged In : ${appData.read(kKeyIsLoggedIn)}");
                      }
                    });
                    // NavigationService.navigateTo(Routes.checkoutScreen);
                  },
                  buttonTitle: "Sign Out",
                  textStyle:
                      TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
