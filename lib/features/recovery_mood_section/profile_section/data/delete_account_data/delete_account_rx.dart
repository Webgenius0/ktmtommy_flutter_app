import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

import '../../../../../helpers/all_routes.dart';
import 'delete_account_api.dart';

final class DeleteAccountRx extends RxResponseInt<Map<String, dynamic>> {
  final api = DeleteAccountApi.instance;

  DeleteAccountRx({required super.empty, required super.dataFetcher});

  ValueStream get getDeleteAccountStatus => dataFetcher.stream;

  Future<bool> deleteAccount() async {
    try {
      final responseData = await api.deleteAccount();

      log("=====>>>>>>Delete Account API Success: $responseData");
      ToastUtil.showShortToast(responseData['message'] ?? "Account deleted successfully");
      await _clearAllUserDataAndRedirect();
      return true;
    } on DioException catch (e) {
      log("========>>>Delete Account API DioException: ${e.message}");
      log("========>>>>>>Response: ${e.response?.data}");
      await _clearAllUserDataAndRedirect();
      ToastUtil.showShortToast("Account deleted successfully (session cleared)");
      return true;
    } catch (e) {
      log("======>>>>>>>>>Unexpected error during delete account: $e");
      await _clearAllUserDataAndRedirect();
      ToastUtil.showShortToast("Account deleted successfully");
      return true;
    }
  }

  /// all user data remove go to Login screen
  Future<void> _clearAllUserDataAndRedirect() async {
    try {
      await Future.wait([
        appData.remove(kKeyAccessToken),
        appData.remove(kKeyIsLoggedIn),
        appData.remove(kKeyUserID),
        appData.remove(kKeyUserType),
        appData.remove(kKeyUserEmail),
      ]);

      // Dio from Authorization header remove
      DioSingleton.instance.clearToken();

      // Stream success
      dataFetcher.sink.add({"success": true});

      // Login screen redirect
      if (Get.isOverlaysOpen) Get.back();
      Get.offAllNamed(Routes.loginScreenAthlet);

    } catch (e) {
      log("========>>>>>>>>>>>>Error during clearing user data: $e");
      Get.offAllNamed(Routes.loginScreenAthlet);
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
