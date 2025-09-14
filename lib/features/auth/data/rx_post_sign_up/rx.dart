import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitsnap_ai/common_widgets/custom_toast.dart';
import 'package:fitsnap_ai/constants/app_constants.dart';
import 'package:fitsnap_ai/features/auth/data/rx_post_sign_up/api.dart';
import 'package:fitsnap_ai/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

import '../../../../helpers/di.dart';
import '../../presentation/sign_up/model/sign_up_model.dart';

final class PostSignUpRx extends RxResponseInt<SignUpModel> {
  final api = SignUpApi.instance;
  PostSignUpRx({required super.empty, required super.dataFetcher});
  ValueStream<SignUpModel> get getFileData => dataFetcher.stream;

  Future<bool> signUp({
    required String fullName,
    // required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      SignUpModel data = await api.signUp(
        fullName: fullName,
        // lastName: lastName,
        email: email,
        password: password,
      );

      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  ///Success
  @override
  handleSuccessWithReturn(SignUpModel data) async {
    await appData.write(kKeyIsLoggedIn, false);
    // await appData.write(kKeyFirstName, data.data!.firstName);
    // await appData.write(kKeyLastName, data.data!.lastName);
    // await appData.write(kEmail, data.data!.email);
    return true;
  }

  ///Error
  @override
  handleErrorWithReturn(error) async {
    String message = "Something wen wrong";
    log("Error : ${error.toString}");

    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError) {

        message = "Check Your Network Connection";
      }
    }
message =  error.response?.data ["message"] ?? message;
    CustomToastMessage(title: "Error", description: message);
    return false;
  }
}
