import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';



class AddMessageApi {
  static final AddMessageApi _singleton = AddMessageApi._internal();
  AddMessageApi._internal();

  static AddMessageApi get instance => _singleton;

  Future<Map> addChat({required String message,}) async {
    Map<String, dynamic> data = {
      "message": message

    };
    try {
      Response response = await postHttp(Endpoints.sendMessageForAi(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      throw ErrorHandler.handle(error).failure.responseMessage;
    }
  }
}
