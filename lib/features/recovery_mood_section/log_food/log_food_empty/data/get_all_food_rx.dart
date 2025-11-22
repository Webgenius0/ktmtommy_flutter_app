import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/data/get_all_food_api.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/model/get_all_food_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';

final class GetAllFoodRx extends RxResponseInt<GetAllFoodModel> {
  final api = GetAllFoodApi.instance;

  GetAllFoodRx({required super.empty, required super.dataFetcher});

  ValueStream<GetAllFoodModel> get GetAllFood => dataFetcher.stream;

  Future<void> getAllFoodApi() async {
    try {
      GetAllFoodModel allData = await api.getAllFoodScreeApi();
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(GetAllFoodModel data) {

    dataFetcher.sink.add(data);
    return data;
  }
}
