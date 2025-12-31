import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/profile_section/data/change_password_screen_data/change_password_screen_api.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class
ChangePasswordScreenRx extends RxResponseInt<Map<String, dynamic>> {
  final api = ChangePasswordScreenApi.instance;

  ChangePasswordScreenRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postChangePasswordScreenApi({
    required String current_password,
    required String password,
    required String password_confirmation,


  }) async {
    try {

      print('============>>>>>>>>>API Request: {city: $current_password}');
      print('============>>>>>>>>>API Request: {city: $password}');
      print('============>>>>>>>>>API Request: {city: $password_confirmation}');

      Map<String, dynamic> data = await api.changePasswordScreenPostApi(
        current_password: current_password,
        password: password,
        password_confirmation: password_confirmation,


      );

      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<bool> handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      dataFetcher.sink.add(data);
      return true;
    } catch (e) {
      ToastUtil.showShortToast("Failed to process data. Please try again.");
      return false;
    }
  }

  @override
  bool handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(error.response?.data["message"] ?? "Invalid request");
      } else {
        ToastUtil.showShortToast("An unexpected error occurred");
      }
    } else {
      ToastUtil.showShortToast("Something went wrong");
    }
    log('Error: $error');
    dataFetcher.sink.addError(error);
    return false;
  }
}
