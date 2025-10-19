import 'package:fitai/constants/validator.dart';
import 'package:fitai/helpers/loading_helper.dart';
import 'package:fitai/networks/api_acess.dart';
import 'package:fitai/provider/sign_up_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../common_widgets/custom_text_form_field.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<SignUpScreenProvider>(
        builder: (context, controller, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      AppColors.c0000ff.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 60.h),
                        _buildHeader(),
                        SizedBox(height: 50.h),
                        _buildNameField(controller),
                        SizedBox(height: 20.h),
                        _buildEmailField(controller),
                        SizedBox(height: 20.h),
                        _buildPasswordField(controller),
                        SizedBox(height: 32.h),
                        _buildSignUpButton(controller, context),
                        SizedBox(height: 24.h),
                        _buildSignInLink(),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.c0000ff,
                AppColors.c0000ff.withOpacity(0.7),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.c0000ff.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.fitness_center_rounded,
            size: 50.sp,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          "FitAI",
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.c0000ff,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Create Your Account",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "Start your fitness transformation today",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildNameField(SignUpScreenProvider controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CustomFormField(
        controller: controller.nameController,
        hintText: "Full Name",
        borderColor: Colors.grey[300]!,
        borderRadius: 16.r,
        prefixIcon: Icon(
          Icons.person_outline_rounded,
          color: AppColors.c0000ff,
          size: 22.sp,
        ),
        validator: (value) {
          if (controller.nameController.text.isEmpty) {
            return 'Please enter your full name';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailField(SignUpScreenProvider controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CustomFormField(
        controller: controller.eamilController,
        inputType: TextInputType.emailAddress,
        hintText: "Email Address",
        borderColor: Colors.grey[300]!,
        borderRadius: 16.r,
        prefixIcon: Icon(
          Icons.email_outlined,
          color: AppColors.c0000ff,
          size: 22.sp,
        ),
        validator: emailValidator,
      ),
    );
  }

  Widget _buildPasswordField(SignUpScreenProvider controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CustomFormField(
        controller: controller.passwordController,
        hintText: "Password",
        isPass: true,
        isObsecure: controller.passwordMode,
        borderColor: Colors.grey[300]!,
        borderRadius: 16.r,
        prefixIcon: Icon(
          Icons.lock_outline_rounded,
          color: AppColors.c0000ff,
          size: 22.sp,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            controller.setPasswordMode();
          },
          icon: Icon(
            controller.passwordMode
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: Colors.grey[600],
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'[^\S\r\n]')),
        ],
        onChanged: (value) {
          controller.passwordController.text =
              value.replaceAll(RegExp(r'\s+'), '');
        },
        validator: passwordValidator,
      ),
    );
  }

  Widget _buildSignUpButton(SignUpScreenProvider controller, BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [
            AppColors.c0000ff,
            AppColors.c0000ff.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.c0000ff.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          try {
            if (_formKey.currentState!.validate()) {
              bool isSuccess = await postSignUpRx
                  .signUp(
                    fullName: controller.nameController.text,
                    email: controller.eamilController.text.trim(),
                    password: controller.passwordController.text.toString(),
                  )
                  .waitingForFutureWithoutBg();

              if (isSuccess) {
                NavigationService.navigateTo(Routes.signinScreen);
                CustomToastMessage(
                  title: 'Success',
                  description: 'Sign up succeeded. Welcome to FitAI!',
                );
              } else {
                CustomToastMessage(
                  title: 'Error',
                  description: 'Sign up failed. Please try again.',
                );
              }
            }
          } catch (error) {
            CustomToastMessage(
              title: 'Error',
              description: 'Something went wrong. Please try again.',
            );
            print('Signup Error: ');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          "Create Account",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey[600],
          ),
        ),
        TextButton(
          onPressed: () {
            NavigationService.navigateTo(Routes.signinScreen);
          },
          child: Text(
            "Sign In",
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.c0000ff,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
