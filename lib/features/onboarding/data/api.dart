import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../networks/dio/dio.dart';
import '../../../networks/endpoints.dart';
import '../../../networks/exception_handler/data_source.dart';
import '../models/plan_intro_response_result.dart';

final class PostOnboardingApi {
  PostOnboardingApi._internal();
  static final PostOnboardingApi _singleton = PostOnboardingApi._internal();

  static PostOnboardingApi get instance => _singleton;
  Future<PlanIntroResponseResulModel> postOnboarding(Map data) async {
    try {
      Response response = await postHttp(
        Endpoints.onboarding(),
        data,
      );
      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;

        ///Somthig
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
