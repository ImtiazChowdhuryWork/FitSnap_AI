// file: widgets/custom_pin_input.dart
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../../constants/text_font_style.dart';

class CustomPinInput extends StatelessWidget {
  final void Function(String pin)? onCompleted;
  final String correctPin;

  const CustomPinInput({
    super.key,
    this.onCompleted,
    this.correctPin = '2222',
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 94.w,
      height: 94.h,
      textStyle: TextFontStyle.headline25BoldcFFFFFFStyleInter.copyWith(
        color: Color.fromRGBO(30, 60, 87, 1),
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.c000000),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: (val) {
        return val == correctPin ? null : 'Pin is incorrect';
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: onCompleted,
    );
  }
}
