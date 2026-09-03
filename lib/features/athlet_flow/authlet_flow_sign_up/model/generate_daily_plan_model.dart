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
  final DailyPlanInfoModel? planInfo;
  final DailyCheckinModel? checkin;
  final String? summary;
  final DailyProgressModel? progress;
  final List<DailyTaskModel>? tasks;

  DailyPlanData({
    this.planInfo,
    this.checkin,
    this.summary,
    this.progress,
    this.tasks,
  });

  factory DailyPlanData.fromJson(Map<String, dynamic> json) {
    return DailyPlanData(
      planInfo: json['plan_info'] != null
          ? DailyPlanInfoModel.fromJson(json['plan_info'])
          : null,
      checkin: json['checkin'] != null
          ? DailyCheckinModel.fromJson(json['checkin'])
          : null,
      summary: json['summary'],
      progress: json['progress'] != null
          ? DailyProgressModel.fromJson(json['progress'])
          : null,
      tasks: json['tasks'] != null
          ? (json['tasks'] as List)
              .map((x) => DailyTaskModel.fromJson(x))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_info': planInfo?.toJson(),
      'checkin': checkin?.toJson(),
      'summary': summary,
      'progress': progress?.toJson(),
      'tasks': tasks?.map((x) => x.toJson()).toList(),
    };
  }
}

class DailyPlanInfoModel {
  final String? goal;
  final int? week;
  final int? day;

  DailyPlanInfoModel({
    this.goal,
    this.week,
    this.day,
  });

  factory DailyPlanInfoModel.fromJson(Map<String, dynamic> json) {
    return DailyPlanInfoModel(
      goal: json['goal'],
      week: json['week'],
      day: json['day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goal': goal,
      'week': week,
      'day': day,
    };
  }
}

class DailyProgressModel {
  final num? overallPercentage;
  final DailyProgressCategoriesModel? categories;

  DailyProgressModel({
    this.overallPercentage,
    this.categories,
  });

  factory DailyProgressModel.fromJson(Map<String, dynamic> json) {
    return DailyProgressModel(
      overallPercentage: json['overall_percentage'],
      categories: json['categories'] != null
          ? DailyProgressCategoriesModel.fromJson(json['categories'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'overall_percentage': overallPercentage,
      'categories': categories?.toJson(),
    };
  }
}

class DailyProgressCategoriesModel {
  final num? activity;
  final num? food;
  final num? sleep;
  final num? supplement;

  DailyProgressCategoriesModel({
    this.activity,
    this.food,
    this.sleep,
    this.supplement,
  });

  factory DailyProgressCategoriesModel.fromJson(Map<String, dynamic> json) {
    return DailyProgressCategoriesModel(
      activity: json['activity'],
      food: json['food'],
      sleep: json['sleep'],
      supplement: json['supplement'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'food': food,
      'sleep': sleep,
      'supplement': supplement,
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
  final dynamic loggedValue;
  final num? progressPercentage;
  final num? weight;

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
    this.loggedValue,
    this.progressPercentage,
    this.weight,
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
      loggedValue: json['logged_value'],
      progressPercentage: json['progress_percentage'],
      weight: json['weight'],
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
      'logged_value': loggedValue,
      'progress_percentage': progressPercentage,
      'weight': weight,
    };
  }
}

