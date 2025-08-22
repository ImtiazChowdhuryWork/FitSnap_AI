import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import '../../../../helpers/post_login.dart';
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
    await appData.write(kKeyIsLoggedIn, true);
    String? accesstoken = data['data']['access'];
    // int id = data['data']['id'];
    DioSingleton.instance.update(accesstoken!);
    performPostLoginActions();
    await appData.write(kKeyIsLoggedIn, true);
    await appData.write(kKeyIsExploring, false);
    // await appData.write(kKeyUserID, id);
    await appData.write(kKeyAccessToken, accesstoken);
    

    dataFetcher.sink.add(data);

    // message = data["message"];
    // if (data["success"] == false) throw Exception();
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message = error.response?.data["message"] ?? "Something went wrong";
      //   int code = error.response?.data["code"] ?? -1;
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }

    CustomToastMessage('Error', message);
    return false;
    //return super.handleErrorWithReturn(message);
  }
}
