import 'package:fitsnap_ai/common_widgets/custom_elevated_button.dart';
import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/common_widgets/custom_container.dart';
import 'package:fitsnap_ai/common_widgets/custom_list_tile.dart';
import 'package:fitsnap_ai/features/profile/widgets/delete_account_bottom_sheet.dart';
import 'package:fitsnap_ai/features/profile/widgets/sign_out_bottom_sheet.dart';
import 'package:fitsnap_ai/features/profile/widgets/user_image_name_widget.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/all_routes.dart';
import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///Image
              ///User Name
              UserImageAndNameWidget(
                userImage: Assets.images.addPaymentMethodScreenImage.path,
                userName: "Imtiaz Chowdhury",
              ),
              UIHelper.verticalSpace(20.h),

              ///Section : Profile info
              ///Section : View & Update profile info
              CustomContainer(
                child: Column(
                  children: [
                    ///View only profile details
                    CustomListTile(
                      onTap: () {
                        NavigationService.navigateTo(
                            Routes.viewProfileInfoScreen);
                      },
                      title: "View Profile Info",
                      leadingIcon: Icons.account_circle_outlined,
                      trailingIcon: Icons.arrow_forward,
                    ),

                    ///View & Update profile details
                    CustomListTile(
                      onTap: () {},
                      title: "Update Profile Info",
                      leadingIcon: Icons.edit,
                      trailingIcon: Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(20.h),

              ///Section : Terms of Services
              ///Section : Privacy Policy
              CustomContainer(
                child: Column(
                  children: [
                    ///View only profile details
                    CustomListTile(
                      onTap: () {},
                      title: "Privacy Policy",
                      leadingIcon: Icons.privacy_tip_outlined,
                      trailingIcon: Icons.arrow_forward,
                    ),

                    ///View & Update profile details
                    CustomListTile(
                      onTap: () {},
                      title: "Terms of Services",
                      leadingIcon: Icons.description_outlined,
                      trailingIcon: Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(20.h),

              ///Section : Delete Account
              CustomContainer(
                child: CustomListTile(
                  onTap: () {
                    Get.bottomSheet(
                      backgroundColor: AppColors.c0000ff.withAlpha(20),
                      DeleteAccountBottomSheet(),
                    );
                  },
                  title: "Delete Account",
                  titleColor: AppColors.cdc2626,
                  trailingIcon: Icons.delete_forever,
                  trailingIconColor: AppColors.cdc2626,
                ),
              ),
              UIHelper.verticalSpace(20.h),

              ///Section : Delete Account
              CustomContainer(
                child: CustomListTile(
                  onTap: () {
                    Get.bottomSheet(
                      backgroundColor: AppColors.c0000ff.withAlpha(20),
                      SignOutBottomSheet(),
                    );
                  },
                  title: "Sign Out",
                  isLeadingUsed: false,
                  leadingIcon: Icons.login_outlined,
                  trailingIcon: Icons.login_outlined,
                  trailingIconColor: AppColors.cdc2626,
                ),
              ),
              UIHelper.verticalSpace(20.h),
            ],
          ),
        ),
      )),
    );
  }
}
