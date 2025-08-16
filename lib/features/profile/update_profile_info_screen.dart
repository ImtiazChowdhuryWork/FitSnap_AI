import 'package:fitsnap_ai/common_widgets/custom_container.dart';
import 'package:fitsnap_ai/common_widgets/custom_elevated_button.dart';
import 'package:fitsnap_ai/common_widgets/custom_text_form_field.dart';
import 'package:fitsnap_ai/constants/text_font_style.dart';
import 'package:fitsnap_ai/helpers/ui_helpers.dart';
import 'package:fitsnap_ai/provider/update_profile_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';

class UpdateProfileInfoScreen extends StatelessWidget {
  const UpdateProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UpdateProfileInfoProvider>(
            builder: (context, controller, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
              child: Column(
                children: [
                  /// User Image
                  Stack(
                    children: [
                      Container(
                        width: 1.sw,
                        padding: EdgeInsets.all(10.sp),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.c0000ff.withAlpha(150),
                          border: Border.all(
                            color: AppColors.c0000ff,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: CircleAvatar(
                          radius: 60.sp,
                          backgroundImage: AssetImage(
                            Assets.images.addPaymentMethodScreenImage.path,
                          ),
                        ),
                      ),

                      ///Edit Icon : Pen
                      Positioned(
                        right: 0.3.sw,
                        bottom: 0.020.sh,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(5.sp),
                            decoration: BoxDecoration(
                              color: AppColors.c000000,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: AppColors.cFFFFFF,
                            ),
                          ),
                        ),
                      ),

                      ///Button : Edit
                      Positioned(
                        right: 0.010.sw,
                        top: 0.0060.sh,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.sp,
                              vertical: 8.sp,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.c0000ff,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              "Edit",
                              style: TextFontStyle
                                  .headline25BoldcFFFFFFStyleInter
                                  .copyWith(
                                color: AppColors.cFFFFFF,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(20.h),

                  ///Textformfield : First Name
                  CustomContainer(
                    padding: EdgeInsets.zero,
                    borderColor: Colors.transparent,
                    child: CustomFormField(
                      isEnabled: false,
                      controller: controller.firstNameController,
                      labelText: "First Name",
                      labelStyle: TextFontStyle.headline25BoldcFFFFFFStyleInter
                          .copyWith(
                        color: AppColors.c0000ff,
                        fontSize: 15.sp,
                      ),
                      hintText: "First name",
                    ),
                  ),
                  UIHelper.verticalSpace(20.h),

                  ///Textformfield : Last Name
                  CustomContainer(
                    padding: EdgeInsets.zero,
                    borderColor: Colors.transparent,
                    child: CustomFormField(
                      controller: controller.lastNameController,
                      labelText: "Last Name",
                      labelStyle: TextFontStyle.headline25BoldcFFFFFFStyleInter
                          .copyWith(
                        color: AppColors.c0000ff,
                        fontSize: 15.sp,
                      ),
                      hintText: "Last name",
                    ),
                  ),
                  UIHelper.verticalSpace(40.h),

                  CustomElevatedButton(
                    onTap: () {},
                    buttonTitle: "Update",
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
