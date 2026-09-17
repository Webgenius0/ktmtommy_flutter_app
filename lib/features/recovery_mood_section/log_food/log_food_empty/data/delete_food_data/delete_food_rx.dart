import 'dart:developer';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/data/delete_food_data/delete_food_api.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class DeleteFoodRx extends RxResponseInt {
  final api = DeleteFoodApi.instance;

  DeleteFoodRx({required super.empty, required super.dataFetcher});

  ValueStream get getDeleteFoodData => dataFetcher.stream;

  Future<bool> deleteFoodApi({required dynamic id}) async {
    try {
      log("=========================>>>>>>>>>>>>>>>>Food ID Delete Success: ID($id)");
      Map resdata = await api.deleteFoodApi(id: id);
      return handleSuccessWithReturn(resdata);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) {
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String errorMessage = 'Something went wrong';
    log(error.toString());

    try {
      errorMessage = error.response?.data["message"] ?? "Something went wrong";
    } catch (_) {}
    return super.handleErrorWithReturn(errorMessage);
  }
}
