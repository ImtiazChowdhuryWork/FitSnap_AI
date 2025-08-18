import 'package:fitsnap_ai/common_widgets/custom_back_button.dart';
import 'package:fitsnap_ai/common_widgets/custom_text_form_field.dart';
import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widgets/custom_elevated_button.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';

class ResetPaswordScreen extends StatelessWidget {
  const ResetPaswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Button : Back Button
                CustomBackButton(),
                UIHelper.verticalSpace(20.h),

                ///Text : Enter New Password
                Text(
                  "Enter New Password",
                  style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    fontSize: 32.sp,
                    color: AppColors.c000000,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                UIHelper.verticalSpace(40.h),

                ///New Password Field
                CustomFormField(
                  hintText: "New Pasword",
                  borderColor: AppColors.c000000,
                  suffixIcon: Icon(Icons.visibility),
                ),
                UIHelper.verticalSpace(20.h),

                ///Confirm Password Field
                CustomFormField(
                  hintText: "Confirm Pasword",
                  borderColor: AppColors.c000000,
                  suffixIcon: Icon(Icons.visibility),
                ),
                UIHelper.verticalSpace(70.h),

                ///Button : Next
                CustomElevatedButton(
                  onTap: () {
                    NavigationService.navigateTo(
                        Routes.registrationSuccessfulScreen);
                  },
                  buttonTitle: "Sign in",
                  borderRadius: 250.r,
                  isButtonBorderUsed: true,
                  buttonBorderColor: AppColors.c000000,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
