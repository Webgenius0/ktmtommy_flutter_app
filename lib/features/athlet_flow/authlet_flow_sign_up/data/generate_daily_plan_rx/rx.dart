import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/data/generate_daily_plan_rx/api.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/model/generate_daily_plan_model.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class GenerateDailyPlanRx extends RxResponseInt<GenerateDailyPlanModel> {
  final api = GenerateDailyPlanApi.instance;

  GenerateDailyPlanRx({required super.empty, required super.dataFetcher});

  ValueStream<GenerateDailyPlanModel> get getDailyPlanStream =>
      dataFetcher.stream;

  Future<bool> generateDailyPlan({
    required String date,
    String? sleepQuality,
    String? energyLevel,
    String? recoveryFeeling,
    String? overallFeeling,
  }) async {
    try {
      GenerateDailyPlanModel data = await api.generateDailyPlanApi(
        date: date,
        sleepQuality: sleepQuality,
        energyLevel: energyLevel,
        recoveryFeeling: recoveryFeeling,
        overallFeeling: overallFeeling,
      );

      await handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<GenerateDailyPlanModel> handleSuccessWithReturn(
      GenerateDailyPlanModel data) async {
    log("Generate Daily Plan Response Message: ${data.message}");
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  Future<bool> handleErrorWithReturn(dynamic error) async {
    String errorMessage = 'Failed to generate today\'s plan';

    if (error is DioException) {
      if (error.response != null) {
        log("Error Response Status Code: ${error.response!.statusCode}");
        log("Error Response Data: ${error.response!.data}");
        final responseData = error.response!.data is String
            ? json.decode(error.response!.data)
            : (error.response!.data as Map<dynamic, dynamic>);

        errorMessage = responseData["message"] ?? errorMessage;
      } else {
        errorMessage = error.message ?? errorMessage;
      }
    } else {
      errorMessage = error.toString();
    }

    ToastUtil.showShortToast(errorMessage);
    log("Generate Daily Plan Error: $error");
    dataFetcher.sink.addError(error);
    return false;
  }
}
