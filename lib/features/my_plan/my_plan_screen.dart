import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/features/my_plan/widgets/show_date.dart';
import 'package:fitsnap_ai/features/my_plan/widgets/subcription_package_type.dart';
import 'package:fitsnap_ai/features/my_plan/widgets/upgrade_plan_button.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/all_routes.dart';
import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPlanScreen extends StatelessWidget {
  const MyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///Text : Subscription & Billing
                Text(
                  "Subscription & Billing",
                  textAlign: TextAlign.center,
                  style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    color: AppColors.c000000,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpace(60.h),

                ///Button : Upgrade Plan Button
                ///Text : Subscription Type
                ///Text : Subscription Price
                ///Text : Subscription Length
                ///Start Date
                ///End Date
                Container(
                  width: 1.sw,
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.c000000,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Button : Upgrade Plan Button
                      UpgradePlanButton(
                        onTap: () {
                          NavigationService.navigateTo(Routes.checkoutScreen);
                        },
                        title: "Upgrade Plan",
                      ),
                      UIHelper.verticalSpace(10.h),

                      ///Text : Subscription Type
                      ///Text : Subscription Price
                      ///Text : Subscription Length
                      SubcriptionPackageType(
                        subscriptionPackageType: "Pro Plan",
                        subscriptonPackagePrice: 500,
                        subscriptionPackageLength: "month",
                      ),
                      UIHelper.verticalSpace(20.h),

                      ///Start Date
                      ///End Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Start Date
                          ShowDate(
                            title: "Start Date :",
                            date: "5/22/2025",
                          ),

                          ///End Date
                          ShowDate(
                            title: "Start Date :",
                            date: "5/22/2025",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
