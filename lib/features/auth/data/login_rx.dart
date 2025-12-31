// ignore_for_file: depend_on_referenced_packages
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ktmtommy_apps/athlet_bottom_navigation_bar.dart';
import 'package:ktmtommy_apps/bottom_nav_screen.dart';
import 'package:ktmtommy_apps/features/auth/data/login_api.dart';
import '../../../../helpers/di.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/rx_base.dart';
import '../../../../constants/app_constants.dart';
import 'package:rxdart/streams.dart';

final class LoginRx extends RxResponseInt<Map<String, dynamic>> {
  final api = LoginApi.instance;

  LoginRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> logIn({
    required String email,
    required dynamic password,
  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data = await api.loginApi(
        email: email,
        password: password,
      );

      String token = data['access_token'];
      log(">>>>>>>>>>>>>>> Login token is : $token");
      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    // Extract the token from the response
    String token = data['access_token'];
    dynamic userId = data['data']['id'];
    dynamic userEmail = data['data']['email'];
    dynamic userRole = data['data']['user_mode'];

    // Save the token and login status using appData
    appData.write(kKeyAccessToken, token);
    appData.write(kKeyIsLoggedIn, true);
    appData.write(kKeyUserID, userId);
    appData.write(kKeyUserType, userRole);
    appData.write(kKeyUserEmail, userEmail);

    if(userRole =="recovery"){
      Get.offAll(BottomNavScreen());
    }else{
      Get.offAll(AthletBottomNavigationBar());
    }
    // Update DioSingleton with the new token
    DioSingleton.instance.update(token);

    // Add the data to the stream
    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    // Handle API error using DioException
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        // Show error message from the response
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else {
        // Show general message for other status codes
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    // Log the error and add it to the stream
    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}
