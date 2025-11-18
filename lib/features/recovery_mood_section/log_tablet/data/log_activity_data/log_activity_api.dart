import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class LogActivityApi {
  static final LogActivityApi _singleton = LogActivityApi._internal();
  LogActivityApi._internal();
  static LogActivityApi get instance => _singleton;

  Future<Map<String, dynamic>> storeActivityApi({
    required String name,
    required dynamic date,
    required dynamic time,
    required dynamic duration_minutes,
    required dynamic notify_before_minutes,
    required String notes,

  }) async {
    try {
      Map<String, dynamic> data = {
        "name": name,
        "date": date,
        "time": time,
        "duration_minutes": duration_minutes,
        "notify_before_minutes": notify_before_minutes,
        "notes": notes,

      };

      Response response = (await postHttp(Endpoints.storeActivityApiPost(), data));

      if (response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        EasyLoading.showSuccess('Successfully saved Activity! 🎉');
        log("=========>>>>>>>>>>>>Successfully saved Activity");
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