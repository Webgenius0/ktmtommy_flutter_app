import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class LoginApi {
  static final LoginApi _singleton = LoginApi._internal();

  LoginApi._internal();

  static LoginApi get instance => _singleton;

  Future<Map<String, dynamic>> loginApi({
    required String email,
    required dynamic password,
  }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.login(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        //ToastUtil.showShortToast('Login Successfully');
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
