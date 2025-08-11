import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.activeTrackColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: Theme(
        data: ThemeData(
          useMaterial3: true,
          switchTheme: SwitchThemeData(
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        child: Switch(
          value: value,
          activeColor: activeColor ?? AppColors.cFFFFFF,
          activeTrackColor: activeTrackColor ?? AppColors.c026cb7,
          inactiveThumbColor: thumbColor ?? AppColors.cFFFFFF,
          inactiveTrackColor: inactiveColor ?? AppColors.c6b7280,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
