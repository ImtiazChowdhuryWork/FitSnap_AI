import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widgets/cam_option_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';

class PickProfileImageBottomSheet extends StatelessWidget {
  final void Function()? onTapCamera;
  final void Function()? onTapGallery;
  const PickProfileImageBottomSheet({
    super.key,
    this.onTapCamera,
    this.onTapGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 0.3.sh,
      padding: EdgeInsets.only(
        top: 40.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        border: Border.all(
          width: 0.2.sp,
          color: AppColors.c0000ff,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///Option : Take a new photo from Camera
          CamOptionButton(
            onTap: onTapCamera,
            image: Assets.images.cameraIcon.path,
            imageHeight: 40.h,
            imageWidth: 40.w,
            title: "Take a New Photo",
          ),

          ///Option : Upload from Gallery
          CamOptionButton(
            onTap: onTapGallery,
            image: Assets.images.uploadFromGalleryIcon.path,
            imageHeight: 40.h,
            imageWidth: 40.w,
            title: "Upload from Gallery",
          ),
        ],
      ),
    );
  }
}
