import 'dart:convert';

class GetRecentActivityModel {
  bool? success;
  List<Datum>? data;
  String? message;

  GetRecentActivityModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetRecentActivityModel.fromRawJson(String str) => GetRecentActivityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetRecentActivityModel.fromJson(Map<String, dynamic> json) => GetRecentActivityModel(
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
  String? name;
  String? date;
  String? time;
  int? durationMinutes;
  int? notifyBeforeMinutes;
  String? notes;

  Datum({
    this.id,
    this.userId,
    this.name,
    this.date,
    this.time,
    this.durationMinutes,
    this.notifyBeforeMinutes,
    this.notes,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    date: json["date"],
    time: json["time"],
    durationMinutes: json["duration_minutes"],
    notifyBeforeMinutes: json["notify_before_minutes"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "date": date,
    "time": time,
    "duration_minutes": durationMinutes,
    "notify_before_minutes": notifyBeforeMinutes,
    "notes": notes,
  };
}
