import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/ui_helpers.dart';

class RemoveImageButton extends StatelessWidget {
  final void Function()? onTap;
  const RemoveImageButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 0.3.sw,
        height: 40.h,
        padding: EdgeInsets.all(10.sp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.ceb4326,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.delete,
              color: AppColors.cFFFFFF,
            ),
            UIHelper.horizontalSpace(5.w),
            Text(
              "Remove Image",
              style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                color: AppColors.cFFFFFF,
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
