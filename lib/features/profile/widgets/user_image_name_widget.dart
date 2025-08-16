import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/ui_helpers.dart';

class UserImageAndNameWidget extends StatelessWidget {
  final String userImage;
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
          ///Profile Image
          CircleAvatar(
            radius: 60.sp,
            backgroundImage: AssetImage(
              userImage,
            ),
          ),
          UIHelper.verticalSpace(10.h),

          ///User Name
          Text(
            userName,
            style: TextFontStyle.headline25BoldcFFFFFFStyleInter,
          ),
        ],
      ),
    );
  }
}
