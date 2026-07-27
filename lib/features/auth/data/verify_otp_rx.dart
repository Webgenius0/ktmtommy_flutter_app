import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/notification/notification_service.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';
import 'verify_otp_api.dart';

final class VerifyOtpRx extends RxResponseInt<Map<String, dynamic>> {
  final api = VerifyOtpApi.instance;

  VerifyOtpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> verifyOtp({
    required String email,
    required String otp,
    required String otpType,
  }) async {
    try {
      Map<String, dynamic> data = await api.verifyOtpApi(
        email: email,
        otp: otp,
        otpType: otpType,
      );

      String? token = data['access_token'];
      if (token != null) {
        appData.write(kKeyAccessToken, token);
        appData.write(kKeyIsLoggedIn, true);
        DioSingleton.instance.update(token);
        NotificationService.sendFcmTokenToServer();
      }

      if (data['data'] != null && data['data']['id'] != null) {
        appData.write(kKeyUserID, data['data']['id']);
      }

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
        if (error.response!.statusCode == 422) {
          var errors = error.response!.data["errors"];
          if (errors is Map<String, dynamic>) {
            StringBuffer buffer = StringBuffer();
            errors.forEach((key, value) {
              if (value is List) {
                for (var msg in value) {
                  buffer.writeln(msg);
                }
              }
            });
            ToastUtil.showShortToast(buffer.toString());
          } else {
            ToastUtil.showShortToast(error.response!.data["message"] ?? "Something went wrong!");
          }
        } else {
          ToastUtil.showShortToast(error.response!.data["message"] ?? "Unknown error");
        }
      } else {
        ToastUtil.showShortToast("No response data available");
      }
    } else {
      ToastUtil.showShortToast(error.toString());
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}
