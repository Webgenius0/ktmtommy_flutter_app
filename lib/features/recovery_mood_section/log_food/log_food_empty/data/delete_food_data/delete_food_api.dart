import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class DeleteFoodApi {
  static final DeleteFoodApi _singleton = DeleteFoodApi._internal();

  DeleteFoodApi._internal();

  static DeleteFoodApi get instance => _singleton;

  Future<Map> deleteFoodApi({required dynamic id}) async {
    try {
      Response response = await deleteHttp(Endpoints.deleteFoodApi(id));

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Food deleted successfully 🎉');
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
