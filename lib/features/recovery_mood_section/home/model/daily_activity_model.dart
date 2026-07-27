class DailyActivityModel {
  bool? success;
  DailyActivityData? data;
  String? message;

  DailyActivityModel({
    this.success,
    this.data,
    this.message,
  });

  factory DailyActivityModel.fromJson(Map<String, dynamic> json) => DailyActivityModel(
        success: json["success"],
        data: (json["data"] == null || json["data"] is! Map)
            ? null
            : DailyActivityData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class DailyActivityData {
  List<DailyActivityItem>? night;
  List<DailyActivityItem>? morning;
  List<DailyActivityItem>? afternoon;
  List<DailyActivityItem>? evening;

  DailyActivityData({
    this.night,
    this.morning,
    this.afternoon,
    this.evening,
  });

  factory DailyActivityData.fromJson(Map<String, dynamic> json) => DailyActivityData(
        night: json["night"] == null
            ? []
            : List<DailyActivityItem>.from(
                json["night"]!.map((x) => DailyActivityItem.fromJson(x))),
        morning: json["morning"] == null
            ? []
            : List<DailyActivityItem>.from(
                json["morning"]!.map((x) => DailyActivityItem.fromJson(x))),
        afternoon: json["afternoon"] == null
            ? []
            : List<DailyActivityItem>.from(
                json["afternoon"]!.map((x) => DailyActivityItem.fromJson(x))),
        evening: json["evening"] == null
            ? []
            : List<DailyActivityItem>.from(
                json["evening"]!.map((x) => DailyActivityItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "night": night == null ? [] : List<dynamic>.from(night!.map((x) => x.toJson())),
        "morning": morning == null ? [] : List<dynamic>.from(morning!.map((x) => x.toJson())),
        "afternoon": afternoon == null ? [] : List<dynamic>.from(afternoon!.map((x) => x.toJson())),
        "evening": evening == null ? [] : List<dynamic>.from(evening!.map((x) => x.toJson())),
      };
}

class DailyActivityItem {
  int? id;
  String? type;
  String? title;
  String? time;
  String? status;

  DailyActivityItem({
    this.id,
    this.type,
    this.title,
    this.time,
    this.status,
  });

  factory DailyActivityItem.fromJson(Map<String, dynamic> json) => DailyActivityItem(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "time": time,
        "status": status,
      };
}
