import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/data/rx_get_recent_sleep/api.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/model/GetAllSleep.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';

import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

final class GetRecentSleepRx extends RxResponseInt<GetAllSleepDataModel> {
  final api = GetRecentSleepApi.instance;

  GetRecentSleepRx({required super.empty, required super.dataFetcher});


  Future<GetAllSleepDataModel?> getRecentSleepInfo() async {
    try {
      GetAllSleepDataModel data = await api.getHome();
      print("$data");
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else if(error.response!.statusCode == 401) {
        NavigationService.navigateTo(Routes.chooseModeScreen);
      }
      else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return null;
  }
}

