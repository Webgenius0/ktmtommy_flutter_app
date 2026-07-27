class PrescribedMedicineDetailsModel {
  final bool? success;
  final PrescribedMedicineDetailsData? data;
  final String? message;

  PrescribedMedicineDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory PrescribedMedicineDetailsModel.fromJson(Map<String, dynamic> json) {
    return PrescribedMedicineDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? PrescribedMedicineDetailsData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }
}

class PrescribedMedicineDetailsData {
  final int? id;
  final int? userId;
  final String? medicineName;
  final String? dosage;
  final String? dosageType;
  final String? medicineType;
  final List<String>? takingTimes;
  final String? startDate;
  final String? endDate;
  final bool? beforeMeal;
  final bool? notification;
  final int? notifyBefore;
  final String? doctorNote;

  PrescribedMedicineDetailsData({
    this.id,
    this.userId,
    this.medicineName,
    this.dosage,
    this.dosageType,
    this.medicineType,
    this.takingTimes,
    this.startDate,
    this.endDate,
    this.beforeMeal,
    this.notification,
    this.notifyBefore,
    this.doctorNote,
  });

  factory PrescribedMedicineDetailsData.fromJson(Map<String, dynamic> json) {
    return PrescribedMedicineDetailsData(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      medicineName: json['medicine_name'] as String?,
      dosage: json['dosage'] as String?,
      dosageType: json['dosage_type'] as String?,
      medicineType: json['medicine_type'] as String?,
      takingTimes: (json['taking_times'] as List?)?.map((e) => e as String).toList(),
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      beforeMeal: json['before_meal'] as bool?,
      notification: json['notification'] as bool?,
      notifyBefore: json['notify_before'] as int?,
      doctorNote: json['doctor_note'] as String?,
    );
  }
}
