import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitsnap_ai/networks/dio/dio.dart';
import 'package:fitsnap_ai/networks/endpoints.dart';
import 'package:fitsnap_ai/networks/exception_handler/data_source.dart';

final class GetTermsOfServicesApi {
  GetTermsOfServicesApi._internal();

  static final GetTermsOfServicesApi _singleton =
      GetTermsOfServicesApi._internal();
  static GetTermsOfServicesApi get instance => _singleton;

  Future<Map> fetchTermsOfServicesApi() async {
    try {
      Response response = await getHttp(Endpoints.termsOfServices());

      if (response.statusCode == 200) {
        Map data = jsonDecode(jsonEncode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
