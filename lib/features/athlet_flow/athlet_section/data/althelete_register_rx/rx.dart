import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/notification/notification_service.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';

import 'api.dart';

final class AltheleteSignUpRx extends RxResponseInt<Map<String, dynamic>> {
  final api = AltheleteSignUpApi.instance;

  AltheleteSignUpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> altheleteSignUpInfo({

    required dynamic name,
    required dynamic email,
    required dynamic password,
    required dynamic termsAccepted,
    required dynamic confirmPassword,
    required dynamic timezone,

  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data =
      await api.altheleteSignUpApi( termsAccepted: termsAccepted, password: password,confirmPassword: confirmPassword,email: email, name: name, timezone: timezone,);

      String message = data['message'];
      log(">>>>>>>>>>>>>>> massage : $message");
      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    String? token = data['access_token'];

    if (token != null) {
      appData.write(kKeyAccessToken, token);
      appData.write(kKeyIsLoggedIn, true);
      // Update DioSingleton with the new token
      DioSingleton.instance.update(token);
      NotificationService.sendFcmTokenToServer();
    }

    if (data['data'] != null && data['data']['id'] != null) {
      appData.write(kKeyUserID, data['data']['id']);
    }

    // Add the data to the stream
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
            // Combine all error messages into a single string
            StringBuffer buffer = StringBuffer();
            errors.forEach((key, value) {
              if (value is List) {
                for (var msg in value) {
                  buffer.writeln(msg); // Add each error message
                }
              }
            });
            ToastUtil.showShortToast(buffer.toString());
          } else {
            ToastUtil.showShortToast("Something went wrong!");
          }
        } else {
          ToastUtil.showShortToast(error.response!.data["errors"] ?? "Unknown error");
        }
      } else {
        ToastUtil.showShortToast("No response data available");
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }

}
