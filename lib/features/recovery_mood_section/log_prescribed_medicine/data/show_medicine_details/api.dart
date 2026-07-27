import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_prescribed_medicine/model/prescribed_medicine_details_model.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

class GetPrescribedMedicineDetailsApi {
  static final GetPrescribedMedicineDetailsApi _singleton = GetPrescribedMedicineDetailsApi._internal();
  GetPrescribedMedicineDetailsApi._internal();
  static GetPrescribedMedicineDetailsApi get instance => _singleton;

  Future<PrescribedMedicineDetailsModel> getPrescribedMedicineDetails(dynamic id) async {
    try {
      Response response = await getHttp(Endpoints.showPrescribedMedicineApi(id));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));
        return PrescribedMedicineDetailsModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
