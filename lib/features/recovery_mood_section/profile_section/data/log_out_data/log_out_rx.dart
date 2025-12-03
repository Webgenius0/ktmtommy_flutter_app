// import 'dart:developer';
// import 'package:ktmtommy_apps/constants/app_constants.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/profile_section/data/log_out_data/log_out_api.dart';
// import 'package:ktmtommy_apps/helpers/di.dart';
// import 'package:ktmtommy_apps/helpers/toast.dart';
// import 'package:rxdart/rxdart.dart';
// import '../../../../../networks/rx_base.dart';
//
// final class PostLogOutRX extends RxResponseInt {
//   final api = LogOutApi.instance;
//
//   String message = "Something went wrong";
//
//   PostLogOutRX({required super.empty, required super.dataFetcher});
//
//   ValueStream get getLogoutData => dataFetcher.stream;
//
//   Future<bool> logOut() async {
//     try {
//       Map resdata = await api.logOut();
//       return handleSuccessWithReturn(resdata);
//     } catch (error) {
//       return handleErrorWithReturn(error);
//     }
//   }
//
//   @override
//   handleSuccessWithReturn(data) {
//     appData.write(kKeyAccessToken, false);
//     dataFetcher.sink.add(data);
//     ToastUtil.showShortToast("Logout successful");
//     return true;
//   }
//
//   @override
//   handleErrorWithReturn(error) {
//     String errorMessage = 'Something went wrong';
//     log(error.toString());
//
//     errorMessage = error.response?.data["message"] ?? "Something went wrong";
//     return super.handleErrorWithReturn(errorMessage);
//   }
// }

///====Upper code not remove ===============

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/profile_section/data/log_out_data/log_out_api.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

import '../../../../../helpers/all_routes.dart';

final class PostLogOutRX extends RxResponseInt<Map<String, dynamic>> {
  final api = LogOutApi.instance;

  PostLogOutRX({required super.empty, required super.dataFetcher});

  ValueStream get getLogoutStatus => dataFetcher.stream;

  Future<bool> logout() async {
    try {

      final responseData = await api.logOut();

      log("=====>>>>>>Logout API Success: $responseData");
      await _clearAllUserDataAndRedirect(isForced: false);
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        log("==========>>>>>>>>Token expired or invalid → Force logout (401 detected)");
        ToastUtil.showShortToast("Session expired, logging you out...");
        await _clearAllUserDataAndRedirect(isForced: true);
        return true;
      }

      log("========>>>Logout API DioException: ${e.message}");
      log("========>>>>>>Response: ${e.response?.data}");
      await _clearAllUserDataAndRedirect(isForced: true);
      ToastUtil.showShortToast("Logged out (session cleared)");
      return true;
    } catch (e) {
      // unexpected error
      log("======>>>>>>>>>Unexpected error during logout: $e");
      await _clearAllUserDataAndRedirect(isForced: true);
      ToastUtil.showShortToast("Logged out successfully");
      return true;
    }
  }

  /// all user data remove go to Login screen
  Future<void> _clearAllUserDataAndRedirect({required bool isForced}) async {
    try {

      await Future.wait([
        appData.remove(kKeyAccessToken),
        appData.remove(kKeyIsLoggedIn),
        appData.remove(kKeyUserID),
        appData.remove(kKeyUserType),
        appData.remove(kKeyUserEmail),
      ]);


      // await appData.erase(); // all data remove

      // 2. Dio from Authorization header remove
      DioSingleton.instance.clearToken();

      // 3. Stream এ success
      dataFetcher.sink.add({"success": true, "forced": isForced});



      // 5. Login screen এ redirect
      if (Get.isOverlaysOpen) Get.back();
      Get.offAllNamed(Routes.logInSelectionModeScreen);

    } catch (e) {
      log("========>>>>>>>>>>>>Error during clearing user data: $e");
      Get.offAllNamed(Routes.logInSelectionModeScreen);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    dataFetcher.sink.addError(error);
    return false;
  }
}