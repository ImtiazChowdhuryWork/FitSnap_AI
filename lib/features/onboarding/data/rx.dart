
import 'package:fitsnap_ai/features/onboarding/data/api.dart';
import 'package:fitsnap_ai/features/onboarding/models/onboarding_model.dart';
import 'package:fitsnap_ai/features/onboarding/models/plan_intro_response_result.dart';
import 'package:rxdart/rxdart.dart';

import '../../../networks/rx_base.dart';


final class PostOnboardingRx extends RxResponseInt {
  final api = PostOnboardingApi.instance;

  String message = "Something went wrong";

  PostOnboardingRx({required super.empty, required super.dataFetcher});

  ValueStream get getPostLoginRes => dataFetcher.stream;

  Future<String> PostOnboarding({
    required OnboardingResponseModel onboardingResponse,
  }) async {
    try {
      // Map<String, dynamic> data = {
      //   'email': email,
      //   'password': password,
      // };
      PlanIntroResponseResulModel resdata = await api.postOnboarding(onboardingResponse.toJson());
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    if (data is PlanIntroResponseResulModel) {
      // Handle successful response
      return data.data?.gptResponse ?? "";
    }
  }

  @override
  handleErrorWithReturn(error) async {
    return error.toString();
  }
}
