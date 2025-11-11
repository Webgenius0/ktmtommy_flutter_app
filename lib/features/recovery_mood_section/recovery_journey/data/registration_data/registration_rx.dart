import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/data/registration_data/registration_api.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class RecoveryRegistrationApiRx extends RxResponseInt<Map<dynamic, dynamic>> {
  final api = RecoveryRegistrationApi.instance;

  RecoveryRegistrationApiRx({required super.empty, required super.dataFetcher});

  ValueStream<Map<dynamic, dynamic>> get registrationData => dataFetcher.stream;

  ///=================== Call the Recovery Register API ===================///
  Future<bool> registerRecoveryUserApi({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String password_confirmation,
    required dynamic age,
    required String gender,
    required String user_mode,
    required bool terms_accepted,
    required String injury_name,
    required String injury_level,
    required String injury_date,
    required String current_recovery_stage,
    required dynamic physical_symptom,
    required String physical_symptom_details,
    required dynamic physical_symptom_duration,
    required dynamic physical_symptom_frequency,
    required String emotional_symptoms,
    required String recovery_goal,
    required String recovery_goal_time,
    required String progress_timeline,
    required String recovery_target_date,
    required String reminder_from,
    required String reminder_to,
  }) async {
    try {
      Map<dynamic, dynamic> data = await api.registerUserApi(
        name: name,
        email: email,
        phone: phone,
        password: password,
        password_confirmation: password_confirmation,
        age: age,
        gender: gender,
        user_mode: user_mode,
        terms_accepted: terms_accepted,
        injury_name: injury_name,
        injury_level: injury_level,
        injury_date: injury_date,
        current_recovery_stage: current_recovery_stage,
        physical_symptom: physical_symptom,
        physical_symptom_details: physical_symptom_details,
        physical_symptom_duration: physical_symptom_duration,
        physical_symptom_frequency: physical_symptom_frequency,
        emotional_symptoms: emotional_symptoms,
        recovery_goal: recovery_goal,
        recovery_goal_time: recovery_goal_time,
        progress_timeline: progress_timeline,
        recovery_target_date: recovery_target_date,
        reminder_from: reminder_from,
        reminder_to: reminder_to,
      );

      await handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<Map<dynamic, dynamic>> handleSuccessWithReturn(Map<dynamic, dynamic> data) async {
    log("====================== Recovery Registration Successful ✅");
    log("Response Message: ${data['message']}");
    dataFetcher.sink.add(data);
    return data;
  }

  ///====================== Handle API Error ========================///
  @override
  Future<bool> handleErrorWithReturn(dynamic error) async {
    String errorMessage = 'An error occurred during recovery registration';

    if (error is DioException) {
      if (error.response != null) {
        log("Error Response Status Code: ${error.response!.statusCode}");
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






