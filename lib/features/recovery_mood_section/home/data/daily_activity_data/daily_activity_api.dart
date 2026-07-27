import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

class DailyActivityApi {
  static final DailyActivityApi _singleton = DailyActivityApi._internal();

  DailyActivityApi._internal();

  static DailyActivityApi get instance => _singleton;

  Future<Map<String, dynamic>> getDailyActivity(String date) async {
    try {
      Response response = await getHttp(
        Endpoints.getDailyActivities(date),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(json.encode(response.data));
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
