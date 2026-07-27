import 'package:ktmtommy_apps/features/recovery_mood_section/log_prescribed_medicine/model/prescribed_medicine_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetPrescribedMedicinesRx extends RxResponseInt<PrescribedMedicineModel> {
  final api = GetPrescribedMedicinesApi.instance;

  GetPrescribedMedicinesRx({required super.empty, required super.dataFetcher});

  ValueStream<PrescribedMedicineModel> get getPrescribedMedicinesData => dataFetcher.stream;

  Future<void> fetchPrescribedMedicines() async {
    try {
      PrescribedMedicineModel allData = await api.getPrescribedMedicines();
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(PrescribedMedicineModel data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
