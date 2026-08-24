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

  Future<Map<String, dynamic>> onboardingAthleteSignUpApi(Map<String, dynamic> data) async {
    try {
      Response response = await postHttp(Endpoints.onboardingAthleteSignUpApiLink(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final resData = response.data is String ? json.decode(response.data) : response.data;
        ToastUtil.showShortToast('Register Successfully');
        return Map<String, dynamic>.from(resData);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during signup: $error");
      rethrow;
    }
  }
}
