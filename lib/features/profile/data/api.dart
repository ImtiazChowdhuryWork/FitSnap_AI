import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitai/networks/dio/dio.dart';
import 'package:fitai/networks/endpoints.dart';

import '../../../networks/exception_handler/data_source.dart';

final class GetProfileInfoApi {
  GetProfileInfoApi._internal();
  static final GetProfileInfoApi _singleton = GetProfileInfoApi._internal();
  static GetProfileInfoApi get instance => _singleton;

  Future<Map> fetchProfileInfo() async {
    try {
      Response response = await getHttp(
        Endpoints.getProfileData(),
      );

      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      throw ErrorHandler.handle(error).failure;
    }
  }
}
