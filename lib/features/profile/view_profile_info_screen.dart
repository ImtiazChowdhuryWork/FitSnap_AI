import 'package:fitsnap_ai/common_widgets/custom_container.dart';
import 'package:fitsnap_ai/common_widgets/custom_list_tile.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';

class ViewProfileInfoScreen extends StatelessWidget {
  const ViewProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// User Image
                Container(
                  width: 1.sw,
                  padding: EdgeInsets.all(10.sp),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.c0000ff.withAlpha(150),
                    border: Border.all(
                      color: AppColors.c0000ff,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: CircleAvatar(
                    radius: 60.sp,
                    backgroundImage: AssetImage(
                      Assets.images.addPaymentMethodScreenImage.path,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(20.h),

                /// User Info Section
                CustomContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// User Name
                      CustomListTile(
                        isLeadingUsed: true,
                        leadingIcon: Icons.person,
                        title: "Name : Imtiaz Chowdhury",
                      ),
                      UIHelper.verticalSpace(10.h),

                      /// User Email
                      CustomListTile(
                        isLeadingUsed: true,
                        leadingIcon: Icons.email,
                        title: "Email : testmail@gmail.com",
                      ),
                      UIHelper.verticalSpace(10.h),

                      /// User Gender
                      CustomListTile(
                        isLeadingUsed: true,
                        leadingIcon: Icons.male,
                        title: "Gender : Male",
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(20.h),

                /// Account Type
                CustomContainer(
                  child: CustomListTile(
                    isLeadingUsed: true,
                    leadingIcon: Icons.verified_user,
                    title: "Account Type : 7 Days Trial",
                  ),
                ),
                UIHelper.verticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
