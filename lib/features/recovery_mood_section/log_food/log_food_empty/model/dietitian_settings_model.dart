import 'dart:convert';

class DietitianSettingsModel {
  bool? success;
  DietitianSettingsData? data;
  String? message;

  DietitianSettingsModel({this.success, this.data, this.message});

  factory DietitianSettingsModel.fromRawJson(String str) => DietitianSettingsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DietitianSettingsModel.fromJson(Map<String, dynamic> json) => DietitianSettingsModel(
    success: json["success"],
    data: json["data"] == null ? null : DietitianSettingsData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class DietitianSettingsData {
  int? id;
  int? userId;
  bool? isEnabled;
  String? name;
  String? dietitianEmail;
  String? sendTime;

  DietitianSettingsData({
    this.id,
    this.userId,
    this.isEnabled,
    this.name,
    this.dietitianEmail,
    this.sendTime,
  });

  factory DietitianSettingsData.fromJson(Map<String, dynamic> json) {
    var isEnabledValue = json["is_enabled"];
    bool isEnabledParsed = false;
    if (isEnabledValue == 1 || isEnabledValue == true || isEnabledValue == '1' || isEnabledValue == 'true') {
      isEnabledParsed = true;
    }
    return DietitianSettingsData(
      id: json["id"],
      userId: json["user_id"],
      isEnabled: isEnabledParsed,
      name: json["name"],
      dietitianEmail: json["dietitian_email"],
      sendTime: json["send_time"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "is_enabled": isEnabled,
    "name": name,
    "dietitian_email": dietitianEmail,
    "send_time": sendTime,
  };
}
