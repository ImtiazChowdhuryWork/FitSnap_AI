import 'dart:developer';

import 'package:fitsnap_ai/common_widgets/custom_container.dart';
import 'package:fitsnap_ai/common_widgets/custom_list_tile.dart';
import 'package:fitsnap_ai/common_widgets/waiting_widget.dart';
import 'package:fitsnap_ai/constants/app_constants.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/di.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:fitsnap_ai/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common_widgets/not_found_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../mdoel/view_profile_info_model.dart';

class ViewProfileInfoScreen extends StatefulWidget {
  const ViewProfileInfoScreen({super.key});

  @override
  State<ViewProfileInfoScreen> createState() => _ViewProfileInfoScreenState();
}

class _ViewProfileInfoScreenState extends State<ViewProfileInfoScreen> {
  @override
  void initState() {
    getProfileInfoRx.fetchProInfoData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
            child: StreamBuilder(
                stream: (getProfileInfoRx.getProfileInfoData),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    log("Waitingzonnn----------------------------nnnnnn");
                    return const WaitingWidget();
                  } else if (snapshot.hasData && snapshot.data != null) {
                    log("data availableeeeeeeeeeeeeeeee------------------------------");
                    log("Gender :__________${appData.read(kKeyGenderType)}");
                    ViewProfileInfoModel profile =
                        ViewProfileInfoModel.fromJson(snapshot.data);

                    Data? data = profile.data;
                    log("Full Name_____________ : ${data!.fullName}");
                    log("Full Name_____________ : ${data.user!.email}");

                    return Column(
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
                              appData.read(kKeyGenderType) == "Male"
                                  ? Assets.images.genderMale.path
                                  : Assets.images.genderFemale.path,
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
                                title: data.fullName ?? "",
                              ),
                              UIHelper.verticalSpace(10.h),

                              /// User Email
                              CustomListTile(
                                isLeadingUsed: true,
                                leadingIcon: Icons.email,
                                title: data.user!.email ?? "",
                              ),
                              UIHelper.verticalSpace(10.h),

                              /// User Gender
                              CustomListTile(
                                isLeadingUsed: true,
                                leadingIcon: Icons.male,
                                title:
                                    "Gender : ${appData.read(kKeyGenderType)}",
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
                    );
                  } else {
                    return const NotFoundWidget();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
