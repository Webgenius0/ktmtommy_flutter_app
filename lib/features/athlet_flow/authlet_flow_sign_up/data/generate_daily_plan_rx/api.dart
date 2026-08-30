import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/model/generate_daily_plan_model.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class GenerateDailyPlanApi {
  static final GenerateDailyPlanApi _singleton =
      GenerateDailyPlanApi._internal();

  GenerateDailyPlanApi._internal();

  static GenerateDailyPlanApi get instance => _singleton;

  Future<GenerateDailyPlanModel> generateDailyPlanApi({
    required String date,
    String? sleepQuality,
    String? energyLevel,
    String? recoveryFeeling,
    String? overallFeeling,
  }) async {
    try {
      final Map<String, dynamic> data = {'date': date};
      if (sleepQuality != null) data['sleep_quality'] = sleepQuality;
      if (energyLevel != null) data['energy_level'] = energyLevel;
      if (recoveryFeeling != null) data['recovery_feeling'] = recoveryFeeling;
      if (overallFeeling != null) data['overall_feeling'] = overallFeeling;

      Response response =
          await postHttp(Endpoints.generateDailyPlanApiLink(), data);

      log("Generate Daily Plan API Response Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data is String
            ? json.decode(response.data)
            : Map<String, dynamic>.from(response.data);
        return GenerateDailyPlanModel.fromJson(responseData);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error during generate daily plan API call: $error");
      rethrow;
    }
  }
}
