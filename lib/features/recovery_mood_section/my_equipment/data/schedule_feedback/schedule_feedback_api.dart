import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../model/schedule_feedback_model.dart';

class ScheduleFeedbackApi {
  static final ScheduleFeedbackApi _singleton = ScheduleFeedbackApi._internal();
  ScheduleFeedbackApi._internal();

  static ScheduleFeedbackApi get instance => _singleton;

  Future<ScheduleFeedbackModel> getScheduleFeedbackApi(
      String fromDate, String toDate) async {
    try {
      Response response = await getHttp(
        Endpoints.scheduleFeedback(fromDate, toDate),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));
        return ScheduleFeedbackModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }

  Future<Map<String, dynamic>> saveScheduleFeedbackApi(
      String date, String rating) async {
    try {
      final formData = FormData.fromMap({
        "date": date,
        "rating": rating,
      });

      Response response = await postHttp(
        Endpoints.postScheduleFeedback(),
        formData,
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
