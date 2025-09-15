import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitsnap_ai/networks/dio/dio.dart';
import 'package:fitsnap_ai/networks/endpoints.dart';
import 'package:fitsnap_ai/networks/exception_handler/data_source.dart';

final class SuggestedWorkoutsApi {
  SuggestedWorkoutsApi._internal();
  static final SuggestedWorkoutsApi _singleton = SuggestedWorkoutsApi._internal();
  static SuggestedWorkoutsApi get instance => _singleton;

  Future<Map> getSuggestedWorkouts() async {
    try {
      Response response = await getHttp(
        Endpoints.suggestedWorkouts(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}