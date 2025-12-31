import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class ChangePasswordScreenApi {
  static final  ChangePasswordScreenApi _singleton = ChangePasswordScreenApi._internal();
  ChangePasswordScreenApi._internal();
  static  ChangePasswordScreenApi get instance => _singleton;

  Future<Map<String, dynamic>> changePasswordScreenPostApi({ required String current_password, required String password, required String password_confirmation}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "current_password": current_password,
        "password": password,
        "password_confirmation": password_confirmation,


      };
      // Make the POST request
      Response response = ( await postHttp(Endpoints.changePasswordScreenApi(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Successfully');
        return data;

      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during signup: $error");
      rethrow;
    }
  }
}
