import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/data/get_all_equipment_data/get_all_equipment_api.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/model/get_all_equipment_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';

final class GetAllEquipmentRx extends RxResponseInt<GetAllEquipmentModel> {
  final api = GetAllEquipmentApi.instance;

  GetAllEquipmentRx({required super.empty, required super.dataFetcher});

  ValueStream<GetAllEquipmentModel> get GetAllEquipment => dataFetcher.stream;

  Future<void> getAllEquipmentApi() async {
    try {
      GetAllEquipmentModel allData = await api.getAllEquipmentScreenApi();
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(GetAllEquipmentModel data) {


    dataFetcher.sink.add(data);
    return data;
  }
}
