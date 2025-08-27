// import 'dart:developer';

// import 'package:fitsnap_ai/features/onboarding/providers/onboarding_provider.dart';
// import 'package:fitsnap_ai/networks/dio/dio.dart';
// import 'package:fitsnap_ai/networks/endpoints.dart';
// import 'package:get/get.dart';

// class onboardingController extends GetxController {
//   RxBool isLoading = false.obs;

//   RxString response = ''.obs;

//   Future<void> onboardingResponse() async{
//     try {
//       isLoading(true);
//      final data = await postHttp(Endpoints.onboarding(),(OnboardingProvider.onboardingResponse))
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }
