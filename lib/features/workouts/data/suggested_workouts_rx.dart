import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitai/common_widgets/custom_toast.dart';
import 'package:fitai/features/workouts/data/suggested_workouts_api.dart';
import 'package:fitai/features/workouts/models/suggested_workouts_model.dart';
import 'package:fitai/networks/rx_base.dart';
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
      // Handle the new day-wise response format
      Map<String, dynamic>? workoutDaysData = data["data"];
      if (workoutDaysData != null) {
        // Flatten all workouts from all days into a single list for backward compatibility
        suggestedWorkouts = [];
        workoutDaysData.forEach((day, dayWorkouts) {
          if (dayWorkouts is List) {
            for (var dayWorkoutItem in dayWorkouts) {
              if (dayWorkoutItem['workout'] != null) {
                suggestedWorkouts.add(
                  SuggestedWorkoutItem.fromJson(dayWorkoutItem['workout'])
                );
              }
            }
          }
        });
        
        log("Suggested workouts retrieved successfully: ${suggestedWorkouts.length} total exercises across ${workoutDaysData.keys.length} days");
      } else {
        suggestedWorkouts = [];
        log("No workout data received");
      }
      
      return true;
    } else {
      log("API returned success=false: $message");
      return false;
    }
  }

  @override
  handleErrorWithReturn(error) async {
    if (error is DioException) {
      message = "Network error occurred";
      log("Network error while fetching suggested workouts: ${error.message}");
    } else {
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
