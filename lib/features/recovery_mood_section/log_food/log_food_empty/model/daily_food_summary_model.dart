import 'dart:convert';

class DailyFoodSummaryModel {
  bool? success;
  DailyFoodSummaryData? data;
  String? message;

  DailyFoodSummaryModel({
    this.success,
    this.data,
    this.message,
  });

  factory DailyFoodSummaryModel.fromRawJson(String str) => DailyFoodSummaryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DailyFoodSummaryModel.fromJson(Map<String, dynamic> json) => DailyFoodSummaryModel(
    success: json["success"],
    data: json["data"] == null ? null : DailyFoodSummaryData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class DailyFoodSummaryData {
  String? date;
  dynamic totalCalories;
  dynamic itemsLogged;
  List<FoodItem>? foods;

  DailyFoodSummaryData({
    this.date,
    this.totalCalories,
    this.itemsLogged,
    this.foods,
  });

  factory DailyFoodSummaryData.fromJson(Map<String, dynamic> json) => DailyFoodSummaryData(
    date: json["date"],
    totalCalories: json["total_calories"],
    itemsLogged: json["items_logged"],
    foods: json["foods"] == null ? [] : List<FoodItem>.from(json["foods"]!.map((x) => FoodItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "total_calories": totalCalories,
    "items_logged": itemsLogged,
    "foods": foods == null ? [] : List<dynamic>.from(foods!.map((x) => x.toJson())),
  };
}

class FoodItem {
  int? id;
  String? foodName;
  String? mealType;
  String? imageUrl;
  String? time;
  dynamic totalEstimatedCalories;

  FoodItem({
    this.id,
    this.foodName,
    this.mealType,
    this.imageUrl,
    this.time,
    this.totalEstimatedCalories,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
    id: json["id"],
    foodName: json["food_name"],
    mealType: json["meal_type"],
    imageUrl: json["image_url"],
    time: json["time"],
    totalEstimatedCalories: json["total_estimated_calories"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "food_name": foodName,
    "meal_type": mealType,
    "image_url": imageUrl,
    "time": time,
    "total_estimated_calories": totalEstimatedCalories,
  };
}
