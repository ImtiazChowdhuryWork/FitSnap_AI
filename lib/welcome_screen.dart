import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants/text_font_style.dart';
import 'gen/colors.gen.dart';

final class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        color: AppColors.c0000ff,
        alignment: Alignment.center,
        child: Text(
          "FitSnap AI",
          style: TextFontStyle.textStyle28cffffffRobotoBold,
        ),
      ),
    );
  }
}
