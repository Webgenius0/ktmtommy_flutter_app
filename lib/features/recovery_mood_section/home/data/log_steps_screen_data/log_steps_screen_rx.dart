import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/data/log_steps_screen_data/log_steps_screen_api.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class LogStepsScreenRx extends RxResponseInt<Map<String, dynamic>> {
  final api = LogStepsScreenApi.instance;

  LogStepsScreenRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> storeStepsPostApi({
    required String activity,
    required dynamic hours,
    required dynamic minutes,

  }) async {
    try {
      log("=====>>>>activity:$activity");
      log("=====>>>>hours:$hours");
      log("=====>>>>minutes:$minutes");
      Map<String, dynamic> data = await api.storeStepsApi(
        activity: activity,
        hours: hours,
        minutes: minutes,

      );

      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<bool> handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      dataFetcher.sink.add(data);
      return true;
    } catch (e) {
      log("========>>>>>>>>Failed to process data. Please try again.");
      return false;
    }
  }

  @override
  bool handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(
            error.response?.data["message"] ?? "Invalid request");
      } else {
        ToastUtil.showShortToast("An unexpected error occurred");
      }
    } else {
      ToastUtil.showShortToast("Something went wrong");
    }
    log('Error: $error');
    dataFetcher.sink.addError(error);
    return false;
  }
}