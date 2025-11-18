import 'dart:convert';

class GetRecentStepModel {
  bool? success;
  List<Datum>? data;
  String? message;

  GetRecentStepModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetRecentStepModel.fromRawJson(String str) => GetRecentStepModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetRecentStepModel.fromJson(Map<String, dynamic> json) => GetRecentStepModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  int? id;
  int? userId;
  String? activity;
  int? hours;
  int? minutes;
  dynamic duration;
  String? recordedAt;
  String? recordedAgo;

  Datum({
    this.id,
    this.userId,
    this.activity,
    this.hours,
    this.minutes,
    this.duration,
    this.recordedAt,
    this.recordedAgo,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    activity: json["activity"],
    hours: json["hours"],
    minutes: json["minutes"],
    duration: json["duration"],
    recordedAt: json["recorded_at"],
    recordedAgo: json["recorded_ago"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "activity": activity,
    "hours": hours,
    "minutes": minutes,
    "duration": duration,
    "recorded_at": recordedAt,
    "recorded_ago": recordedAgo,
  };
}
