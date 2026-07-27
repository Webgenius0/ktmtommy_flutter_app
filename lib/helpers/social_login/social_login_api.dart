import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class PostGoogleLoginApi {
  static final PostGoogleLoginApi _singleton = PostGoogleLoginApi._internal();
  PostGoogleLoginApi._internal();
  static PostGoogleLoginApi get instance => _singleton;

  Future<Map> postSocialLogin({
    required String token,
    required dynamic provider,
  }) async {
    try {
      Map<String, dynamic> data = {
        "token": token,
        "provider": provider,
      };
      Response response = await postHttp(Endpoints.socialLogin(), data);
      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }

}