import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../gen/colors.gen.dart';
import '../provider/custom_radius_button_controller.dart';

class CustomRadiusButtonWidget extends StatelessWidget {
  final int index;

  const CustomRadiusButtonWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomRadiusButtonController>(
      builder: (context, controller, child) {
        final isSelected = controller.isSelected(index);

        return InkWell(
          onTap: () {
            controller.selectIndex(index);
          },
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.c0000ff : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.c000000 : AppColors.c0000ff,
                width: 3.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
