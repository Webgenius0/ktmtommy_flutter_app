import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class LogStepsScreenApi {
  static final LogStepsScreenApi _singleton = LogStepsScreenApi._internal();
  LogStepsScreenApi._internal();
  static LogStepsScreenApi get instance => _singleton;

  Future<Map<String, dynamic>> storeStepsApi({
    required String activity,
    required dynamic hours,
    required dynamic minutes,

  }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "activity": activity,
        "hours": hours,
        "minutes": minutes,

      };

      // Make the POST request
      Response response = (await postHttp(Endpoints.storeStepsApiPost(), data));

      if (response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        EasyLoading.showSuccess('Successfully saved medication! 🎉');
        log("=========>>>>>>>>>>>>Successfully saved medication");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("=======>>>>>>>Error during medication store: $error");
      rethrow;
    }
  }
}