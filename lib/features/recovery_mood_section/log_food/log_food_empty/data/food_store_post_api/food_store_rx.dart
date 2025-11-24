import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/data/food_store_post_api/food_store_api.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class FoodStoreRx extends RxResponseInt<Map<String, dynamic>> {
  final FoodStoreApi _api = FoodStoreApi.instance;

  FoodStoreRx({required super.empty, required super.dataFetcher});


  ValueStream<Map<String, dynamic>> get responseStream => dataFetcher.stream;

  Future<bool> saveFoodRecord({
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
      final result = await _api.saveFoodRecord(
        image: image,
        food_name: food_name,
        total_estimated_calories: total_estimated_calories,
        carbs_percentage: carbs_percentage,
        carbs_in_gm: carbs_in_gm,
        protein_percentage: protein_percentage,
        protein_in_gm: protein_in_gm,
        fat_percentage: fat_percentage,
        fat_in_gm: fat_in_gm,
        protein: protein,
        total_carbs: total_carbs,
        fiber: fiber,
        sugar: sugar,
        total_fat: total_fat,
        saturated: saturated,
        sodium: sodium,
        potassium: potassium,
        ingredient_breakdown: ingredient_breakdown,
        nutritional_insights: nutritional_insights,
        notes: notes,
        taken_at: taken_at,
      );

      if (result['success'] == true) {
        final data = Map<String, dynamic>.from(result['data']);
        dataFetcher.sink.add(data);
        return true;
      } else {
        throw Exception(result['message'] ?? "Save failed");
      }
    } catch (e) {
      log("FoodStoreRx Error: $e");
      _handleError(e);
      return false;
    }
  }

  void _handleError(dynamic error) {
    String msg = "The image field must not be greater than 5120 kilobytes";

    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map) {
        msg = data['message'] ?? data['error'] ?? msg;
      } else if (data is String) {
        msg = data;
      }
    }

    ToastUtil.showShortToast(msg);
    dataFetcher.sink.addError(error);
  }

  @override
  void handleSuccessWithReturn(Map<String, dynamic> data) {
    dataFetcher.sink.add(data);
  }

  @override
  Future<bool> handleErrorWithReturn(dynamic error) async {
    _handleError(error);
    return false;
  }

  void dispose() => dataFetcher.close();
}