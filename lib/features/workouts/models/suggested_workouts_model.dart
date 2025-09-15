import 'package:fitsnap_ai/networks/endpoints.dart';

class SuggestedWorkoutsModel {
  bool? success;
  String? message;
  List<SuggestedWorkoutItem>? data;

  SuggestedWorkoutsModel({
    this.success,
    this.message,
    this.data,
  });

  factory SuggestedWorkoutsModel.fromJson(Map<String, dynamic> json) =>
      SuggestedWorkoutsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SuggestedWorkoutItem>.from(
                json["data"]!.map((x) => SuggestedWorkoutItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WorkoutCategory {
  int? id;
  String? name;

  WorkoutCategory({
    this.id,
    this.name,
  });

  factory WorkoutCategory.fromJson(Map<String, dynamic> json) =>
      WorkoutCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class SuggestedWorkoutItem {
  int? id;
  WorkoutCategory? category;
  String? title;
  String? gender;
  String? video;

  SuggestedWorkoutItem({
    this.id,
    this.category,
    this.title,
    this.gender,
    this.video,
  });

  factory SuggestedWorkoutItem.fromJson(Map<String, dynamic> json) =>
      SuggestedWorkoutItem(
        id: json["id"],
        category: json["category"] == null
            ? null
            : WorkoutCategory.fromJson(json["category"]),
        title: json["title"],
        gender: json["gender"],
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category?.toJson(),
        "title": title,
        "gender": gender,
        "video": video,
      };

  /// Get the full video URL for playback
  String get fullVideoUrl {
    if (video == null) return "";

    // If video URL already contains http, return as is
    if (video!.startsWith('http')) {
      return video!;
    }

    // Otherwise, construct the full URL with base URL
    return "$baseUrl$video";
  }

  /// Get formatted title for display
  String get displayTitle => title ?? "Untitled Workout";

  /// Get formatted gender for display
  String get displayGender {
    if (gender == null) return "All";
    return gender!.toLowerCase() == "male"
        ? "Male"
        : gender!.toLowerCase() == "female"
            ? "Female"
            : "All";
  }

  /// Check if this workout is for a specific gender
  bool isForGender(String targetGender) {
    if (gender == null) return true;
    return gender!.toLowerCase() == targetGender.toLowerCase();
  }

  /// Check if this workout belongs to a specific category
  bool isInCategory(int targetCategory) {
    return category?.id == targetCategory;
  }
}
