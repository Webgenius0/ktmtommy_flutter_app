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

  factory AllMedicationModel.fromRawJson(String str) => AllMedicationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllMedicationModel.fromJson(Map<String, dynamic> json) => AllMedicationModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  int? id;
  int? userId;
  String? name;
  int? dosage;
  String? dosageUnit;
  bool? isPrescribed;
  DateTime? takenAt;
  bool? uprightPosture;
  bool? waterIntake;
  int? glassOfWater;
  String? notes;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.name,
    this.dosage,
    this.dosageUnit,
    this.isPrescribed,
    this.takenAt,
    this.uprightPosture,
    this.waterIntake,
    this.glassOfWater,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    dosage: json["dosage"],
    dosageUnit: json["dosage_unit"],
    isPrescribed: json["is_prescribed"],
    takenAt: json["taken_at"] == null ? null : DateTime.parse(json["taken_at"]),
    uprightPosture: json["upright_posture"],
    waterIntake: json["water_intake"],
    glassOfWater: json["glass_of_water"],
    notes: json["notes"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "dosage": dosage,
    "dosage_unit": dosageUnit,
    "is_prescribed": isPrescribed,
    "taken_at": takenAt?.toIso8601String(),
    "upright_posture": uprightPosture,
    "water_intake": waterIntake,
    "glass_of_water": glassOfWater,
    "notes": notes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
