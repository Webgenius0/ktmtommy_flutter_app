import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/model/recent_activity_log_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class GetRecentActivityLogApi  {
  static final GetRecentActivityLogApi _singleton = GetRecentActivityLogApi._internal();
  GetRecentActivityLogApi._internal();

  static GetRecentActivityLogApi get instance => _singleton;

  Future<GetRecentActivityModel> allActivityGetApi() async {
    try {
      Response response = await getHttp(
        Endpoints.allActivityApi(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data =
        json.decode(json.encode(response.data));

        return GetRecentActivityModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}

