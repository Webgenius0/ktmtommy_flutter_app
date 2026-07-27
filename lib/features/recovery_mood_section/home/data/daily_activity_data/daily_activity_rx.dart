import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';
import '../../model/daily_activity_model.dart';
import 'daily_activity_api.dart';

final class DailyActivityRx extends RxResponseInt<DailyActivityModel> {
  final api = DailyActivityApi.instance;

  DailyActivityRx({required super.empty, required super.dataFetcher});

  ValueStream<DailyActivityModel> get dailyActivityStream => dataFetcher.stream;

  Future<void> getDailyActivity(String date) async {
    try {
      Map<String, dynamic> res = await api.getDailyActivity(date);
      DailyActivityModel data = DailyActivityModel.fromJson(res);
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(DailyActivityModel data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
