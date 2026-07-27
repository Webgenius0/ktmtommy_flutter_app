class ScheduleModel {
  bool? success;
  ScheduleData? data;
  String? message;

  ScheduleModel({
    this.success,
    this.data,
    this.message,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        success: json["success"],
        data: json["data"] == null ? null : ScheduleData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class ScheduleData {
  List<ScheduleSession>? night;
  List<ScheduleSession>? morning;
  List<ScheduleSession>? afternoon;
  List<ScheduleSession>? evening;

  ScheduleData({
    this.night,
    this.morning,
    this.afternoon,
    this.evening,
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) => ScheduleData(
        night: json["night"] == null
            ? []
            : List<ScheduleSession>.from(
                json["night"]!.map((x) => ScheduleSession.fromJson(x))),
        morning: json["morning"] == null
            ? []
            : List<ScheduleSession>.from(
                json["morning"]!.map((x) => ScheduleSession.fromJson(x))),
        afternoon: json["afternoon"] == null
            ? []
            : List<ScheduleSession>.from(
                json["afternoon"]!.map((x) => ScheduleSession.fromJson(x))),
        evening: json["evening"] == null
            ? []
            : List<ScheduleSession>.from(
                json["evening"]!.map((x) => ScheduleSession.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "night": night == null ? [] : List<dynamic>.from(night!.map((x) => x.toJson())),
        "morning": morning == null ? [] : List<dynamic>.from(morning!.map((x) => x.toJson())),
        "afternoon": afternoon == null ? [] : List<dynamic>.from(afternoon!.map((x) => x.toJson())),
        "evening": evening == null ? [] : List<dynamic>.from(evening!.map((x) => x.toJson())),
      };
}

class ScheduleSession {
  int? id;
  int? userId;
  String? sessionName;
  String? date;
  String? time;
  int? duration;
  int? notificationBefore;
  String? repeat;
  List<dynamic>? customDays;
  String? notes;
  String? status;

  ScheduleSession({
    this.id,
    this.userId,
    this.sessionName,
    this.date,
    this.time,
    this.duration,
    this.notificationBefore,
    this.repeat,
    this.customDays,
    this.notes,
    this.status,
  });

  factory ScheduleSession.fromJson(Map<String, dynamic> json) => ScheduleSession(
        id: json["id"],
        userId: json["user_id"],
        sessionName: json["session_name"],
        date: json["date"],
        time: json["time"],
        duration: json["duration"],
        notificationBefore: json["notification_before"],
        repeat: json["repeat"],
        customDays: json["custom_days"] is List
            ? json["custom_days"]
            : (json["custom_days"] != null ? [json["custom_days"]] : null),
        notes: json["notes"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "session_name": sessionName,
        "date": date,
        "time": time,
        "duration": duration,
        "notification_before": notificationBefore,
        "repeat": repeat,
        "custom_days": customDays,
        "notes": notes,
        "status": status,
      };
}
