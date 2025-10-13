import 'dart:async';
import 'dart:developer';

import 'package:fitai/features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:fitai/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fitai/navigation_screen.dart';
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
  bool _minimumTimePassed = false;
  bool _dataLoaded = false;
  Timer? _timeoutTimer;
  Timer? _minimumTimer;

  @override
  void initState() {
    super.initState();
    _startMinimumTimer();
    loadInitialData();
    _startLoadingTimeout();
  }

  void _startMinimumTimer() {
    _minimumTimer = Timer(const Duration(seconds: 2), () {
      _minimumTimePassed = true;
      _checkIfReadyToProceed();
    });
  }

  void _startLoadingTimeout() {
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(const Duration(seconds: 30), () async {
      try {
        if (!mounted) return;
        if (_isLoading) {
          final retry = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: const Text('Loading taking too long'),
              content: const Text(
                  'There was a problem loading your data. You can retry or go to sign-in.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: const Text('Retry'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('Sign in'),
                ),
              ],
            ),
          );

          if (retry == true) {
            if (!mounted) return;
            setState(() {
              _isLoading = true;
              _minimumTimePassed = false;
              _dataLoaded = false;
            });
            // restart timeout and try loading again
            _startMinimumTimer();
            _startLoadingTimeout();
            await loadInitialData();
          } else if (retry == false) {
            _handleLogout();
          }
        }
      } catch (e, st) {
        log('Loading timeout dialog error: $e\n$st');
      }
    });
  }

  loadInitialData() async {
    await setInitValue();

    if (appData.read(kKeyIsLoggedIn)) {
      String? token = appData.read(kKeyAccessToken);
      log('Token:============== $token==========');
      DioSingleton.instance.update(token ?? '');
      performPostLoginActions();
    }

    _dataLoaded = true;
    _checkIfReadyToProceed();
  }

  void _checkIfReadyToProceed() {
    if (_minimumTimePassed && _dataLoaded) {
      if (mounted) {
        setState(() {
          _timeoutTimer?.cancel();
          _minimumTimer?.cancel();
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    _minimumTimer?.cancel();
    super.dispose();
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
                "FitAI",
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