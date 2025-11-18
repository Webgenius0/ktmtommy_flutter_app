import 'package:ktmtommy_apps/features/recovery_mood_section/home/data/log_steps_screen_data/get_recent_step_api.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/model/get_recent_step_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';

final class GetRecentStepRx extends RxResponseInt<GetRecentStepModel> {
  final api = GetRecentStepApi.instance;

  GetRecentStepRx({required super.empty, required super.dataFetcher});

  ValueStream<GetRecentStepModel> get LogSetepsScreen => dataFetcher.stream;

  Future<void> getAllRecentStepsApi() async {
    try {
      GetRecentStepModel allData = await api.allRecentStepsGetApi();
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(GetRecentStepModel data) {

    dataFetcher.sink.add(data);
    return data;
  }
}
