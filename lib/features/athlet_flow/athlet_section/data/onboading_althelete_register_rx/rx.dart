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

  Future<bool> onboardingAthleteSignUpApiInfo({

    required String userMode,
    required String age,
    required dynamic gender,
    required dynamic experienceLevel,
    required dynamic goal,
    required dynamic sport,
    required dynamic height,
    required dynamic heightUnit,
    required dynamic weight,
    required dynamic weightUnit,
    required dynamic reminderTo,
    required dynamic reminderFrom,

  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data =
      await api.onboardingAthleteSignUpApi(
        weight: weight,
        height: height,
        age: age,
        experienceLevel: experienceLevel,
        gender: gender,
        goal: goal,
        heightUnit: heightUnit,
        reminderFrom: reminderFrom,
        reminderTo: reminderTo,
        sport: sport,
        userMode: userMode,
        weightUnit: weightUnit
      );

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
