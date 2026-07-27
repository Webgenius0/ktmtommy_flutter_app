import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class ScheduleApi {
  static final ScheduleApi _singleton = ScheduleApi._internal();
  ScheduleApi._internal();

  static ScheduleApi get instance => _singleton;

  Future<Map<String, dynamic>> storeScheduleApi(Map<String, dynamic> body) async {
    try {
      Response response = await postHttp(
        Endpoints.storeSchedule(),
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data is Map<String, dynamic>
            ? response.data
            : Map<String, dynamic>.from(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
