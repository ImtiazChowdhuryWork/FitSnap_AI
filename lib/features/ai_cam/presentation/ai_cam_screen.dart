import 'package:fitsnap_ai/common_widgets/cam_option_button.dart';
import 'package:fitsnap_ai/common_widgets/custom_elevated_button.dart';
import 'package:fitsnap_ai/features/ai_cam/widgets/remove_image_widget.dart';
import 'package:fitsnap_ai/gen/assets.gen.dart';
import 'package:fitsnap_ai/helpers/loading_helper.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:fitsnap_ai/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/custom_drawer.dart';
import '../../../gen/colors.gen.dart';
import '../../../provider/ai_cam_impage_picker_provider.dart';

class AiCamScreen extends StatelessWidget {
  const AiCamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AiCamImagePickerProvider>(
        builder: (context, imagePickerController, child) {
      return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          backgroundColor: AppColors.c0000ff,
          title: Text("Workouts Plan Screen"),
        ),
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

                  UIHelper.verticalSpace(20.h),

                  ///Section : Take a new photo -> Camera
                  ///Section : Upload from Gallery
                  imagePickerController.selectedImage != null
                      ? CustomElevatedButton(
                          buttonTitle: "Submit Image",
                          onTap: () async {
                            if (imagePickerController.selectedImage != null) {
                              try {
                                // Upload the image with loading helper
                                bool isSuccess = await aiCamUploadImageRx
                                    .uploadImage(
                                        imageFile: imagePickerController
                                            .selectedImage!)
                                    .waitingForFutureWithoutBg();

                                if (isSuccess) {
                                  // Handle success - maybe navigate to results screen or show success message
                                  print("Image uploaded successfully!");

                                  // Get the upload result if needed
                                  Map<String, dynamic> result =
                                      aiCamUploadImageRx.getUploadResult();
                                  print("Upload result: $result");

                                  // Optional: Clear the image after successful upload
                                  // imagePickerController.removeImage();
                                } else {
                                  print("Image upload failed");
                                }
                              } catch (e) {
                                print("Error uploading image: $e");
                              }
                            }
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ///Option : Take a new photo from Camera
                            Expanded(
                              child: CamOptionButton(
                                onTap: () {
                                  imagePickerController.pickImageFromCamera();
                                },
                                image: Assets.images.cameraIcon.path,
                                title: "Take a New Photo",
                              ),
                            ),

                            UIHelper.horizontalSpace(10.w),

                            ///Option : Upload from Gallery
                            Expanded(
                              child: CamOptionButton(
                                onTap: () {
                                  imagePickerController.pickImageFromGallery();
                                },
                                image: Assets.images.uploadFromGalleryIcon.path,
                                title: "Upload from Gallery",
                              ),
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
