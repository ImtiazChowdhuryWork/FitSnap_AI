import 'package:fitsnap_ai/common_widgets/custom_container.dart';
import 'package:fitsnap_ai/common_widgets/custom_list_tile.dart';
import 'package:fitsnap_ai/common_widgets/not_found_widget.dart';
import 'package:fitsnap_ai/common_widgets/waiting_widget.dart';
import 'package:fitsnap_ai/constants/app_constants.dart';
import 'package:fitsnap_ai/features/profile/mdoel/view_profile_info_model.dart';
import 'package:fitsnap_ai/features/profile/presentation/widgets/delete_account_bottom_sheet.dart';
import 'package:fitsnap_ai/features/profile/presentation/widgets/sign_out_bottom_sheet.dart';
import 'package:fitsnap_ai/features/profile/presentation/widgets/user_image_name_widget.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/all_routes.dart';
import 'package:fitsnap_ai/helpers/di.dart';
import 'package:fitsnap_ai/helpers/navigation_service.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:fitsnap_ai/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getProfileInfoRx.fetchProInfoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: (getProfileInfoRx.getProfileInfoData),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const WaitingWidget();
              } else if (snapshot.hasData && snapshot.data != null) {
                ViewProfileInfoModel profileData =
                    ViewProfileInfoModel.fromJson(snapshot.data);

                Data? data = profileData.data;
                return Column(
                  children: [
                    ///Image
                    ///User Name
                    UserImageAndNameWidget(
                      userImage: data!.avatarUrl == null
                          ? appData.read(kKeyGenderType) == "Male"
                              ? Assets.images.genderMale.path
                              : Assets.images.genderFemale.path
                          : data.avatarUrl,
                      userName: data.fullName ?? "",
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
                            onTap: () {
                              NavigationService.navigateTo(
                                  Routes.updateProfileScreen);
                            },
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
                            onTap: () {
                              NavigationService.navigateTo(
                                  Routes.termsOfServicesScreen);
                            },
                            title: "Privacy Policy",
                            leadingIcon: Icons.privacy_tip_outlined,
                            trailingIcon: Icons.arrow_forward,
                          ),

                          ///View & Update profile details
                          CustomListTile(
                            onTap: () {
                              NavigationService.navigateTo(
                                  Routes.termsOfServicesScreen);
                            },
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
                );
              } else {
                return const NotFoundWidget();
              }
            },
          ),
        ),
      )),
    );
  }
}
