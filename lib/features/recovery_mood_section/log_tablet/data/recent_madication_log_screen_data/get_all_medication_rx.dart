import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/recent_madication_log_screen_data/get_all_medication_api.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/model/all_medication_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';

final class GetAllMedicationRx extends RxResponseInt<AllMedicationModel> {
  final api = GetAllMedicationApi.instance;

  GetAllMedicationRx({required super.empty, required super.dataFetcher});

  ValueStream<AllMedicationModel> get ProfileScreen => dataFetcher.stream;

  Future<void> getAllMedicationApi() async {
    try {
      AllMedicationModel allData = await api.allMedicationGetApi();
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(AllMedicationModel data) {

    dataFetcher.sink.add(data);
    return data;
  }
}
