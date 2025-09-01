import 'dart:convert';

class ShowSelectedCategoryVideoModel {
  bool? success;
  String? message;
  List<Datum>? data;

  ShowSelectedCategoryVideoModel({
    this.success,
    this.message,
    this.data,
  });

  factory ShowSelectedCategoryVideoModel.fromRawJson(String str) =>
      ShowSelectedCategoryVideoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShowSelectedCategoryVideoModel.fromJson(Map<String, dynamic> json) =>
      ShowSelectedCategoryVideoModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? title;
  Gender? gender;
  String? video;
  int? category;

  Datum({
    this.id,
    this.title,
    this.gender,
    this.video,
    this.category,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        gender: genderValues.map[json["gender"]]!,
        video: json["video"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "gender": genderValues.reverse[gender],
        "video": video,
        "category": category,
      };
}

enum Gender { FEMALE, MALE, MALE_AND_FEMALE }

final genderValues = EnumValues({
  "female": Gender.FEMALE,
  "male": Gender.MALE,
  "male_and_female": Gender.MALE_AND_FEMALE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
