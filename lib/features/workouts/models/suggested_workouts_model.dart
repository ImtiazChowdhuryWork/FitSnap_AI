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

class SuggestedWorkoutItem {
  int? id;
  String? title;
  String? gender;
  String? video;
  int? category;

  SuggestedWorkoutItem({
    this.id,
    this.title,
    this.gender,
    this.video,
    this.category,
  });

  factory SuggestedWorkoutItem.fromJson(Map<String, dynamic> json) =>
      SuggestedWorkoutItem(
        id: json["id"],
        title: json["title"],
        gender: json["gender"],
        video: json["video"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "gender": gender,
        "video": video,
        "category": category,
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
    return gender!.toLowerCase() == "male" ? "Male" : 
           gender!.toLowerCase() == "female" ? "Female" : "All";
  }

  /// Check if this workout is for a specific gender
  bool isForGender(String targetGender) {
    if (gender == null) return true;
    return gender!.toLowerCase() == targetGender.toLowerCase();
  }

  /// Check if this workout belongs to a specific category
  bool isInCategory(int targetCategory) {
    return category == targetCategory;
  }
}