import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/model/dietitian_settings_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class DietitianSettingsApi {
  static final DietitianSettingsApi _singleton = DietitianSettingsApi._internal();
  DietitianSettingsApi._internal();

  static DietitianSettingsApi get instance => _singleton;

  Future<DietitianSettingsModel> getDietitianSettings() async {
    try {
      Response response = await getHttp(Endpoints.dietitianSettingsApi());
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));
        return DietitianSettingsModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }

  Future<DietitianSettingsModel> postDietitianSettings({
    required dynamic isEnabled,
    required String name,
    required String dietitianEmail,
    required String sendTime,
  }) async {
    try {
      var formData = FormData.fromMap({
        "is_enabled": isEnabled,
        "name": name,
        "dietitian_email": dietitianEmail,
        "send_time": sendTime,
      });

      Response response = await postHttp(
        Endpoints.dietitianSettingsApi(),
        formData,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));
        return DietitianSettingsModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
