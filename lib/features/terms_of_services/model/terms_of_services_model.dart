import 'dart:convert';

class TermsOfServicesModel {
  bool? success;
  String? message;
  Data? data;

  TermsOfServicesModel({
    this.success,
    this.message,
    this.data,
  });

  factory TermsOfServicesModel.fromRawJson(String str) =>
      TermsOfServicesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsOfServicesModel.fromJson(Map<String, dynamic> json) =>
      TermsOfServicesModel(
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
