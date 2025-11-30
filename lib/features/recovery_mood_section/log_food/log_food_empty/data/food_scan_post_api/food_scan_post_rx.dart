import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/data/food_scan_post_api/food_scan_post_api.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class FoodScanPostRx extends RxResponseInt<Map<String, dynamic>> {
  final api = FoodScanPostApi.instance;

  FoodScanPostRx({required super.empty, required super.dataFetcher});

  ValueStream get foodScanData => dataFetcher.stream;

  Future<bool> postFoodScanApi({required File image}) async {
    try {
      final response = await api.foodScanApi(image: image);
      await _saveFoodScanDataToStorage(response);
      return true;
    } catch (error) {
      return await _handleError(error);
    }
  }

  // ==================== SUCCESS: All Data Save ====================
  Future<void> _saveFoodScanDataToStorage(Map<String, dynamic> response) async {
    log("====================================== Food scan successful");
    log("Full Response: ${response.toString()}");

    final data = response['data'] as Map<String, dynamic>;

    // Main flags
    appData.write(kKeyIsFood, data['is_food'] ?? 'no');

    // Macronutrition Distribution
    final macro = data['macronutrition_distribution'] as Map<String, dynamic>;
    appData.write(kKeyFoodName, macro['food_name'] ?? '');
    appData.write(kKeyTotalCalories, macro['total_estimated_calories'] ?? 0);

    appData.write(kKeyCarbsPercentage, macro['carbs_percentage'] ?? '0%');
    appData.write(kKeyCarbsInGm, macro['carbs_in_gm'] ?? '0g');
    appData.write(kKeyProteinPercentage, macro['protein_percentage'] ?? '0%');
    appData.write(kKeyProteinInGm, macro['protein_in_gm'] ?? '0g');
    appData.write(kKeyFatPercentage, macro['fat_percentage'] ?? '0%');
    appData.write(kKeyFatInGm, macro['fat_in_gm'] ?? '0g');

    // Nutrition Facts
    final nutrition = data['nutrition_facts'] as Map<String, dynamic>;
    appData.write(kKeyProtein, nutrition['protein'] ?? '0g');
    appData.write(kKeyTotalCarbs, nutrition['total_carbs'] ?? '0g');
    appData.write(kKeyFiber, nutrition['fiber'] ?? '0g');
    appData.write(kKeySugar, nutrition['sugar'] ?? '0g');
    appData.write(kKeyTotalFat, nutrition['total_fat'] ?? '0g');
    appData.write(kKeySaturated, nutrition['saturated'] ?? '0g');
    appData.write(kKeySodium, nutrition['sodium'] ?? '0mg');
    appData.write(kKeyPotassium, nutrition['potassium'] ?? '0mg');

    // Ingredient Breakdown ( last key name)
    final ingredients = data['ingredient_breakdown'] as Map<String, dynamic>;
    appData.write(kKeyBun, ingredients['bun'] ?? '0');
    appData.write(kKeyBeefPatties, ingredients['beef patties'] ?? '0');
    appData.write(kKeyCheese, ingredients['cheese'] ?? '0');
    appData.write(kKeyLettuce, ingredients['lettuce'] ?? '0');
    appData.write(kKeyTomato, ingredients['tomato'] ?? '0');
    appData.write(kKeyPickles, ingredients['pickles'] ?? '0');
    appData.write(kKeyOnion, ingredients['onion'] ?? '0');
    appData.write(kKeySauce, ingredients['sauce'] ?? '0');

    // Insights +
    appData.write(kKeyNutritionalInsights, data['nutritional_insights'] ?? []);
    appData.write(kKeyLastFoodScanResponse, response);

    dataFetcher.sink.add(response);


    _printAllSavedData();
    log("All food scan data saved to GetStorage!");
  }

  // ==================== all data ====================
  void _printAllSavedData() {
    log('============= FOOD SCAN RESULT =============');
    log('Is Food          : ${appData.read(kKeyIsFood)}');
    log('Food Name        : ${appData.read(kKeyFoodName)}');
    log('Calories         : ${appData.read(kKeyTotalCalories)} kcal');
    log('Carbs            : ${appData.read(kKeyCarbsInGm)} (${appData.read(kKeyCarbsPercentage)})');
    log('Protein          : ${appData.read(kKeyProteinInGm)} (${appData.read(kKeyProteinPercentage)})');
    log('Fat              : ${appData.read(kKeyFatInGm)} (${appData.read(kKeyFatPercentage)})');
    log('Total Carbs      : ${appData.read(kKeyTotalCarbs)}');
    log('Fiber            : ${appData.read(kKeyFiber)}');
    log('Sugar            : ${appData.read(kKeySugar)}');
    log('Total Fat        : ${appData.read(kKeyTotalFat)}');
    log('Saturated Fat    : ${appData.read(kKeySaturated)}');
    log('Sodium           : ${appData.read(kKeySodium)}');
    log('Bun              : ${appData.read(kKeyBun)}');
    log('Beef Patties     : ${appData.read(kKeyBeefPatties)}');
    log('Cheese           : ${appData.read(kKeyCheese)}');
    log('Lettuce          : ${appData.read(kKeyLettuce)}');
    log('Tomato           : ${appData.read(kKeyTomato)}');
    log('Pickles          : ${appData.read(kKeyPickles)}');
    log('Onion            : ${appData.read(kKeyOnion)}');
    log('Sauce            : ${appData.read(kKeySauce)}');
    log('Insights         : ${appData.read(kKeyNutritionalInsights)}');
    log('=============================================');
  }

  // ==================== ERROR HANDLING ====================
  Future<bool> _handleError(dynamic error) async {
    String message = "Unknown error occurred";

    if (error is DioException) {
      message = error.response?.data?["message"] ?? error.message ?? message;
    }

    ToastUtil.showShortToast(message);
    log("Food Scan Error: $error");
    dataFetcher.sink.addError(error);
    return false;
  }
}