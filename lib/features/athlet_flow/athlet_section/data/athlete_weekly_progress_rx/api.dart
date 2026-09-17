import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/model/athlete_weekly_progress_model.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class AthleteWeeklyProgressApi {
  static final AthleteWeeklyProgressApi _singleton = AthleteWeeklyProgressApi._internal();

  AthleteWeeklyProgressApi._internal();

  static AthleteWeeklyProgressApi get instance => _singleton;

  Future<AthleteWeeklyProgressModel> getWeeklyProgressApi({int? week}) async {
    try {
      Response response = await getHttp(Endpoints.athleteWeeklyProgress(week: week));

      log("Athlete Weekly Progress API Response Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data is String
            ? json.decode(response.data)
            : Map<String, dynamic>.from(response.data);
        return AthleteWeeklyProgressModel.fromJson(responseData);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error during athlete weekly progress API call: $error");
      rethrow;
    }
  }
}
