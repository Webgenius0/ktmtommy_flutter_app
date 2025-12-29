import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';

import 'api.dart';

final class OnboardingRecoverySignUpRx extends RxResponseInt<Map<String, dynamic>> {
  final api = OnboardingRecoverySignUpApi.instance;

  OnboardingRecoverySignUpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> onboardingRecoverySignUpApiInfo({

    required dynamic userMode,
    required dynamic age,
    required dynamic gender,
    required dynamic recoveryTargetDate,
    required dynamic reminderTo,
    required dynamic reminderFrom,
    required dynamic injuryName,
    required dynamic injuryLevel,
    required dynamic injuryDate,
    required dynamic currentRecoverySage,
    required dynamic physicalSymptom,
    required dynamic physicalSymptomDetails,
    required dynamic physicalSymptomDurationHour,
    required dynamic physicalSymptomFrequency,
    required dynamic emotionalSymptoms,
    required dynamic recoveryGoal,
    required dynamic recoveryGoalTime,
    required dynamic progressTimeline,


  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data =
      await api.onboardingRecoverySignUpApi(
       currentRecoverySage: currentRecoverySage,
        emotionalSymptoms: emotionalSymptoms,
        injuryDate: injuryDate,
        injuryLevel: injuryLevel,
        injuryName: injuryName,
        physicalSymptom: physicalSymptom,
        physicalSymptomDetails: physicalSymptomDetails,
        physicalSymptomDurationHour: physicalSymptomDurationHour,
        physicalSymptomFrequency: physicalSymptomFrequency,
        progressTimeline: progressTimeline,
        recoveryGoal: recoveryGoal,
        recoveryGoalTime: recoveryGoalTime,
        age: age,
        gender: gender,
        recoveryTargetDate: recoveryTargetDate,
        reminderFrom: reminderFrom,
        reminderTo: reminderTo,
        userMode: userMode,
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
