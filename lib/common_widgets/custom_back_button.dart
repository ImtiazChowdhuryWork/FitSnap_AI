import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/navigation_service.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Color? iconColor;
  final AlignmentGeometry? alignment;
  const CustomBackButton({super.key, this.iconColor, this.alignment});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService.goBack();
      },
      child: Align(
        alignment: alignment ?? Alignment.centerLeft,
        child: Icon(
          Icons.arrow_back_ios,
          color: iconColor ?? AppColors.c000000,
        ),
      ),
    );
  }
}
