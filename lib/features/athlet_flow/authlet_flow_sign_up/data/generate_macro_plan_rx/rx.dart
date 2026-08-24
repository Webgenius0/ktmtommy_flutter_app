import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/data/generate_macro_plan_rx/api.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/model/generate_macro_plan_model.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GenerateMacroPlanRx extends RxResponseInt<GenerateMacroPlanModel> {
  final api = GenerateMacroPlanApi.instance;

  GenerateMacroPlanRx({required super.empty, required super.dataFetcher});

  ValueStream<GenerateMacroPlanModel> get getMacroPlanStream => dataFetcher.stream;

  Future<GenerateMacroPlanModel?> fetchGenerateMacroPlan([Map<String, dynamic>? body]) async {
    try {
      GenerateMacroPlanModel data = await api.generateMacroPlanApi(body);
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      return null;
    }
  }

  @override
  handleSuccessWithReturn(GenerateMacroPlanModel data) {
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        ToastUtil.showShortToast(error.response!.data["message"] ?? "Failed to fetch macro plan");
      } else {
        ToastUtil.showShortToast("No response data available");
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
