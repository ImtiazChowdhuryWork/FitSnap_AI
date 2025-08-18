import 'package:provider/provider.dart';

import '../provider/custom_radius_button_controller.dart';
import '../provider/ai_cam_impage_picker_provider.dart';
import '../provider/navigation_provider.dart';
import '../provider/sign_up_screen_provider.dart';
import '../provider/update_profile_info_provider.dart';

var providers = [
  ChangeNotifierProvider<NavigationProvider>(
      create: ((context) => NavigationProvider())),
  ChangeNotifierProvider<CustomRadiusButtonController>(
      create: ((context) => CustomRadiusButtonController())),
  ChangeNotifierProvider<AiCamImagePickerProvider>(
      create: ((context) => AiCamImagePickerProvider())),
  ChangeNotifierProvider<UpdateProfileInfoProvider>(
      create: ((context) => UpdateProfileInfoProvider())),
  ChangeNotifierProvider<SignUpScreenProvider>(
      create: ((context) => SignUpScreenProvider())),
];
