class PlanIntroResponseResulModel {
  bool? success;
  String? message;
  Data? data;

  PlanIntroResponseResulModel({this.success, this.message, this.data});

  PlanIntroResponseResulModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? gptResponse;

  Data({this.gptResponse});

  Data.fromJson(Map<String, dynamic> json) {
    gptResponse = json['gpt_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gpt_response'] = this.gptResponse;
    return data;
  }
}
