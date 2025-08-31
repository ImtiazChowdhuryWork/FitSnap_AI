import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/di.dart';
import '../../../../helpers/ui_helpers.dart';

class UserImageAndNameWidget extends StatelessWidget {
  final String? userImage; // Can be null
  final String userName;

  const UserImageAndNameWidget({
    super.key,
    required this.userImage,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Profile Image
          CircleAvatar(
            radius: 60.sp,
            backgroundImage: userImage != null && userImage!.isNotEmpty
                ? NetworkImage(userImage!) as ImageProvider
                : AssetImage(
                    appData.read(kKeyGenderType) == "Male"
                        ? Assets.images.genderMale.path
                        : Assets.images.genderFemale.path,
                  ),
            onBackgroundImageError: (_, __) {
              // Optional: handle error and fallback to asset
            },
          ),
          UIHelper.verticalSpace(10.h),

          /// User Name + Nickname
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: userName,
                  style: TextFontStyle.headline25BoldcFFFFFFStyleInter,
                ),
                TextSpan(
                  text: " nickname", // always present
                  style: TextFontStyle.textStyle10cFFFFD700DmSans400
                      .copyWith(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
