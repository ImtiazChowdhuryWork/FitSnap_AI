import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fitsnap_ai/common_widgets/custom_toast.dart';
import 'package:fitsnap_ai/features/ai_cam/data/api.dart';
import 'package:fitsnap_ai/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class AiCamUploadImageRx extends RxResponseInt {
  final api = AiCamUploadImageApi.instance;

  String message = "Something went wrong";
  Map<String, dynamic> uploadResult = {};

  AiCamUploadImageRx({required super.empty, required super.dataFetcher});

  ValueStream get getUploadImageData => dataFetcher.stream;

  Future<bool> uploadImage({required File imageFile}) async {
    try {
      Map data = await api.uploadImage(imageFile: imageFile);
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    uploadResult = Map<String, dynamic>.from(data);
    message = data["message"] ?? "Image uploaded successfully";

    bool success = data["success"] ?? false;

    if (success) {
      CustomToastMessage(
        title: 'Success',
        description: message,
      );
      log("Image uploaded successfully: $data");
      return true;
    } else {
      CustomToastMessage(
        title: 'Error',
        description: message,
      );
      log("Upload failed: $message");
      return false;
    }
  }

  @override
  handleErrorWithReturn(error) async {
    String errorMessage = 'Something went wrong';
    log(error.toString());

    if (error is DioException && error.response?.data != null) {
      errorMessage = error.response?.data["message"] ?? errorMessage;

      if (error.type == DioExceptionType.connectionError) {
        errorMessage = "Check Your Network Connection";
      } else if (error.type == DioExceptionType.connectionTimeout) {
        errorMessage = "Connection timeout. Please try again.";
      } else if (error.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Server response timeout. Please try again.";
      }
    }

    message = errorMessage;
    uploadResult = {};
    log("Upload error: $errorMessage");

    CustomToastMessage(
      title: 'Upload Failed',
      description: errorMessage,
    );

    return false;
  }

  /// Get the upload result data
  Map<String, dynamic> getUploadResult() {
    return uploadResult;
  }

  /// Clear the upload data
  void clearUploadData() {
    uploadResult = {};
    message = "Something went wrong";
    dataFetcher.sink.add({});
  }
}
