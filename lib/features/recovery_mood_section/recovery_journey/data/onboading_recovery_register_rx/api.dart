import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class OnboardingRecoverySignUpApi {
  static final OnboardingRecoverySignUpApi _singleton = OnboardingRecoverySignUpApi._internal();

  OnboardingRecoverySignUpApi._internal();

  static OnboardingRecoverySignUpApi get instance => _singleton;

  Future<Map<String, dynamic>> onboardingRecoverySignUpApi(
      {
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
      // Create the request data map
      Map<String, dynamic> data = {
        "user_mode": userMode,
        "age": age,
        "gender":gender,
        "reminder_from":reminderFrom,
        "reminder_to":reminderTo,


        "injury_name":injuryName,
        "injury_level":injuryLevel,
        "injury_date":injuryDate,
        "current_recovery_stage":currentRecoverySage,


        "physical_symptom":physicalSymptom,
        "physical_symptom_details":physicalSymptomDetails,
        "physical_symptom_duration_hour":physicalSymptomDurationHour,
        "physical_symptom_frequency":physicalSymptomFrequency,
        "emotional_symptoms":physicalSymptom,



        "recovery_goal":recoveryGoal,
        "recovery_goal_time":recoveryGoalTime,
        "progress_timeline":progressTimeline,
        "recovery_target_date":recoveryTargetDate,



      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.onboardingRecoverySignUpApiLink(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Register Successfully');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during signup: $error");
      rethrow;
    }
  }
}
