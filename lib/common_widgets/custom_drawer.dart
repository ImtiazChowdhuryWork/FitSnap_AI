import 'package:fitsnap_ai/common_widgets/custom_container.dart';
import 'package:fitsnap_ai/common_widgets/custom_list_tile.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';
import '../helpers/all_routes.dart';
import '../helpers/navigation_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Drawer Header (Profile Info)
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: AppColors.c0000ff.withAlpha(200),
              ),
              accountName: Text(
                "John Doe",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "john.doe@example.com",
                style: TextStyle(fontSize: 14.sp),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40.sp,
                  color: AppColors.c000000,
                ),
              ),
            ),
            UIHelper.verticalSpace(25.h),

            ///Profile
            ///Favourites
            ///Subscription & Billing
            ///Terms fo Services
            ///Privacy Policy
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  children: [
                    /// Drawer Menu Items
                    CustomContainer(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      child: CustomListTile(
                        onTap: () {
                          NavigationService.navigateTo(Routes.profileScreen);
                        },
                        title: "Profile",
                        leadingIcon: Icons.person,
                      ),
                    ),
                    UIHelper.verticalSpace(15.h),

                    ///Favourites

                    CustomContainer(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      child: CustomListTile(
                        onTap: () {
                          NavigationService.navigateTo(Routes.checkoutScreen);
                        },
                        title: "Favourites",
                        leadingIcon: Icons.favorite,
                      ),
                    ),
                    UIHelper.verticalSpace(15.h),

                    ///Subscriptions & Billing
                    CustomContainer(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      child: CustomListTile(
                        onTap: () {
                          NavigationService.navigateTo(Routes.checkoutScreen);
                        },
                        title: "Subscriptions & Billing",
                        leadingIcon: Icons.payment,
                      ),
                    ),
                    UIHelper.verticalSpace(15.h),

                    ///Terms of Services

                    CustomContainer(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      child: CustomListTile(
                        onTap: () {
                          NavigationService.navigateTo(Routes.checkoutScreen);
                        },
                        title: "Terms of Services",
                        leadingIcon: Icons.description,
                      ),
                    ),
                    UIHelper.verticalSpace(15.h),

                    ///Privacy Policy
                    CustomContainer(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      child: CustomListTile(
                        onTap: () {
                          NavigationService.navigateTo(Routes.checkoutScreen);
                        },
                        title: "Privacy Policy",
                        leadingIcon: Icons.privacy_tip,
                      ),
                    ),
                    UIHelper.verticalSpace(15.h),

                    Spacer(),

                    /// Button : Logout Button
                    CustomContainer(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      child: CustomListTile(
                        onTap: () {
                          NavigationService.navigateTo(Routes.checkoutScreen);
                        },
                        title: "Sign Out",
                        titleColor: AppColors.cdc2626,
                        isLeadingUsed: false,
                        trailingIcon: Icons.login_outlined,
                        trailingIconColor: AppColors.cdc2626,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            UIHelper.verticalSpace(15.h),
          ],
        ),
      ),
    );
  }
}
