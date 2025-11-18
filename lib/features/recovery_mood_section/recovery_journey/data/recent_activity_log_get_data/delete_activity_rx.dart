import 'dart:developer';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/data/steps_delate_data/delate_steps_api.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/delete_medication_data/delete_medication_api.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/data/recent_activity_log_get_data/delete_activity_api.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';


final class DeleteActivityRx extends RxResponseInt {
  final api = DeleteActivityApi.instance;

  DeleteActivityRx({required super.empty, required super.dataFetcher});

  ValueStream get getFollowData => dataFetcher.stream;

  Future<bool> deleteActivityPostApi({required String id}) async {
    try {
      log("=========================>>>>>>>>>>>>>>>>Activity ID Delete Success: ID(${id})");
      Map resdata = await api.deleteActivityPostApi(id: id);
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
