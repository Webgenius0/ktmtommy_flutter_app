import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class AltheleteSignUpApi {
  static final AltheleteSignUpApi _singleton = AltheleteSignUpApi._internal();

  AltheleteSignUpApi._internal();

  static AltheleteSignUpApi get instance => _singleton;

  Future<Map<String, dynamic>> altheleteSignUpApi(
      {
        required dynamic name,
      required dynamic email,
      required dynamic password,
      required dynamic confirmPassword,
      required dynamic termsAccepted,
      required dynamic timezone,
      }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "name": name,
        "terms_accepted": termsAccepted,
        "timezone": timezone,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.signUpAltheleteApiLink(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Register Successfully');
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
