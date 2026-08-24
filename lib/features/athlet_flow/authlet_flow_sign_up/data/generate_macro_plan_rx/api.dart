import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/model/generate_macro_plan_model.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class GenerateMacroPlanApi {
  static final GenerateMacroPlanApi _singleton = GenerateMacroPlanApi._internal();

  GenerateMacroPlanApi._internal();

  static GenerateMacroPlanApi get instance => _singleton;

  Future<GenerateMacroPlanModel> generateMacroPlanApi([Map<String, dynamic>? body]) async {
    try {
      Response response = await postHttp(
        Endpoints.generateMacroPlanApiLink(),
        body ?? {},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = response.data is String
            ? json.decode(response.data)
            : Map<String, dynamic>.from(response.data);
        return GenerateMacroPlanModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error generating macro plan via POST: $error");
      rethrow;
    }
  }
}
