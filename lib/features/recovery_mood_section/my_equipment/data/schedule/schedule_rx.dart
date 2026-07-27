import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';
import 'schedule_api.dart';

final class ScheduleRx extends RxResponseInt<Map<String, dynamic>> {
  final api = ScheduleApi.instance;

  ScheduleRx({required super.empty, required super.dataFetcher});

  ValueStream<Map<String, dynamic>> get storeScheduleStream => dataFetcher.stream;

  Future<void> storeSchedule(Map<String, dynamic> body) async {
    try {
      Map<String, dynamic> data = await api.storeScheduleApi(body);
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }
}
