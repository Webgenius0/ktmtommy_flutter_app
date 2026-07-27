import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/model/daily_food_summary_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class DailyFoodSummaryApi {
  static final DailyFoodSummaryApi _singleton = DailyFoodSummaryApi._internal();
  DailyFoodSummaryApi._internal();

  static DailyFoodSummaryApi get instance => _singleton;

  Future<DailyFoodSummaryModel> getDailyFoodSummary(String date) async {
    try {
      Response response = await getHttp(
        Endpoints.getFoodDailySummaryApi(date),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data =
        json.decode(json.encode(response.data));

        return DailyFoodSummaryModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
