class GenerateDailyPlanModel {
  final bool? success;
  final DailyPlanData? data;
  final String? message;

  GenerateDailyPlanModel({
    this.success,
    this.data,
    this.message,
  });

  factory GenerateDailyPlanModel.fromJson(Map<String, dynamic> json) {
    return GenerateDailyPlanModel(
      success: json['success'],
      data: json['data'] != null ? DailyPlanData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class DailyPlanData {
  final DailyCheckinModel? checkin;
  final String? summary;
  final List<DailyTaskModel>? tasks;

  DailyPlanData({
    this.checkin,
    this.summary,
    this.tasks,
  });

  factory DailyPlanData.fromJson(Map<String, dynamic> json) {
    return DailyPlanData(
      checkin: json['checkin'] != null
          ? DailyCheckinModel.fromJson(json['checkin'])
          : null,
      summary: json['summary'],
      tasks: json['tasks'] != null
          ? (json['tasks'] as List)
              .map((x) => DailyTaskModel.fromJson(x))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkin': checkin?.toJson(),
      'summary': summary,
      'tasks': tasks?.map((x) => x.toJson()).toList(),
    };
  }
}

class DailyCheckinModel {
  final int? id;
  final int? userId;
  final String? date;
  final String? sleepQuality;
  final String? energyLevel;
  final String? recoveryFeeling;
  final String? overallFeeling;
  final String? createdAt;
  final String? updatedAt;

  DailyCheckinModel({
    this.id,
    this.userId,
    this.date,
    this.sleepQuality,
    this.energyLevel,
    this.recoveryFeeling,
    this.overallFeeling,
    this.createdAt,
    this.updatedAt,
  });

  factory DailyCheckinModel.fromJson(Map<String, dynamic> json) {
    return DailyCheckinModel(
      id: json['id'],
      userId: json['user_id'],
      date: json['date'],
      sleepQuality: json['sleep_quality'],
      energyLevel: json['energy_level'],
      recoveryFeeling: json['recovery_feeling'],
      overallFeeling: json['overall_feeling'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date,
      'sleep_quality': sleepQuality,
      'energy_level': energyLevel,
      'recovery_feeling': recoveryFeeling,
      'overall_feeling': overallFeeling,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class DailyTaskModel {
  final int? id;
  final int? userId;
  final String? date;
  final String? category;
  final String? title;
  final dynamic targetValue;
  final String? targetUnit;
  final bool? isCompleted;
  final String? createdAt;
  final String? updatedAt;

  DailyTaskModel({
    this.id,
    this.userId,
    this.date,
    this.category,
    this.title,
    this.targetValue,
    this.targetUnit,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  factory DailyTaskModel.fromJson(Map<String, dynamic> json) {
    return DailyTaskModel(
      id: json['id'],
      userId: json['user_id'],
      date: json['date'],
      category: json['category'],
      title: json['title'],
      targetValue: json['target_value'],
      targetUnit: json['target_unit'],
      isCompleted: json['is_completed'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date,
      'category': category,
      'title': title,
      'target_value': targetValue,
      'target_unit': targetUnit,
      'is_completed': isCompleted,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
