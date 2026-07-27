import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class VerifyOtpApi {
  static final VerifyOtpApi _singleton = VerifyOtpApi._internal();

  VerifyOtpApi._internal();

  static VerifyOtpApi get instance => _singleton;

  Future<Map<String, dynamic>> verifyOtpApi({
    required String email,
    required String otp,
    required String otpType,
  }) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "otp": otp,
        "otp_type": otpType,
      };
      Response response = (await postHttp(Endpoints.verifyOtp(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
