import 'package:fitai/features/well_done/subscription_billing/widgets/show_date.dart';
import 'package:fitai/features/well_done/subscription_billing/widgets/subcription_package_type.dart';
import 'package:fitai/features/well_done/subscription_billing/widgets/upgrade_plan_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/text_font_style.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';

class SubscriptionBillingScreen extends StatelessWidget {
  const SubscriptionBillingScreen({super.key});

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
                /// Text : Subscription & Billing
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

                /// Subscription Card
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
                      /// Upgrade Plan Button
                      UpgradePlanButton(
                        onTap: () {
                          NavigationService.navigateTo(Routes.checkoutScreen);
                        },
                        title: "Upgrade Plan",
                      ),
                      UIHelper.verticalSpace(10.h),

                      /// Subscription Details
                      SubcriptionPackageType(
                        subscriptionPackageType: "Pro Plan",
                        subscriptonPackagePrice: 500,
                        subscriptionPackageLength: "month",
                      ),
                      UIHelper.verticalSpace(20.h),

                      /// Start & End Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShowDate(
                            title: "Start Date :",
                            date: "5/22/2025",
                          ),
                          ShowDate(
                            title: "End Date :",
                            date: "6/22/2025",
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
