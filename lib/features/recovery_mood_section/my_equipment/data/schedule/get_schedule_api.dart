import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../model/schedule_model.dart';

class GetScheduleApi {
  static final GetScheduleApi _singleton = GetScheduleApi._internal();
  GetScheduleApi._internal();

  static GetScheduleApi get instance => _singleton;

  Future<ScheduleModel> getScheduleApi(String date) async {
    try {
      Response response = await getHttp(
        Endpoints.getSchedule(date),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));
        return ScheduleModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
