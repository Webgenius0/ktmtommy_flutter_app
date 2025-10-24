import 'dart:developer';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/delete_medication_data/delete_medication_api.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';


final class DeleteMedicationRx extends RxResponseInt {
  final api = ServiceDeleteApi.instance;

  DeleteMedicationRx({required super.empty, required super.dataFetcher});

  ValueStream get getFollowData => dataFetcher.stream;

  Future<bool> deleteMedicationApi({required String id}) async {
    try {
      log("=========================>>>>>>>>>>>>>>>>Service ID Delete Success: ID(${id})");
      Map resdata = await api.deleteMedicationPostApi(id: id);
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
