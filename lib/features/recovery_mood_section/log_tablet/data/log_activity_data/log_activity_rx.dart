import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/log_activity_data/log_activity_api.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class LogActivityRx extends RxResponseInt<Map<String, dynamic>> {
  final api = LogActivityApi.instance;

  LogActivityRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> storeActivityPostApi({
    required String name,
    required dynamic date,
    required dynamic time,
    required dynamic duration_minutes,
    required dynamic notify_before_minutes,
    required String notes,
  }) async {
    try {
      log("=====>>>>name:$name");
      log("=====>>>>date:$date");
      log("=====>>>>duration_minutes:$duration_minutes");
      log("=====>>>>notes:$notes");
      log("=====>>>>notify_before_minutes:$notify_before_minutes");
      log("=====>>>>time:$time");

      Map<String, dynamic> data = await api.storeActivityApi(
        name: name,
        date: date,
        duration_minutes: duration_minutes,
        notes: notes,
        notify_before_minutes: notify_before_minutes,
        time: time,
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
