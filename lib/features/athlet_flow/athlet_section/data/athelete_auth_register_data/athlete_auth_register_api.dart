import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class AthleteAuthRegisterApi {
  static final AthleteAuthRegisterApi _singleton = AthleteAuthRegisterApi._internal();
  AthleteAuthRegisterApi._internal();
  static AthleteAuthRegisterApi get instance => _singleton;

  Future<Map<dynamic, dynamic>> registerAthleteApi({
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
    required bool terms_accepted,
  }) async {
    try {
      ///==================== Create JSON payload ====================///
      final payload = {
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
        'terms_accepted': terms_accepted,
      };

      log("API Request Payload: ${jsonEncode(payload)}");

      ///======================= Make POST request ======================///
      Response response = await postHttp(Endpoints.recoveryRegisterApi(), payload);

      log("Recovery Register API Response: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data is String
            ? json.decode(response.data)
            : (response.data as Map<dynamic, dynamic>);

        if (responseData['success'] == true) {
          ToastUtil.showShortToast(responseData['message'] ?? 'Registration Successful');
          return responseData;
        } else {
          throw Exception(responseData['message'] ?? 'Registration Failed');
        }
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error during registration: $error");
      rethrow;
    }
  }
}