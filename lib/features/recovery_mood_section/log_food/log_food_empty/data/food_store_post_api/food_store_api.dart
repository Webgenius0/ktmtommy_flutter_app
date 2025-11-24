import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class FoodStoreApi {
  FoodStoreApi._internal();
  static final FoodStoreApi _instance = FoodStoreApi._internal();
  static FoodStoreApi get instance => _instance;

  Future<Map<String, dynamic>> saveFoodRecord({
    required File image,
    required String food_name,
    required dynamic total_estimated_calories,
    required dynamic carbs_percentage,
    required dynamic carbs_in_gm,
    required dynamic protein_percentage,
    required dynamic protein_in_gm,
    required dynamic fat_percentage,
    required dynamic fat_in_gm,
    required dynamic protein,
    required dynamic total_carbs,
    required dynamic fiber,
    required dynamic sugar,
    required dynamic total_fat,
    required dynamic saturated,
    required dynamic sodium,
    required dynamic potassium,
    required dynamic ingredient_breakdown,
    required dynamic nutritional_insights,
    required dynamic notes,
    required dynamic taken_at,
  }) async {
    try {
      final multipartImage = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );

      final formData = FormData.fromMap({
        "image": multipartImage,
        "food_name": food_name,
        "total_estimated_calories": total_estimated_calories,
        "carbs_percentage": carbs_percentage,
        "carbs_in_gm": carbs_in_gm,
        "protein_percentage": protein_percentage,
        "protein_in_gm": protein_in_gm,
        "fat_percentage": fat_percentage,
        "fat_in_gm": fat_in_gm,
        "protein": protein,
        "total_carbs": total_carbs,
        "fiber": fiber,
        "sugar": sugar,
        "total_fat": total_fat,
        "saturated": saturated,
        "sodium": sodium,
        "potassium": potassium,
        "ingredient_breakdown": ingredient_breakdown,
        "nutritional_insights": nutritional_insights,
        "notes": notes,
        "taken_at": taken_at,
      });

      final response = await postHttp(Endpoints.postFoodStoreApi(), formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data is Map<String, dynamic>
            ? response.data
            : Map<String, dynamic>.from(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException catch (de) {
      throw DataSource.DEFAULT.getFailure();
    } catch (e) {
      rethrow;
    }
  }
}