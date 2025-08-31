import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitsnap_ai/networks/dio/dio.dart';
import 'package:fitsnap_ai/networks/endpoints.dart';
import 'package:fitsnap_ai/networks/exception_handler/data_source.dart';

final class GetPrivacyPolicyApi {
  GetPrivacyPolicyApi._internal();

  static final GetPrivacyPolicyApi _singltone = GetPrivacyPolicyApi._internal();
  static GetPrivacyPolicyApi get instance => _singltone;

  Future<Map> fetchPrivacyPolicyApi() async {
    try {
      Response response = await getHttp(Endpoints.privacyPolicy());

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
