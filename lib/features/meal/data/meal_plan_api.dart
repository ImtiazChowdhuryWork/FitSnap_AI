import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitai/networks/dio/dio.dart';
import 'package:fitai/networks/endpoints.dart';
import 'package:fitai/networks/exception_handler/data_source.dart';

final class MealPlanApi {
  MealPlanApi._internal();
  static final MealPlanApi _singleton = MealPlanApi._internal();
  static MealPlanApi get instance => _singleton;

  Future<Map> getMealPlan() async {
    try {
      Response response = await getHttp(
        Endpoints.mealPlan(),
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
