import 'dart:convert';

class GetAllFoodModel {
  bool? success;
  List<Datum>? data;
  String? message;

  GetAllFoodModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetAllFoodModel.fromRawJson(String str) => GetAllFoodModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllFoodModel.fromJson(Map<String, dynamic> json) => GetAllFoodModel(
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
  String? foodName;
  String? imageUrl;
  String? takenAt;
  String? takenAgo;
  int? totalEstimatedCalories;

  Datum({
    this.id,
    this.foodName,
    this.imageUrl,
    this.takenAt,
    this.takenAgo,
    this.totalEstimatedCalories,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    foodName: json["food_name"],
    imageUrl: json["image_url"],
    takenAt: json["taken_at"],
    takenAgo: json["taken_ago"],
    totalEstimatedCalories: json["total_estimated_calories"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "food_name": foodName,
    "image_url": imageUrl,
    "taken_at": takenAt,
    "taken_ago": takenAgo,
    "total_estimated_calories": totalEstimatedCalories,
  };
}
