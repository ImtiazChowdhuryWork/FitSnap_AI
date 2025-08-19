import 'dart:io';

import 'package:fitsnap_ai/features/add_payment_method/add_payment_method_screen.dart';
import 'package:fitsnap_ai/features/ceckout/checkout_screen.dart';
import 'package:fitsnap_ai/features/create_customize_plan/create_customize_plan_screen.dart';
import 'package:fitsnap_ai/features/first_day/first_day_screen.dart';
import 'package:fitsnap_ai/features/my_plan/my_plan_screen.dart';
import 'package:fitsnap_ai/features/profile/profile_screen.dart';
import 'package:fitsnap_ai/features/profile/view_profile_info_screen.dart';
import 'package:fitsnap_ai/features/registration_successful/registration_successful_screen.dart';
import 'package:fitsnap_ai/features/reset_password/reset_pasword_screen.dart';
import 'package:fitsnap_ai/features/send_verification_code/send_verificatin_code_screen.dart';
import 'package:fitsnap_ai/features/sign_in/sign_in_screen.dart';
import 'package:fitsnap_ai/features/sign_up/sign_up_screen.dart';
import 'package:fitsnap_ai/features/subscription_billing/subscription_billing_screen.dart';
import 'package:fitsnap_ai/features/verify_code/verify_code_screen.dart';
import 'package:fitsnap_ai/features/well_done/well_done_screen.dart';
import 'package:fitsnap_ai/navigation_screen.dart';
import 'package:flutter/cupertino.dart';

import '../customer/job_posts/presentation/job_posts_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/terms_condition/terms_conditions_accept_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  ///Instat App routes Start

  static const String jobPostsScreen = '/jobPostsScreen';

  ///FitSnap AI Routes Start
  ///
  ///

  ///FitSnap AI Routes End

  static const String signinScreen = '/signinScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String navBarScreen = '/navBarScreen';
  static const String checkoutScreen = '/checkoutScreen';
  static const String wellDoneScreen = '/wellDoneScreen';
  static const String firstDayScreen = '/firstDayScreen';
  static const String myPlanScreen = '/myPlanScreen';
  static const String profileScreen = '/profileScreen';
  static const String viewProfileInfoScreen = '/viewProfileInfoScreen';
  static const String subscriptionAndBillingScreen =
      '/subscriptionAndBillingScreen';
  static const String addPaymentMethodScreen = '/addPaymentMethodScreen';
  static const String sendVerificationScreen = '/sendVerificationScreen';
  static const String verifyCodeScreen = '/verifyCodeScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String registrationSuccessfulScreen =
      '/registrationSuccessfulScreen';
  static const String termsConditionsAcceptScreen =
      '/termsConditionsAcceptScreen';
  static const String createCustomizePlanScreen = '/createCustomizePlanScreen';

  // Onboarding Screen
  static const String onboardingScreen = '/onboardingScreen';

  ///Instat App routes Ends
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      ///jobPostsScreen
      case Routes.jobPostsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: JobPostsScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => JobPostsScreen(),
              );

      ///Onboarding Screen
      case Routes.onboardingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OnboardingScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => OnboardingScreen(),
              );

      ///Sign up Screen
      case Routes.signUpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SignUpScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => SignUpScreen(),
              );

      ///Nav Bar Screen
      case Routes.navBarScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: NavigationScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => NavigationScreen(),
              );

      ///Registration Successful Screen
      case Routes.registrationSuccessfulScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: RegistrationSuccessfulScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => RegistrationSuccessfulScreen(),
              );

      ///Login Screen
      case Routes.signinScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SigninScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => SigninScreen(),
              );

      ///Send Verification Code Screen
      case Routes.sendVerificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SendVerificatinCodeScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => SendVerificatinCodeScreen(),
              );

      ///Verify Code Screen
      case Routes.verifyCodeScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: VerifyCodeScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => VerifyCodeScreen(),
              );

      ///Reset Password Screen
      case Routes.resetPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ResetPaswordScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ResetPaswordScreen(),
              );

      ///termsConditionsAcceptScreen
      case Routes.termsConditionsAcceptScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: TermsConditionsAcceptScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => TermsConditionsAcceptScreen(),
              );

      ///createCustomizePlanScreen
      case Routes.createCustomizePlanScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CreateCustomizePlanScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => CreateCustomizePlanScreen(),
              );

      ///checkoutScreen
      case Routes.checkoutScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CheckoutScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => CheckoutScreen(),
              );

      ///addPaymentMethodScreen
      case Routes.addPaymentMethodScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AddPaymentMethodScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => AddPaymentMethodScreen(),
              );

      ///wellDoneScreen
      case Routes.wellDoneScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: WellDoneScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => WellDoneScreen(),
              );

      ///firstDayScreen
      case Routes.firstDayScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: FirstDayScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => FirstDayScreen(),
              );

      ///myPlanScreen
      case Routes.myPlanScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MyPlanScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => MyPlanScreen(),
              );

      ///profileScreen
      case Routes.profileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ProfileScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ProfileScreen(),
              );

      ///subscriptionAndBillingScreen
      case Routes.subscriptionAndBillingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SubscriptionBillingScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => SubscriptionBillingScreen(),
              );

      ///viewProfileInfoScreen
      case Routes.viewProfileInfoScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ViewProfileInfoScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ViewProfileInfoScreen(),
              );

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
