import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/data/recent_activity_log_get_data/get_recent_activity_log_api.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/model/recent_activity_log_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';

final class GetRecentActivityLogRx extends RxResponseInt<GetRecentActivityModel> {
  final api = GetRecentActivityLogApi.instance;

  GetRecentActivityLogRx({required super.empty, required super.dataFetcher});

  ValueStream<GetRecentActivityModel> get ActivityLogScreen => dataFetcher.stream;

  Future<void> getAllActivityApi() async {
    try {
      GetRecentActivityModel allData = await api.allActivityGetApi();
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(GetRecentActivityModel data) {

    dataFetcher.sink.add(data);
    return data;
  }
}
