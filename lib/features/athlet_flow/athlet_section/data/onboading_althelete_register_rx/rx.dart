import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';

import 'api.dart';

final class OnboardingAthleteSignUpRx extends RxResponseInt<Map<String, dynamic>> {
  final api = OnboardingAthleteSignUpApi.instance;

  OnboardingAthleteSignUpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> onboardingAthleteSignUpApiInfo(Map<String, dynamic> payload) async {
    try {
      Map<String, dynamic> data = await api.onboardingAthleteSignUpApi(payload);

      String message = data['message'] ?? 'Success';
      log(">>>>>>>>>>>>>>> message : $message");
      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {


    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        var responseData = error.response!.data;
        if (error.response!.statusCode == 422) {
          var errors = responseData is Map ? responseData["errors"] : null;
          String? message = responseData is Map ? responseData["message"] : null;

          if (errors is Map<String, dynamic> && errors.isNotEmpty) {
            StringBuffer buffer = StringBuffer();
            errors.forEach((key, value) {
              if (value is List) {
                for (var msg in value) {
                  buffer.writeln(msg);
                }
              } else if (value is String) {
                buffer.writeln(value);
              }
            });
            ToastUtil.showShortToast(buffer.toString().trim());
          } else if (message != null && message.isNotEmpty) {
            ToastUtil.showShortToast(message);
          } else {
            ToastUtil.showShortToast("Validation Error");
          }
        } else {
          String? msg = responseData is Map ? (responseData["message"] ?? responseData["errors"]?.toString()) : null;
          ToastUtil.showShortToast(msg ?? "Server error occurred (${error.response!.statusCode})");
        }
      } else {
        ToastUtil.showShortToast("No response data available from server");
      }
    } else {
      ToastUtil.showShortToast(error.toString());
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }

}
