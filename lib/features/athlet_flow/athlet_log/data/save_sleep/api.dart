import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class SaveSleepApi {
  static final SaveSleepApi _singleton = SaveSleepApi._internal();
  SaveSleepApi._internal();
  static SaveSleepApi get instance => _singleton;

  Future<Map<dynamic, dynamic>> saveSleepApi({

    required dynamic date,
    required dynamic bedTime,
    required dynamic wakeUpTime,

  }) async {
    try {
      ///==================== Create JSON payload ====================///
      final data = {
        'wake_up_time': wakeUpTime,
        'bed_time': bedTime,
        'date': date,


      };

      ///======================= Make POST request ======================///
      Response response = await postHttp(Endpoints.saveSleepPostApiLink(), data);

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