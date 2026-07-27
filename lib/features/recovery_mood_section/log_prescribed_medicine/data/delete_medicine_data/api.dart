import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

class DeletePrescribedMedicineApi {
  static final DeletePrescribedMedicineApi _singleton = DeletePrescribedMedicineApi._internal();
  DeletePrescribedMedicineApi._internal();
  static DeletePrescribedMedicineApi get instance => _singleton;

  Future<Map<String, dynamic>> deletePrescribedMedicine(dynamic id) async {
    try {
      Response response = await deleteHttp(Endpoints.deletePrescribedMedicineApi(id));

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Prescribed medicine deleted successfully 🎉');
        Map<String, dynamic> data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
