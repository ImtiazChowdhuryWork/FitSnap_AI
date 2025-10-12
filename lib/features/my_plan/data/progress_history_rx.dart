import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitai/common_widgets/custom_toast.dart';
import 'package:fitai/features/my_plan/data/progress_history_api.dart';
import 'package:fitai/features/my_plan/models/progress_history_model.dart';
import 'package:fitai/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetProgressHistoryRx extends RxResponseInt {
  final api = ProgressHistoryApi.instance;

  String message = "Something went wrong";
  List<ProgressHistoryItem> progressHistory = [];

  GetProgressHistoryRx({required super.empty, required super.dataFetcher});

  ValueStream get getProgressHistoryData => dataFetcher.stream;

  Future<bool> getProgressHistory({String? date}) async {
    try {
      Map data = await api.getProgressHistory(date: date);
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    message = data["message"] ?? "Progress history retrieved successfully";

    bool success = data["success"] ?? false;

    if (success) {
      List<dynamic> historyData = data["data"] ?? [];
      progressHistory = historyData
          .map((item) => ProgressHistoryItem.fromJson(item))
          .toList();

      log("Progress history retrieved successfully: ${progressHistory.length} items");
      return true;
    } else {
      CustomToastMessage(
        title: 'Error',
        description: message,
      );
      log("Failed to retrieve progress history: $message");
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
    progressHistory = [];
    log("Progress history error: $errorMessage");

    CustomToastMessage(
      title: 'Error',
      description: errorMessage,
    );

    return false;
  }

  /// Get the latest progress item (most recent)
  ProgressHistoryItem? getLatestProgress() {
    if (progressHistory.isEmpty) return null;
    return progressHistory.first;
  }

  /// Clear the progress data
  void clearProgressData() {
    progressHistory = [];
    message = "Something went wrong";
    dataFetcher.sink.add({});
  }
}
