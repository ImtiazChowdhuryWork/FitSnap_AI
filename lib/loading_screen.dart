// import 'package:fitsnap_ai/navigation_screen.dart';
// import 'package:flutter/material.dart';
// import 'constants/app_constants.dart';
// import 'features/terms_condition/presentation/terms_conditions_accept_screen.dart';
// import 'helpers/di.dart';
// import 'helpers/helper_methods.dart';
// import 'helpers/post_login.dart';
// import 'networks/dio/dio.dart';
// import 'welcome_screen.dart';

// final class Loading extends StatefulWidget {
//   const Loading({super.key});

//   @override
//   State<Loading> createState() => _LoadingState();
// }

// class _LoadingState extends State<Loading> {
//   bool _isLoading = true;
//   bool isFirstTime = true;

//   @override
//   void initState() {
//     loadInitialData();
//     super.initState();
//   }

//   loadInitialData() async {
//     //AutoAppUpdateUtil.instance.checkAppUpdate();
//     await setInitValue();

//     if (appData.read(kKeyIsLoggedIn)) {
//       String token = appData.read(kKeyAccessToken);
//       DioSingleton.instance.update(token);
//       performPostLoginActions();
//     } else {
//       //  NotificationService().cancelAllNotifications();
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const WelcomeScreen();
//     } else {
//       return appData.read(kKeyIsLoggedIn)
//           ? const NavigationScreen()
//           : appData.read(kKeyfirstTime)
//               ? const WelcomeScreen()
//               : const TermsConditionsAcceptScreen();
//     }
//   }
// }

import 'dart:async';
import 'dart:developer';


import 'package:fitsnap_ai/features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:fitsnap_ai/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fitsnap_ai/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'gen/assets.gen.dart';
import 'gen/colors.gen.dart';
import 'constants/app_constants.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/post_login.dart';
import 'networks/dio/dio.dart';


final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  bool isFirstTime = true;
  Timer? _timer;
  @override
  void initState() {
    loadInitialData();
    super.initState();
    _timer = Timer(const Duration(seconds: 35), () {
      if (_isLoading) {
        // Only log out if internet is connected but loading is taking too long
        _handleLogout();
      }
    });
  }

  loadInitialData() async {
    //AutoAppUpdateUtil.instance.checkAppUpdate();
    await setInitValue();
    // getDvlaDataRx.fetchDvlaData();

    if (appData.read(kKeyIsLoggedIn)) {
      String? token = appData.read(kKeyAccessToken);
      log('Token:============== $token==========');
      DioSingleton.instance.update(token ?? '');
      // await getProfileRx.fetchProfileData();
      performPostLoginActions();
    }
    setState(() {
      _timer!.cancel();
      _isLoading = false;
    });
  }

  void _handleLogout() {
    appData.write(kKeyIsLoggedIn, false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SigninScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Beautiful custom loading screen
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.c0000ff, AppColors.c3B13CA],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App logo or splash icon
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(32.w),
                child: Image.asset(
                  Assets.icons.splashIcon.path,
                  width: 100.w,
                  height: 100.w,
                ),
              ),
              SizedBox(height: 40.h),
              // Lottie animated loader
              SizedBox(
                width: 120.w,
                height: 120.w,
                child: Lottie.asset(
                  Assets.lottie.loadingSpinner,
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
              SizedBox(height: 32.h),
              // App name
              Text(
                "FitSnap AI",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 16.h),
              // Loading message
              Text(
                "Loading your experience...",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white.withOpacity(0.85),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      if (appData.read(kKeyIsLoggedIn)) {
        // Check if first name is null or empty
        if (appData.read(kKeyIsLoggedIn) == true) {
          return const NavigationScreen();
        } else {
          return SigninScreen();
        }
      } else {
        return appData.read(kKeyfirstTime)
            ? OnboardingScreen()
            : SigninScreen();
      }
    }
  }
}
