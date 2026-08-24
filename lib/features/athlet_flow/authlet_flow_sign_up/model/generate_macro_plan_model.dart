class GenerateMacroPlanModel {
  final bool? success;
  final MacroPlanData? data;
  final String? message;

  GenerateMacroPlanModel({
    this.success,
    this.data,
    this.message,
  });

  factory GenerateMacroPlanModel.fromJson(Map<String, dynamic> json) {
    return GenerateMacroPlanModel(
      success: json['success'],
      data: json['data'] != null ? MacroPlanData.fromJson(json['data']) : null,
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

class MacroPlanData {
  final int? totalWeeks;
  final List<MacroPhaseModel>? phases;

  MacroPlanData({
    this.totalWeeks,
    this.phases,
  });

  factory MacroPlanData.fromJson(Map<String, dynamic> json) {
    return MacroPlanData(
      totalWeeks: json['total_weeks'],
      phases: json['phases'] != null
          ? (json['phases'] as List).map((x) => MacroPhaseModel.fromJson(x)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_weeks': totalWeeks,
      'phases': phases?.map((x) => x.toJson()).toList(),
    };
  }
}

class MacroPhaseModel {
  final String? name;
  final String? weeks;
  final String? description;

  MacroPhaseModel({
    this.name,
    this.weeks,
    this.description,
  });

  factory MacroPhaseModel.fromJson(Map<String, dynamic> json) {
    return MacroPhaseModel(
      name: json['name'],
      weeks: json['weeks'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weeks': weeks,
      'description': description,
    };
  }
}
