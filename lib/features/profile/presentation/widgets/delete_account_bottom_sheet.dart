import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widgets/custom_elevated_button.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key});

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
          ///Text : Delete Account
          Text(
            "Delete Account",
            style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
              color: AppColors.c000000,
            ),
          ),
          UIHelper.verticalSpace(20.h),

          ///Text : Are you sure do you want to Delete your account?
          Text(
            "Are you sure do you want to Delete your account?",
            textAlign: TextAlign.center,
            style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
              fontSize: 20.sp,
              color: AppColors.c0000ff,
              fontWeight: FontWeight.w500,
            ),
          ),
          UIHelper.verticalSpace(40.h),

          ///Button : Cancel
          ///Button : Delete
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

              ///Button : Delete
              Expanded(
                child: CustomElevatedButton(
                  onTap: () {},
                  buttonTitle: "Delete",
                  textStyle:
                      TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    fontSize: 20.sp,
                  ),
                  buttonColor: AppColors.cdc2626,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
