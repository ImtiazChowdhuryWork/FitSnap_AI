import 'dart:developer';

import 'package:fitai/common_widgets/custom_text_form_field.dart';
import 'package:fitai/gen/colors.gen.dart';
import 'package:fitai/helpers/all_routes.dart';
import 'package:fitai/helpers/loading_helper.dart';
import 'package:fitai/helpers/navigation_service.dart';
import 'package:fitai/provider/sign_in_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common_widgets/custom_toast.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import '../../../../networks/api_acess.dart';
import '../../../../networks/dio/dio.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    DioSingleton.instance.updateForAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInScreenController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
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
                        _buildEmailField(controller),
                        SizedBox(height: 20.h),
                        _buildPasswordField(controller),
                        SizedBox(height: 16.h),
                        _buildForgotPassword(),
                        SizedBox(height: 32.h),
                        _buildSignInButton(controller, context),
                        SizedBox(height: 24.h),
                        _buildSignUpLink(),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
          "Welcome Back!",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "Sign in to continue your fitness journey",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(SignInScreenController controller) {
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
        controller: controller.emailController,
        inputType: TextInputType.emailAddress,
        hintText: "Email Address",
        borderColor: Colors.grey[300]!,
        borderRadius: 16.r,
        prefixIcon: Icon(
          Icons.email_outlined,
          color: AppColors.c0000ff,
          size: 22.sp,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your email";
          }
          if (!value.contains('@')) {
            return "Please enter a valid email";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(SignInScreenController controller) {
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
        isObsecure: !controller.isPasswordVisible,
        borderColor: Colors.grey[300]!,
        borderRadius: 16.r,
        prefixIcon: Icon(
          Icons.lock_outline_rounded,
          color: AppColors.c0000ff,
          size: 22.sp,
        ),
        suffixIcon: IconButton(
          onPressed: () => controller.togglePasswordVisibility(),
          icon: Icon(
            controller.isPasswordVisible
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
            color: Colors.grey[600],
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your password";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          NavigationService.navigateTo(Routes.sendVerificationScreen);
        },
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.c0000ff,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(
      SignInScreenController controller, BuildContext context) {
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
          if (_formKey.currentState!.validate()) {
            appData.write(
              kEmail,
              controller.emailController.text.trim(),
            );

            bool isLogedin = await postLoginRxObj
                .postLogin(
                  email: controller.emailController.text,
                  password: controller.passwordController.text,
                )
                .waitingForFutureWithoutBg();

            if (isLogedin) {
              log("Checking email ===== 1 ${controller.emailController.text}");
              controller.emailController.clear();
              controller.passwordController.text = '';
              NavigationService.navigateToUntilReplacement(
                Routes.navBarScreen,
              );
              CustomToastMessage(
                title: 'Success',
                description: 'Sign in succeeded. Welcome to FitAI!',
              );
              log("Checking email ===== 2 ${controller.emailController.text}");
            } else {
              CustomToastMessage(
                title: 'Error',
                description: postLoginRxObj.message,
              );
            }
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
          "Sign In",
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

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey[600],
          ),
        ),
        TextButton(
          onPressed: () {
            NavigationService.navigateTo(Routes.signUpScreen);
          },
          child: Text(
            "Sign Up",
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
