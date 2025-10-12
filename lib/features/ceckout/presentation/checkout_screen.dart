import 'package:fitai/constants/app_list.dart';
import 'package:fitai/features/ceckout/widgets/subscriptionTypeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitai/constants/text_font_style.dart';
import 'package:fitai/gen/assets.gen.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/ui_helpers.dart';

import '../../../common_widgets/custom_elevated_button.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              UIHelper.kDefaulutPadding(),
            ),
            child: Column(
              children: [
                /// Design Your Trial Section
                Container(
                  height: 0.4.sh,
                  width: 1.sw,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      opacity: 0.4.sp,
                      image: AssetImage(
                        Assets.images.checkoutBoyImage.path,
                      ),
                    ),
                  ),
                  child: Text(
                    "Select Your Trial",
                    textAlign: TextAlign.center,
                    style:
                        TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                      color: AppColors.c0000ff,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),

                /// Subscription Type List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: AppList.subscriptionTypeList.length,
                  itemBuilder: (context, index) {
                    var data = AppList.subscriptionTypeList[index];
                    return Subscriptiontypewidget(
                      index: index,
                      subscriptionType: data.type,
                      subscriptionPrice: data.price,
                    );
                  },
                ),
                UIHelper.verticalSpace(50.h),

                ///Button : Continue
                CustomElevatedButton(
                  onTap: () {
                    NavigationService.navigateTo(Routes.addPaymentMethodScreen);
                  },
                  buttonTitle: "Checkout",
                  borderRadius: 20.r,
                  isButtonBorderUsed: true,
                  buttonBorderColor: AppColors.c0000ff,
                ),
                UIHelper.verticalSpace(20.h),

                ///Text : Payment Description
                Text(
                  "1st month BDT500.0, then BDT5400.0/yr(BDT4500//mo)",
                  textAlign: TextAlign.start,
                  style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                    color: AppColors.c000000,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UIHelper.verticalSpace(5.h),

                ///Text : Payment Description
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Payment will be charged to your Google Play account at the end of "
                            "your trial or confirmation of purchase if you are not starting a trial."
                            "Subscription automatically renews unless it is canceled at least 24 "
                            "hours before the end of your trial or current period.Your account will"
                            "be charged for renewal within 24hours prior to the end of the current"
                            "period.You can managee and cancel your subscriptions in seettings in "
                            "the Google Play store.For more informatio, please see our ",
                        style: TextFontStyle.headline25BoldcFFFFFFStyleInter
                            .copyWith(
                          color: AppColors.c000000,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: "Terms of Use and Privacy Policy.",
                        style: TextFontStyle.headline25BoldcFFFFFFStyleInter
                            .copyWith(
                          color: AppColors.c0000ff,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
