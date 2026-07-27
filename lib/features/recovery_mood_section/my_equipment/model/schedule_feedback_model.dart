import 'dart:convert';

class ScheduleFeedbackModel {
  bool? success;
  List<FeedbackDatum>? data;
  String? message;

  ScheduleFeedbackModel({
    this.success,
    this.data,
    this.message,
  });

  factory ScheduleFeedbackModel.fromRawJson(String str) =>
      ScheduleFeedbackModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScheduleFeedbackModel.fromJson(Map<String, dynamic> json) =>
      ScheduleFeedbackModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<FeedbackDatum>.from(
                json["data"]!.map((x) => FeedbackDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class FeedbackDatum {
  int? id;
  int? userId;
  String? date;
  String? rating;

  FeedbackDatum({
    this.id,
    this.userId,
    this.date,
    this.rating,
  });

  factory FeedbackDatum.fromRawJson(String str) =>
      FeedbackDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeedbackDatum.fromJson(Map<String, dynamic> json) => FeedbackDatum(
        id: json["id"],
        userId: json["user_id"],
        date: json["date"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "date": date,
        "rating": rating,
      };
}
