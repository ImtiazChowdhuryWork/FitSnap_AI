import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';

final class GetSelectedCategoryVideoApi {
  GetSelectedCategoryVideoApi._internal();
  static final GetSelectedCategoryVideoApi _singleton =
      GetSelectedCategoryVideoApi._internal();
  static GetSelectedCategoryVideoApi get instance => _singleton;

  Future<Map> selectedCategoryVideoApi({int? categoryId}) async {
    try {
      String url = Endpoints.videoAsSelectedCategory();
      if (categoryId != null) {
        url += "?category_id=$categoryId";
      }
      Response response = await getHttp(url);

      if (response.statusCode == 200) {
        Map data = jsonDecode(jsonEncode(response.data));
        return data;
      } else {
        throw Exception("Failed to fetch videos");
      }
    } catch (error) {
      rethrow;
    }
  }
}
