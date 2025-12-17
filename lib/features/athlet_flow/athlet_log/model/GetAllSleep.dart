class GetAllSleepDataModel {
  bool? success;
  List<SleepData>? data;
  String? message;

  GetAllSleepDataModel({this.success, this.data, this.message});

  GetAllSleepDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SleepData>[];
      json['data'].forEach((v) {
        data!.add(new SleepData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class SleepData {
  int? id;
  int? userId;
  String? date;
  String? bedTime;
  String? wakeUpTime;
  int? durationMinutes;
  String? createdAt;
  String? updatedAt;
  String? duration;

  SleepData(
      {this.id,
        this.userId,
        this.date,
        this.bedTime,
        this.wakeUpTime,
        this.durationMinutes,
        this.createdAt,
        this.updatedAt,
        this.duration});

  SleepData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    bedTime = json['bed_time'];
    wakeUpTime = json['wake_up_time'];
    durationMinutes = json['duration_minutes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['bed_time'] = this.bedTime;
    data['wake_up_time'] = this.wakeUpTime;
    data['duration_minutes'] = this.durationMinutes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['duration'] = this.duration;
    return data;
  }
}
