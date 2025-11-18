import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/model/get_recent_step_model.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/model/all_medication_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class GetRecentStepApi  {
  static final GetRecentStepApi _singleton = GetRecentStepApi._internal();
  GetRecentStepApi._internal();

  static GetRecentStepApi get instance => _singleton;

  Future<GetRecentStepModel> allRecentStepsGetApi() async {
    try {
      Response response = await getHttp(
        Endpoints.allRecentGetApi(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data =
        json.decode(json.encode(response.data));

        return GetRecentStepModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}

