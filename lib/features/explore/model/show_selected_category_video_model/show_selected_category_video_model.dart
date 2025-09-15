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

class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Datum {
  int? id;
  String? title;
  Gender? gender;
  String? video;
  Category? category;

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
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "gender": genderValues.reverse[gender],
        "video": video,
        "category": category?.toJson(),
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
