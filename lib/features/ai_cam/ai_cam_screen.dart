import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/features/ai_cam/widgets/ai_cam_option_button.dart';
import 'package:fitsnap_ai/features/ai_cam/widgets/remove_image_widget.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';
import 'package:fitsnap_ai/gen/colors.gen.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/ai_cam_impage_picker_provider.dart';

class AiCamScreen extends StatelessWidget {
  const AiCamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AiCamImagePickerProvider>(
        builder: (context, imagePickerController, child) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Captured Image from Camera or Selectd Image from Gallery
                  imagePickerController.selectedImage != null
                      ? Container(
                          width: 1.sw,
                          height: 0.3.sh,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                              image: FileImage(
                                  imagePickerController.selectedImage!),
                              fit: BoxFit.cover,
                            ),
                          ),

                          ///Button : Remove Image
                          child: imagePickerController.selectedImage != null
                              ? RemoveImageButton(
                                  onTap: () {
                                    imagePickerController.removeImage();
                                  },
                                )
                              : null,
                        )
                      : const SizedBox.shrink(),

                  imagePickerController.selectedImage != null
                      ? UIHelper.verticalSpace(10.h)
                      : SizedBox.shrink(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Option : Take a new photo
                      AiCamOptionButton(
                        onTap: () {
                          imagePickerController.pickImageFromCamera();
                        },
                        image: Assets.images.cameraIcon.path,
                        title: "Take a New Photo",
                      ),

                      ///Upload from Gallery
                      AiCamOptionButton(
                        onTap: () {
                          imagePickerController.pickImageFromGallery();
                        },
                        image: Assets.images.uploadFromGalleryIcon.path,
                        title: "Upload from Gallery",
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(20.h),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
