import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fitsnap_ai/networks/dio/dio.dart';
import 'package:fitsnap_ai/networks/endpoints.dart';
import 'package:fitsnap_ai/networks/exception_handler/data_source.dart';

final class AiCamUploadImageApi {
  AiCamUploadImageApi._internal();
  static final AiCamUploadImageApi _singleton = AiCamUploadImageApi._internal();
  static AiCamUploadImageApi get instance => _singleton;

  Future<Map> uploadImage({required File imageFile}) async {
    try {
      // Create FormData for multipart request
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      Response response = await postHttp(
        Endpoints.uploadBodyImage(),
        formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
