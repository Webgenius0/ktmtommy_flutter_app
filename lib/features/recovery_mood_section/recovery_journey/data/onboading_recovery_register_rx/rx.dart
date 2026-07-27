import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/notification/notification_service.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';

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
    required dynamic currentRecoveryStage,
    required List<Map<String, dynamic>> physicalSymptoms,
    required dynamic emotionalSymptoms,
    required dynamic recoveryGoal,
    required dynamic recoveryGoalTime,
    required dynamic progressTimeline,


  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data =
      await api.onboardingRecoverySignUpApi(
        currentRecoveryStage: currentRecoveryStage,
        emotionalSymptoms: emotionalSymptoms,
        injuryDate: injuryDate,
        injuryLevel: injuryLevel,
        injuryName: injuryName,
        physicalSymptoms: physicalSymptoms,
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
    String? token = data['access_token'];

    if (token != null) {
      appData.write(kKeyAccessToken, token);
      appData.write(kKeyIsLoggedIn, true);
      // Update DioSingleton with the new token
      DioSingleton.instance.update(token);
      NotificationService.sendFcmTokenToServer();
    }

    final userData = data['data'] ?? data['user'] ?? data;
    if (userData is Map<String, dynamic>) {
      if (userData['id'] != null) {
        appData.write(kKeyUserID, userData['id']);
      }
      final name = userData['name'] ?? userData['full_name'];
      if (name != null) {
        appData.write(kKeyuserFullName, name.toString());
      }
      final goal = userData['recovery_goal'] ?? userData['goal'];
      if (goal != null) {
        appData.write(kKRecoveryGoal, goal.toString());
      }
      final reminderFrom = userData['reminder_from'] ?? userData['reminder_start_time'];
      if (reminderFrom != null) {
        appData.write(kKeyuserReminderStartTime, reminderFrom.toString());
      }
      final reminderTo = userData['reminder_to'] ?? userData['reminder_end_time'];
      if (reminderTo != null) {
        appData.write(kKeyuserReminderEndTime, reminderTo.toString());
      }
    }

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
