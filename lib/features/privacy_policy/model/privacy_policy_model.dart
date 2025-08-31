import 'dart:convert';

class PrivacyPolicyModel {
  bool? success;
  String? message;
  Data? data;

  PrivacyPolicyModel({
    this.success,
    this.message,
    this.data,
  });

  factory PrivacyPolicyModel.fromRawJson(String str) =>
      PrivacyPolicyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyModel(
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
  String? title;
  String? content;
  String? type;

  Data({
    this.title,
    this.content,
    this.type,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        content: json["content"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "type": type,
      };
}
