import 'dart:convert';

class SignUpModel {
  bool? success;
  String? message;
  Data? data;

  SignUpModel({
    this.success,
    this.message,
    this.data,
  });

  factory SignUpModel.fromRawJson(String str) =>
      SignUpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
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
  String? fullName;
  String? email;

  Data({
    this.id,
    this.fullName,
    this.email,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
      };
}
