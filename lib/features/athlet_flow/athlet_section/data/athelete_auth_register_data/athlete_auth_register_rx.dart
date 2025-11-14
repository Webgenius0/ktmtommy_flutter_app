import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/data/athelete_auth_register_data/athlete_auth_register_api.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class AthleteAuthRegisterRx extends RxResponseInt<Map<dynamic, dynamic>> {
  final api = AthleteAuthRegisterApi.instance;

  AthleteAuthRegisterRx({required super.empty, required super.dataFetcher});

  ValueStream<Map<dynamic, dynamic>> get registrationData => dataFetcher.stream;

  ///=================== Call the Recovery Register API ===================///
  Future<bool> registerAthleteUserApi({
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
    required int age,
    required String gender,
    required String user_mode,
    required String goal,
    required String sport,
    required String experience_level,
    required double height,
    required String height_unit,
    required double weight,
    required String weight_unit,
    required String reminder_from,
    required String reminder_to,
  }) async {
    try {
      Map<String, dynamic> payload = {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password_confirmation,
        'age': age,
        'gender': gender,
        'user_mode': user_mode,
        'goal': goal,
        'sport': sport,
        'experience_level': experience_level,
        'height': height,
        'height_unit': height_unit,
        'weight': weight,
        'weight_unit': weight_unit,
        'reminder_from': reminder_from,
        'reminder_to': reminder_to,
        'terms_accepted': true,
      };
      log("Request Payload: ${jsonEncode(payload)}");

      Map<dynamic, dynamic> data = await api.registerAthleteApi(
        name: name,
        email: email,
        password: password,
        password_confirmation: password_confirmation,
        age: age,
        gender: gender,
        user_mode: user_mode,
        goal: goal,
        sport: sport,
        experience_level: experience_level,
        height: height,
        height_unit: height_unit,
        weight: weight,
        weight_unit: weight_unit,
        reminder_from: reminder_from,
        reminder_to: reminder_to,
        terms_accepted: true,
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
        log("Error Response Data: ${error.response!.data}");
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