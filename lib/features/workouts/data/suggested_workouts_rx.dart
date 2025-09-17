import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitsnap_ai/common_widgets/custom_toast.dart';
import 'package:fitsnap_ai/features/workouts/data/suggested_workouts_api.dart';
import 'package:fitsnap_ai/features/workouts/models/suggested_workouts_model.dart';
import 'package:fitsnap_ai/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetSuggestedWorkoutsRx extends RxResponseInt {
  final api = SuggestedWorkoutsApi.instance;

  String message = "Something went wrong";
  List<SuggestedWorkoutItem> suggestedWorkouts = [];

  GetSuggestedWorkoutsRx({required super.empty, required super.dataFetcher});

  ValueStream get getSuggestedWorkoutsData => dataFetcher.stream;

  Future<bool> getSuggestedWorkouts({String? date}) async {
    try {
      Map data = await api.getSuggestedWorkouts(date: date);
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    message = data["message"] ?? "Suggested workouts retrieved successfully";

    bool success = data["success"] ?? false;

    if (success) {
      List<dynamic> workoutsData = data["data"] ?? [];
      suggestedWorkouts = workoutsData
          .map((item) => SuggestedWorkoutItem.fromJson(item))
          .toList();

      log("Suggested workouts retrieved successfully: ${suggestedWorkouts.length} items");
      return true;
    } else {
      CustomToastMessage(
        title: 'Error',
        description: message,
      );
      log("Failed to retrieve suggested workouts: $message");
      return false;
    }
  }

  @override
  handleErrorWithReturn(error) async {
    if (error is DioException) {
      message = "Network error occurred";
      log("Network error while fetching suggested workouts: ${error.message}");
    } else {
      message = "Failed to load suggested workouts";
      log("Error fetching suggested workouts: ${error.toString()}");
    }

    CustomToastMessage(
      title: 'Error',
      description: message,
    );

    return false;
  }

  /// Clear the workouts data
  void clearData() {
    suggestedWorkouts.clear();
    dataFetcher.sink.add({});
  }

  /// Get workouts filtered by gender
  List<SuggestedWorkoutItem> getWorkoutsByGender(String gender) {
    return suggestedWorkouts.where((workout) => workout.isForGender(gender)).toList();
  }

  /// Get workouts filtered by category
  List<SuggestedWorkoutItem> getWorkoutsByCategory(int categoryId) {
    return suggestedWorkouts.where((workout) => workout.isInCategory(categoryId)).toList();
  }

  /// Check if data is available
  bool get hasData => suggestedWorkouts.isNotEmpty;
}