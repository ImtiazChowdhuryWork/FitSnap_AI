import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class CustomListTile extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLeadingUsed;
  final String title;
  final Color? leadingIconColor;
  final Color? trailingIconColor;
  final Color? titleColor;
  final double? titleSize;
  final void Function()? onTap;

  const CustomListTile({
    super.key,
    this.leadingIcon,
    this.trailingIcon,
    required this.title,
    this.onTap,
    this.leadingIconColor,
    this.trailingIconColor,
    this.titleColor,
    this.titleSize,
    this.isLeadingUsed = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: isLeadingUsed && leadingIcon != null
          ? Icon(
              leadingIcon,
              color: leadingIconColor ?? AppColors.c0000ff,
            )
          : null,
      trailing: trailingIcon != null
          ? Icon(
              trailingIcon,
              color: trailingIconColor ?? AppColors.c0000ff,
            )
          : null,
      title: Text(
        title,
        style: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
          color: titleColor ?? AppColors.c000000,
          fontSize: titleSize ?? 16.sp,
        ),
      ),
    );
  }
}
