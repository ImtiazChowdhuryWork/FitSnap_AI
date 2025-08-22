import 'package:fitsnap_ai/features/plan_intro/presentation/plan_intro_screen.dart';
import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'features/terms_condition/presentation/terms_conditions_accept_screen.dart';
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
  bool _isLoading = false;
  bool isFirstTime = false;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    //AutoAppUpdateUtil.instance.checkAppUpdate();
    await setInitValue();

    if (appData.read(kKeyIsLoggedIn)) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
      performPostLoginActions();
    } else {
      //  NotificationService().cancelAllNotifications();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {
      return appData.read(kKeyIsLoggedIn)
          ? const WelcomeScreen()
          : appData.read(kKeyfirstTime)
              
              ? const TermsConditionsAcceptScreen()
              : const WelcomeScreen();
              
    }
  }
}
