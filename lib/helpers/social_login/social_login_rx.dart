import 'dart:developer';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:s_castor_flutter/constants/app_constants.dart';
import 'package:s_castor_flutter/helpers/di.dart';
import 'package:s_castor_flutter/helpers/social_login/social_login_api.dart';
import 'package:s_castor_flutter/networks/dio/dio.dart';
import 'package:s_castor_flutter/networks/exception_handler/data_source.dart';
import 'package:s_castor_flutter/networks/rx_base.dart';

final class PostSocialLoginRX extends RxResponseInt<Map> {
  final api = PostGoogleLoginApi.instance;
  String message = "Can't login!".tr;

  PostSocialLoginRX({required super.empty, required super.dataFetcher});

  ValueStream get getSocialLoginRes => dataFetcher.stream;

  Future<Map> postGoogleLogin({
    required String registerType,
    required String token,
  }) async {
    try {
      Map resdata = await api.postSocialLogin(
        token: token,
        provider: registerType,
      );
      log(" from response : $resdata");
      return handleSuccessWithReturn(resdata);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  Future<Map> handleSuccessWithReturn(Map data) async {
    message = data["message"];
    if (data["success"] == true) {
      String accesstoken = data["token"];
      log('rx token $accesstoken');
      String id = data["data"]["id"].toString();

      // * Save user data to appData
      await appData.write(kKeyIsLoggedIn, true);
      await appData.write(kKeyAccessToken, accesstoken);
      await appData.write(kKeyUserID, id);

      // * Update Dio Singleton with new access token
      DioSingleton.instance.update(accesstoken);
      dataFetcher.sink.add(data);
      return data;
    } else {

      throw DataSource.DEFAULT.getFailure();
    }
  }

}