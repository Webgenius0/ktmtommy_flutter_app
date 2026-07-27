import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../model/schedule_model.dart';
import 'get_schedule_api.dart';

final class GetScheduleRx extends RxResponseInt<ScheduleModel> {
  final api = GetScheduleApi.instance;

  GetScheduleRx({required super.empty, required super.dataFetcher});

  ValueStream<ScheduleModel> get scheduleStream => dataFetcher.stream;

  Future<void> getSchedule(String date) async {
    try {
      ScheduleModel data = await api.getScheduleApi(date);
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(ScheduleModel data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
