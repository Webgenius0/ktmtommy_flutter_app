import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class UpdateTimezoneApi {
  static final UpdateTimezoneApi _singleton = UpdateTimezoneApi._internal();

  UpdateTimezoneApi._internal();

  static UpdateTimezoneApi get instance => _singleton;

  Future<Map<String, dynamic>> updateTimezone(String timezone) async {
    try {
      FormData data = FormData.fromMap({
        "timezone": timezone,
      });

      Response response = await postHttp(Endpoints.updateTimezoneApi(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(json.encode(response.data));
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
