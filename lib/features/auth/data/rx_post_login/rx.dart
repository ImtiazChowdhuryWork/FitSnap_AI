import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostLoginRx extends RxResponseInt {
  final api = PostLoginApi.instance;

  String message = "Something went wrong";

  PostLoginRx({required super.empty, required super.dataFetcher});

  ValueStream get getPostLoginRes => dataFetcher.stream;

  Future<bool> postLogin({
    String? email,
    String? password,
  }) async {
    try {
      Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };
      Map resdata = await api.postLogIn(data);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    ///Access Token Section
    String? accesstoken = data['data']['access_token'];
    DioSingleton.instance.update(accesstoken!);

    ///Refresh Token Section
    String? refreshtoken = data['data']['refresh_token'];

    ///User Id Section
    int id = data['data']['id'];

    ///User Status Section
    await appData.write(kKeyIsLoggedIn, true);
    log("User Logged In Successfully : ${appData.read(kKeyIsLoggedIn)}");

    await appData.write(kKeyIsExploring, false);
    log("User is Exploring : ${appData.read(kKeyIsExploring)}");

    await appData.write(kKeyAccessToken, accesstoken);
    log("Access Token : ${appData.read(kKeyAccessToken)}");

    await appData.write(kKeyRefreshToken, refreshtoken);
    log("Refresh Token : ${appData.read(kKeyRefreshToken)}");

    await appData.write(kKeyUserID, id);
    log("User ID : ${appData.read(kKeyUserID)}");

    dataFetcher.sink.add(data);
    // performPostLoginActions();
    // message = data["message"];
    // if (data["success"] == false) throw Exception();
    return true;
  }

  @override
  handleErrorWithReturn(error) async {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message = error.response?.data["message"] ?? "Something went wrong";
      //   int code = error.response?.data["code"] ?? -1;
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }

    CustomToastMessage(title: 'Error', description: message);
    return false;
    //return super.handleErrorWithReturn(message);
  }
}
