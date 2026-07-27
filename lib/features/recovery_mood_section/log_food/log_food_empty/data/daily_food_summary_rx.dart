import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/data/daily_food_summary_api.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/model/daily_food_summary_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';

final class DailyFoodSummaryRx extends RxResponseInt<DailyFoodSummaryModel> {
  final api = DailyFoodSummaryApi.instance;

  DailyFoodSummaryRx({required super.empty, required super.dataFetcher});

  ValueStream<DailyFoodSummaryModel> get dailySummaryStream => dataFetcher.stream;

  Future<void> getDailyFoodSummary(String date) async {
    try {
      DailyFoodSummaryModel data = await api.getDailyFoodSummary(date);
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(DailyFoodSummaryModel data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
