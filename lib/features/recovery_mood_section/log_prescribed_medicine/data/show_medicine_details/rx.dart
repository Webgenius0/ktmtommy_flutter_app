import 'package:ktmtommy_apps/features/recovery_mood_section/log_prescribed_medicine/model/prescribed_medicine_details_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetPrescribedMedicineDetailsRx extends RxResponseInt<PrescribedMedicineDetailsModel> {
  final api = GetPrescribedMedicineDetailsApi.instance;

  GetPrescribedMedicineDetailsRx({required super.empty, required super.dataFetcher});

  ValueStream<PrescribedMedicineDetailsModel> get getPrescribedMedicineDetailsData => dataFetcher.stream;

  Future<void> fetchPrescribedMedicineDetails(dynamic id) async {
    try {
      PrescribedMedicineDetailsModel detailsData = await api.getPrescribedMedicineDetails(id);
      handleSuccessWithReturn(detailsData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(PrescribedMedicineDetailsModel data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
