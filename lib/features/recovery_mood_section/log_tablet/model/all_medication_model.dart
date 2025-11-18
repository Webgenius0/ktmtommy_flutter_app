import 'dart:convert';

class AllMedicationModel {
  bool? success;
  List<Datum>? data;
  String? message;

  AllMedicationModel({
    this.success,
    this.data,
    this.message,
  });

  factory AllMedicationModel.fromRawJson(String str) =>
      AllMedicationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllMedicationModel.fromJson(Map<String, dynamic> json) =>
      AllMedicationModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int? id;
  int? userId;
  String? name;
  int? dosage;
  String? dosageUnit;
  String? takenAt;

  Datum({
    this.id,
    this.userId,
    this.name,
    this.dosage,
    this.dosageUnit,
    this.takenAt,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        dosage: json["dosage"],
        dosageUnit: json["dosage_unit"],
        takenAt: json["taken_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "dosage": dosage,
        "dosage_unit": dosageUnit,
        "taken_at": takenAt,
      };
}
