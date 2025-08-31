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
  User? user;
  String? fullName;
  dynamic avatar;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.user,
    this.fullName,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        fullName: json["full_name"],
        avatar: json["avatar"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "full_name": fullName,
        "avatar": avatar,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  int? id;
  String? email;
  bool? isStaff;
  bool? isActive;
  DateTime? dateJoined;
  int? profile;

  User({
    this.id,
    this.email,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.profile,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: json["date_joined"] == null
            ? null
            : DateTime.parse(json["date_joined"]),
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined?.toIso8601String(),
        "profile": profile,
      };
}
