import 'dart:developer';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class DeletePrescribedMedicineRx extends RxResponseInt<Map<String, dynamic>> {
  final api = DeletePrescribedMedicineApi.instance;

  DeletePrescribedMedicineRx({required super.empty, required super.dataFetcher});

  ValueStream<Map<String, dynamic>> get deletePrescribedMedicineData => dataFetcher.stream;

  Future<bool> deletePrescribedMedicineInfo(dynamic id) async {
    try {
      Map<String, dynamic> data = await api.deletePrescribedMedicine(id);
      await handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      dataFetcher.sink.add(data);
      return true;
    } catch (e) {
      log("Failed to process data: $e");
      return false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    log('Error: $error');
    dataFetcher.sink.addError(error);
    return false;
  }
}
