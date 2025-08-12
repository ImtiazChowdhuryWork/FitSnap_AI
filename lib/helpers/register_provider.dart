import 'package:provider/provider.dart';

import '../provider/custom_radius_button_controller.dart';
import '../provider/navigation_provider.dart';

var providers = [
  ChangeNotifierProvider<NavigationProvider>(
      create: ((context) => NavigationProvider())),
  ChangeNotifierProvider<CustomRadiusButtonController>(
      create: ((context) => CustomRadiusButtonController())),
];
