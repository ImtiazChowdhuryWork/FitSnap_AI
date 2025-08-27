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
import 'constants/app_constants.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/post_login.dart';
import 'networks/dio/dio.dart';
import 'welcome_screen.dart';

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
      DioSingleton.instance.update(token!);
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
      return const WelcomeScreen();
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
