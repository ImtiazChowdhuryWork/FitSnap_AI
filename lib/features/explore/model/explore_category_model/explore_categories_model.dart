import 'dart:convert';

class ExploreCategoriesModel {
  bool? success;
  String? message;
  List<Datum>? data;

  ExploreCategoriesModel({
    this.success,
    this.message,
    this.data,
  });

  factory ExploreCategoriesModel.fromRawJson(String str) =>
      ExploreCategoriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExploreCategoriesModel.fromJson(Map<String, dynamic> json) =>
      ExploreCategoriesModel(
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
  String? name;

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
