import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitai/networks/dio/dio.dart';
import 'package:fitai/networks/endpoints.dart';
import 'package:fitai/networks/exception_handler/data_source.dart';

final class SuggestedWorkoutsApi {
  SuggestedWorkoutsApi._internal();
  static final SuggestedWorkoutsApi _singleton = SuggestedWorkoutsApi._internal();
  static SuggestedWorkoutsApi get instance => _singleton;

  Future<Map> getSuggestedWorkouts({String? date}) async {
    try {
      String endpoint = Endpoints.suggestedWorkouts();
      if (date != null) {
        endpoint += "?date=$date";
      }
      
      Response response = await getHttp(endpoint);

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
