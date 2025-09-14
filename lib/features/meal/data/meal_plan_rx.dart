import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitsnap_ai/common_widgets/custom_toast.dart';
import 'package:fitsnap_ai/features/meal/data/meal_plan_api.dart';
import 'package:fitsnap_ai/features/meal/models/meal_plan_model.dart';
import 'package:fitsnap_ai/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetMealPlanRx extends RxResponseInt {
  final api = MealPlanApi.instance;

  String message = "Something went wrong";
  MealPlanData? mealPlanData;

  GetMealPlanRx({required super.empty, required super.dataFetcher});

  ValueStream get getMealPlanData => dataFetcher.stream;

  Future<bool> getMealPlan() async {
    try {
      Map data = await api.getMealPlan();
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    message = data["message"] ?? "Meal plan retrieved successfully";

    bool success = data["success"] ?? false;

    if (success) {
      Map<String, dynamic>? planData = (data["data"].runtimeType == Map<String, dynamic>) ? data["data"] : null;
      if (planData != null) {
        mealPlanData = MealPlanData.fromJson(planData);
        log("Meal plan retrieved successfully: ${mealPlanData?.totalMeals} meals");
        return true;
      } else {
        
        log("No meal plan data found in response");
        return false;
      }
    } else {
      // CustomToastMessage(
      //   title: 'Error',
      //   description: message,
      // );
      log("Failed to retrieve meal plan: $message");
      return false;
    }
  }

  @override
  handleErrorWithReturn(error) async {
    if (error is DioException) {
      message = "Network error occurred";
      log("Network error while fetching meal plan: ${error.message}");
    } else {
      message = "Failed to load meal plan";
      log("Error fetching meal plan: ${error.toString()}");
    }

    // CustomToastMessage(
    //   title: 'Error',
    //   description: message,
    // );

    return false;
  }

  /// Clear the meal plan data
  void clearData() {
    mealPlanData = null;
    dataFetcher.sink.add({});
  }

  /// Check if meal plan data is available
  bool get hasData => mealPlanData != null;

  /// Get total daily calories as number
  String get dailyCalories {
    if (mealPlanData?.cleanCalories == null) return "0";
    final match = RegExp(r'(\d+)').firstMatch(mealPlanData!.cleanCalories);
    return match?.group(1) ?? "0";
  }

  /// Get meals by type (breakfast, lunch, dinner, etc.)
  List<MealItem> getMealsByType(String type) {
    if (mealPlanData?.meals == null) return [];
    return mealPlanData!.meals!
        .where((meal) => meal.mealType.toLowerCase().contains(type.toLowerCase()))
        .toList();
  }
}