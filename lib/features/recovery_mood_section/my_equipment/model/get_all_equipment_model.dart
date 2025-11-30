import 'dart:convert';

class GetAllEquipmentModel {
  bool? success;
  List<Datum>? data;
  String? message;

  GetAllEquipmentModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetAllEquipmentModel.fromRawJson(String str) => GetAllEquipmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllEquipmentModel.fromJson(Map<String, dynamic> json) => GetAllEquipmentModel(
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
  String? type;
  String? note;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  Datum({
    this.id,
    this.userId,
    this.name,
    this.type,
    this.note,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    type: json["type"],
    note: json["note"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "type": type,
    "note": note,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image_url": imageUrl,
  };
}
