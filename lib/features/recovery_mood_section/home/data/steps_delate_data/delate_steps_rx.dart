import 'dart:developer';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/data/steps_delate_data/delate_steps_api.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/delete_medication_data/delete_medication_api.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';


final class DeleteStepsRx extends RxResponseInt {
  final api = DeleteStepsApi.instance;

  DeleteStepsRx({required super.empty, required super.dataFetcher});

  ValueStream get getFollowData => dataFetcher.stream;

  Future<bool> deleteLogStepsApi({required String id}) async {
    try {
      log("=========================>>>>>>>>>>>>>>>>Log Steps ID Delete Success: ID(${id})");
      Map resdata = await api.deleteStepsPostApi(id: id);
      return handleSuccessWithReturn(resdata);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) {
    // Checking the response to determine if it's a follow or unfollow action

  }

  @override
  handleErrorWithReturn(error) {
    String errorMessage = 'Something went wrong';
    log(error.toString());

    errorMessage = error.response?.data["message"] ?? "Something went wrong";
    return super.handleErrorWithReturn(errorMessage);
  }
}
