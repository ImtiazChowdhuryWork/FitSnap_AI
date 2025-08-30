import 'dart:convert';

class ViewProfileInfoModel {
  bool? success;
  String? message;
  Data? data;

  ViewProfileInfoModel({
    this.success,
    this.message,
    this.data,
  });

  factory ViewProfileInfoModel.fromRawJson(String str) =>
      ViewProfileInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ViewProfileInfoModel.fromJson(Map<String, dynamic> json) =>
      ViewProfileInfoModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? email;
  String? fullName;
  bool? acceptedTerms;
  dynamic avatarUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.email,
    this.fullName,
    this.acceptedTerms,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        fullName: json["full_name"],
        acceptedTerms: json["accepted_terms"],
        avatarUrl: json["avatar_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "full_name": fullName,
        "accepted_terms": acceptedTerms,
        "avatar_url": avatarUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
