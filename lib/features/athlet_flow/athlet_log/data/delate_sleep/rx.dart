import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/data/delate_sleep/api.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/data/save_sleep/api.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/data/athelete_auth_register_data/athlete_auth_register_api.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class DeleteSleepRx extends RxResponseInt<Map<dynamic, dynamic>> {
  final api = DeleteSleepApi.instance;

  DeleteSleepRx({required super.empty, required super.dataFetcher});

  ValueStream<Map<dynamic, dynamic>> get registrationData => dataFetcher.stream;

  ///=================== Call the Recovery Register API ===================///
  Future<bool> deleteSleepApiInfo({
    required dynamic id,
  }) async {
    try {


      Map<dynamic, dynamic> data = await api.deleteSleepApi(id: id);

      await handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<Map<dynamic, dynamic>> handleSuccessWithReturn(Map<dynamic, dynamic> data) async {

    log("Response Message: ${data['message']}");
    dataFetcher.sink.add(data);
    return data;
  }

  ///====================== Handle API Error ========================///
  @override
  Future<bool> handleErrorWithReturn(dynamic error) async {
    String errorMessage = 'An error occurred during delete';

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
    log("Recovery Registration Error: $error");
    dataFetcher.sink.addError(error);
    return false;
  }
}