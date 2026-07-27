import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';
import '../../model/schedule_feedback_model.dart';
import 'schedule_feedback_api.dart';

final class ScheduleFeedbackRx extends RxResponseInt<ScheduleFeedbackModel> {
  final api = ScheduleFeedbackApi.instance;

  ScheduleFeedbackRx({required super.empty, required super.dataFetcher});

  ValueStream<ScheduleFeedbackModel> get scheduleFeedbackStream =>
      dataFetcher.stream;

  Future<void> getScheduleFeedback(String fromDate, String toDate) async {
    try {
      ScheduleFeedbackModel allData =
          await api.getScheduleFeedbackApi(fromDate, toDate);
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  Future<void> postScheduleFeedback(String date, String rating) async {
    try {
      await api.saveScheduleFeedbackApi(date, rating);

      // Auto refresh calendar data reactively!
      final now = DateTime.now();
      final fromDate = now.subtract(const Duration(days: 15));
      final toDate = now.add(const Duration(days: 15));
      final fromStr = DateFormat('yyyy-MM-dd').format(fromDate);
      final toStr = DateFormat('yyyy-MM-dd').format(toDate);

      await getScheduleFeedback(fromStr, toStr);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }
}
