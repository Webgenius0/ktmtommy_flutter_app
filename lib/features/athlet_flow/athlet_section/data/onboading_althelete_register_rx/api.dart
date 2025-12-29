import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class OnboardingAthleteSignUpApi {
  static final OnboardingAthleteSignUpApi _singleton = OnboardingAthleteSignUpApi._internal();

  OnboardingAthleteSignUpApi._internal();

  static OnboardingAthleteSignUpApi get instance => _singleton;

  Future<Map<String, dynamic>> onboardingAthleteSignUpApi(
      {
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
      // Create the request data map
      Map<String, dynamic> data = {
        "user_mode": userMode,
        "age": age,
        "gender":gender,
        "experience_level": experienceLevel,
        "sport":sport,
        "goal":goal,
        "weight":weight,
        "weight_unit":weightUnit,
        "height":height,
        "height_unit":heightUnit,
        "reminder_from":reminderFrom,
        "reminder_to":reminderTo,

      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.onboardingAthleteSignUpApiLink(), data));

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
