import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/data/athlete_weekly_progress_rx/api.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/model/athlete_weekly_progress_model.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class AthleteWeeklyProgressRx extends RxResponseInt<AthleteWeeklyProgressModel> {
  final api = AthleteWeeklyProgressApi.instance;

  AthleteWeeklyProgressRx({required super.empty, required super.dataFetcher});

  ValueStream<AthleteWeeklyProgressModel> get getWeeklyProgressStream => dataFetcher.stream;

  Future<AthleteWeeklyProgressModel?> getWeeklyProgress({int? week}) async {
    try {
      AthleteWeeklyProgressModel data = await api.getWeeklyProgressApi(week: week);
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<AthleteWeeklyProgressModel> handleSuccessWithReturn(
      AthleteWeeklyProgressModel data) async {
    log("Athlete Weekly Progress Response Message: ${data.message}");
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  Future<AthleteWeeklyProgressModel?> handleErrorWithReturn(dynamic error) async {
    String errorMessage = 'Failed to load weekly progress';

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
    log("Athlete Weekly Progress Error: $error");
    dataFetcher.sink.addError(error);
    return null;
  }
}
