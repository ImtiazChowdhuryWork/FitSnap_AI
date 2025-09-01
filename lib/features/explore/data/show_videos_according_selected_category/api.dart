import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitsnap_ai/networks/dio/dio.dart';
import 'package:fitsnap_ai/networks/endpoints.dart';
import 'package:fitsnap_ai/networks/exception_handler/data_source.dart';

final class GetSelectedCategoryVideoApi {
  GetSelectedCategoryVideoApi._internal();
  static final GetSelectedCategoryVideoApi _singleton =
      GetSelectedCategoryVideoApi._internal();
  static GetSelectedCategoryVideoApi get instance => _singleton;

  Future<Map> selectedCategoryVideoApi() async {
    try {
      Response response = await getHttp(Endpoints.videoAsSelectedCategory());

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
