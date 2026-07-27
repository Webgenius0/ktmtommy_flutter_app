class PrescribedMedicineModel {
  final bool? success;
  final List<PrescribedMedicineData>? data;
  final String? message;

  PrescribedMedicineModel({
    this.success,
    this.data,
    this.message,
  });

  factory PrescribedMedicineModel.fromJson(Map<String, dynamic> json) {
    return PrescribedMedicineModel(
      success: json['success'] as bool?,
      data: (json['data'] as List?)
          ?.map((e) => PrescribedMedicineData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );
  }
}

class PrescribedMedicineData {
  final int? id;
  final String? medicineName;
  final String? dosage;
  final String? dosageType;
  final String? medicineType;
  final int? numberOfTakingTimes;

  PrescribedMedicineData({
    this.id,
    this.medicineName,
    this.dosage,
    this.dosageType,
    this.medicineType,
    this.numberOfTakingTimes,
  });

  factory PrescribedMedicineData.fromJson(Map<String, dynamic> json) {
    return PrescribedMedicineData(
      id: json['id'] as int?,
      medicineName: json['medicine_name'] as String?,
      dosage: json['dosage'] as String?,
      dosageType: json['dosage_type'] as String?,
      medicineType: json['medicine_type'] as String?,
      numberOfTakingTimes: json['number_of_taking_times'] as int?,
    );
  }
}
