import 'package:fitai/common_widgets/custom_elevated_button.dart';
import 'package:fitai/helpers/all_routes.dart';
import 'package:fitai/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/ui_helpers.dart';

class TermsConditionsAcceptScreen extends StatelessWidget {
  const TermsConditionsAcceptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 31.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///Emptyp Space
            SizedBox.shrink(),

            /// Logo Container
            Container(
              padding: EdgeInsets.all(20.0),
              height: 160.h,
              width: 160.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.r),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF0B61D4),
                      Color(0xFF3296E8),
                      Color(0xFF3B3BF9),
                    ],
                  )),
              child: Text(
                'FitSnap AI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            /// Text : Terms of Use
            /// Button : Continue
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Text : Terms of Use
                Text(
                  "By tapping Continue, you agree to our Terms of Use"
                  "and confirm you have read our Privacy Policy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),

                /// Button : Continue
                CustomElevatedButton(
                  onTap: () {
                    NavigationService.navigateTo(
                        Routes.createCustomizePlanScreen);
                  },
                  buttonTitle: "Continue",
                  borderRadius: 64.r,
                ),

                UIHelper.verticalSpace(122.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
