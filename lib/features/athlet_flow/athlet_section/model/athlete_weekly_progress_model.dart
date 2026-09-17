class AthleteWeeklyProgressModel {
  bool? success;
  AthleteWeeklyProgressData? data;
  String? message;

  AthleteWeeklyProgressModel({this.success, this.data, this.message});

  AthleteWeeklyProgressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? AthleteWeeklyProgressData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    map['message'] = message;
    return map;
  }
}

class AthleteWeeklyProgressData {
  PlanInfo? planInfo;
  Readiness? readiness;
  WeekOverview? weekOverview;
  List<ChartData>? chartData;
  AiWeeklyInsight? aiWeeklyInsight;
  List<AvailableWeeks>? availableWeeks;

  AthleteWeeklyProgressData({
    this.planInfo,
    this.readiness,
    this.weekOverview,
    this.chartData,
    this.aiWeeklyInsight,
    this.availableWeeks,
  });

  AthleteWeeklyProgressData.fromJson(Map<String, dynamic> json) {
    planInfo = json['plan_info'] != null ? PlanInfo.fromJson(json['plan_info']) : null;
    readiness = json['readiness'] != null ? Readiness.fromJson(json['readiness']) : null;
    weekOverview = json['week_overview'] != null ? WeekOverview.fromJson(json['week_overview']) : null;
    if (json['chart_data'] != null) {
      chartData = <ChartData>[];
      json['chart_data'].forEach((v) {
        chartData!.add(ChartData.fromJson(v));
      });
    }
    aiWeeklyInsight = json['ai_weekly_insight'] != null
        ? AiWeeklyInsight.fromJson(json['ai_weekly_insight'])
        : null;
    if (json['available_weeks'] != null) {
      availableWeeks = <AvailableWeeks>[];
      json['available_weeks'].forEach((v) {
        availableWeeks!.add(AvailableWeeks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (planInfo != null) map['plan_info'] = planInfo!.toJson();
    if (readiness != null) map['readiness'] = readiness!.toJson();
    if (weekOverview != null) map['week_overview'] = weekOverview!.toJson();
    if (chartData != null) map['chart_data'] = chartData!.map((v) => v.toJson()).toList();
    if (aiWeeklyInsight != null) map['ai_weekly_insight'] = aiWeeklyInsight!.toJson();
    if (availableWeeks != null) map['available_weeks'] = availableWeeks!.map((v) => v.toJson()).toList();
    return map;
  }
}

class PlanInfo {
  String? goal;
  int? currentWeek;
  int? currentDay;
  String? displayText;

  PlanInfo({this.goal, this.currentWeek, this.currentDay, this.displayText});

  PlanInfo.fromJson(Map<String, dynamic> json) {
    goal = json['goal'];
    currentWeek = json['current_week'];
    currentDay = json['current_day'];
    displayText = json['display_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['goal'] = goal;
    map['current_week'] = currentWeek;
    map['current_day'] = currentDay;
    map['display_text'] = displayText;
    return map;
  }
}

class Readiness {
  num? score;
  String? title;
  String? subtitle;

  Readiness({this.score, this.title, this.subtitle});

  Readiness.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['score'] = score;
    map['title'] = title;
    map['subtitle'] = subtitle;
    return map;
  }
}

class WeekOverview {
  int? selectedWeek;
  int? daystreak;
  String? dateRange;
  String? startDate;
  String? endDate;
  List<OverviewDay>? days;

  WeekOverview({
    this.selectedWeek,
    this.daystreak,
    this.dateRange,
    this.startDate,
    this.endDate,
    this.days,
  });

  WeekOverview.fromJson(Map<String, dynamic> json) {
    selectedWeek = json['selected_week'];
    daystreak = json['daystreak'];
    dateRange = json['date_range'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['days'] != null) {
      days = <OverviewDay>[];
      json['days'].forEach((v) {
        days!.add(OverviewDay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['selected_week'] = selectedWeek;
    map['daystreak'] = daystreak;
    map['date_range'] = dateRange;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    if (days != null) map['days'] = days!.map((v) => v.toJson()).toList();
    return map;
  }
}

class OverviewDay {
  String? dayName;
  String? date;
  String? status;
  num? score;

  OverviewDay({this.dayName, this.date, this.status, this.score});

  OverviewDay.fromJson(Map<String, dynamic> json) {
    dayName = json['day_name'];
    date = json['date'];
    status = json['status'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['day_name'] = dayName;
    map['date'] = date;
    map['status'] = status;
    map['score'] = score;
    return map;
  }
}

class ChartData {
  String? dayShort;
  String? dayName;
  String? date;
  num? percentage;

  ChartData({this.dayShort, this.dayName, this.date, this.percentage});

  ChartData.fromJson(Map<String, dynamic> json) {
    dayShort = json['day_short'];
    dayName = json['day_name'];
    date = json['date'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['day_short'] = dayShort;
    map['day_name'] = dayName;
    map['date'] = date;
    map['percentage'] = percentage;
    return map;
  }
}

class AiWeeklyInsight {
  String? insight;

  AiWeeklyInsight({this.insight});

  AiWeeklyInsight.fromJson(Map<String, dynamic> json) {
    insight = json['insight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['insight'] = insight;
    return map;
  }
}

class AvailableWeeks {
  int? week;
  String? label;
  String? dateRange;
  bool? isCurrent;

  AvailableWeeks({this.week, this.label, this.dateRange, this.isCurrent});

  AvailableWeeks.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    label = json['label'];
    dateRange = json['date_range'];
    isCurrent = json['is_current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['week'] = week;
    map['label'] = label;
    map['date_range'] = dateRange;
    map['is_current'] = isCurrent;
    return map;
  }
}
