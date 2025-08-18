import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitsnap_ai/features/auth/presentation/sign_up/model/sign_up_model.dart';
import 'package:fitsnap_ai/networks/dio/dio.dart';
import 'package:fitsnap_ai/networks/endpoints.dart';
import 'package:fitsnap_ai/networks/exception_handler/data_source.dart';

final class SignUpApi {
  SignUpApi._internal();
  static final SignUpApi _singletone = SignUpApi._internal();
  static SignUpApi get instance => _singletone;

  Future<SignUpModel> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? gender,
  }) async {
    try {
      Map data = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'gender': "male",
      };

      Response response = await postHttp(Endpoints.signUp(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        SignUpModel myData = SignUpModel.fromJson(
          jsonDecode(
            jsonEncode(response.data),
          ),
        );

        return myData;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
