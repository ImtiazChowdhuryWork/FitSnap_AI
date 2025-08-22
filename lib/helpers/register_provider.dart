import 'package:fitsnap_ai/provider/impage_picker_provider_fitsnap.dart';
import 'package:provider/provider.dart';

import '../features/onboarding/providers/onboarding_provider.dart';
import '../provider/custom_radius_button_controller.dart';
import '../provider/navigation_provider.dart';

var providers = [
  ChangeNotifierProvider<NavigationProvider>(
      create: ((context) => NavigationProvider())),
  ChangeNotifierProvider<CustomRadiusButtonController>(
      create: ((context) => CustomRadiusButtonController())),
  ChangeNotifierProvider<ImagePickerProviderFitsnap>(
      create: ((context) => ImagePickerProviderFitsnap())),
  ChangeNotifierProvider<OnboardingProvider>(
      create: ((context) => OnboardingProvider()))
];
