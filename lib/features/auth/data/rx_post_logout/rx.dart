import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostLogOutRX extends RxResponseInt {
  final api = LogOutApi.instance;

  String message = "Something went wrong";

  PostLogOutRX({required super.empty, required super.dataFetcher});

  ValueStream get getLogoutData => dataFetcher.stream;

  Future<bool> logOut() async {
    try {
      Map resdata = await api.logOut();
      return handleSuccessWithReturn(resdata);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  // @override
  // handleSuccessWithReturn(data) async{
  //   dataFetcher.sink.add(data);

  //   var success = data["message"];
  //   if (success == true) {
  //     await appData.remove(kKeyAccessToken);
  //     await appData.write(kKeyIsLoggedIn, false);
  //     await appData.write(kKeyfirstTime, false);
  //   }
  //   // message = data["message"];
  //   // if (data["success"] == false) throw Exception();
  //   return true;
  // }

  // @override
  // handleErrorWithReturn(error) {
  //   String errorMessage = 'Something went wrong';
  //   log(error.toString());

  //   errorMessage = error.response?.data["message"] ?? "Something went wrong";
  //   return super.handleErrorWithReturn(errorMessage);
  // }

  @override
  Future<bool> handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);

    bool success = data["success"] ?? false;
    message = data["message"] ?? "Something went wrong";

    if (success) {
      await appData.remove(kKeyAccessToken);
      // await appData.remove(kKeyRefreshToken);
      await appData.write(kKeyIsLoggedIn, false);
      await appData.write(kKeyfirstTime, false);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> handleErrorWithReturn(error) async {
    String errorMessage = 'Something went wrong';
    log(error.toString());

    if (error is DioException && error.response?.data != null) {
      errorMessage = error.response?.data["message"] ?? errorMessage;
    }
    message = errorMessage;
    log("Error : $errorMessage");
    return false; // important: return false, not super.call
  }
}
