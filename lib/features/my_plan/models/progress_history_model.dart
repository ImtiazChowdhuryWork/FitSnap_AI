class ProgressHistoryModel {
  bool? success;
  String? message;
  List<ProgressHistoryItem>? data;

  ProgressHistoryModel({
    this.success,
    this.message,
    this.data,
  });

  factory ProgressHistoryModel.fromJson(Map<String, dynamic> json) =>
      ProgressHistoryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ProgressHistoryItem>.from(
                json["data"]!.map((x) => ProgressHistoryItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProgressHistoryItem {
  int? id;
  int? user;
  String? tips;
  String? differentiateFromPrevious;
  String? currentAnalysis;
  String? status;
  String? previousImage;
  String? currentImage;
  String? date;

  ProgressHistoryItem({
    this.id,
    this.user,
    this.tips,
    this.differentiateFromPrevious,
    this.currentAnalysis,
    this.status,
    this.previousImage,
    this.currentImage,
    this.date,
  });

  factory ProgressHistoryItem.fromJson(Map<String, dynamic> json) =>
      ProgressHistoryItem(
        id: json["id"],
        user: json["user"],
        tips: json["tips"],
        differentiateFromPrevious: json["differentiate_from_previous"],
        currentAnalysis: json["current_analysis"],
        status: json["status"],
        previousImage: json["previous_image"],
        currentImage: json["current_image"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "tips": tips,
        "differentiate_from_previous": differentiateFromPrevious,
        "current_analysis": currentAnalysis,
        "status": status,
        "previous_image": previousImage,
        "current_image": currentImage,
        "date": date,
      };

  /// Get formatted date for display
  String get formattedDate {
    if (date == null) return "";
    try {
      DateTime dateTime = DateTime.parse(date!);
      return "${_getMonthName(dateTime.month)} ${dateTime.day} - ${_getMonthName(dateTime.month)} ${dateTime.day + 6}";
    } catch (e) {
      return date ?? "";
    }
  }

  String _getMonthName(int month) {
    const monthNames = [
      "", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return monthNames[month];
  }

  /// Check if this item has both previous and current images for comparison
  bool get hasComparison => previousImage != null && currentImage != null;

  /// Get the full image URLs (assuming base URL needs to be added)
  String? get fullPreviousImageUrl {
    if (previousImage == null) return null;
    // Add your base URL here if needed
    return previousImage;
  }

  String? get fullCurrentImageUrl {
    if (currentImage == null) return null;
    // Add your base URL here if needed
    return currentImage;
  }
}