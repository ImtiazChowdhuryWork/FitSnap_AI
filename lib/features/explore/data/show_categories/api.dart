import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitai/networks/dio/dio.dart';
import 'package:fitai/networks/endpoints.dart';
import 'package:fitai/networks/exception_handler/data_source.dart';

final class ExploreCategoriesApi {
  ExploreCategoriesApi._internal();

  static final ExploreCategoriesApi _singleton =
      ExploreCategoriesApi._internal();
  static ExploreCategoriesApi get instance => _singleton;

  Future<Map> exploreCategories() async {
    try {
      Response response = await getHttp(Endpoints.exploreCategories());

      if (response.statusCode == 200) {
        Map data = jsonDecode(jsonEncode(response.data));

        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
