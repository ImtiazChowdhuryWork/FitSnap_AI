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
        constraints: BoxConstraints(
          minWidth: 80.w,
          maxWidth: 0.35.sw,
        ),
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.ceb4326,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete,
              color: AppColors.cFFFFFF,
              size: 16.sp,
            ),
            UIHelper.horizontalSpace(5.w),
            Flexible(
              child: Text(
                "Remove Image",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
                  color: AppColors.cFFFFFF,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
