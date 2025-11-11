import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class RecoveryRegistrationApi {
  static final RecoveryRegistrationApi _singleton = RecoveryRegistrationApi._internal();
  RecoveryRegistrationApi._internal();
  static RecoveryRegistrationApi get instance => _singleton;

  Future<Map<dynamic, dynamic>> registerUserApi({
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
      ///==================== Create JSON payload ====================///
      FormData formData = FormData.fromMap ({
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": password_confirmation,
        "age": age,
        "gender": gender,
        "user_mode": user_mode,
        "terms_accepted": terms_accepted,
        "injury_name": injury_name,
        "injury_level": injury_level,
        "injury_date": injury_date,
        "current_recovery_stage": current_recovery_stage,
        "physical_symptom": physical_symptom,
        "physical_symptom_details": physical_symptom_details,
        "physical_symptom_duration": physical_symptom_duration,
        "physical_symptom_frequency": physical_symptom_frequency,
        "emotional_symptoms": emotional_symptoms,
        "recovery_goal": recovery_goal,
        "recovery_goal_time": recovery_goal_time,
        "progress_timeline": progress_timeline,
        "recovery_target_date": recovery_target_date,
        "reminder_from": reminder_from,
        "reminder_to": reminder_to,
      });

      ///======================= Make POST request ======================///
      Response response = await postHttp(Endpoints.recoveryRegisterApi(), formData);

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




