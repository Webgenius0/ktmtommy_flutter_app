import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_prescribed_medicine/model/prescribed_medicine_model.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

class GetPrescribedMedicinesApi {
  static final GetPrescribedMedicinesApi _singleton = GetPrescribedMedicinesApi._internal();
  GetPrescribedMedicinesApi._internal();
  static GetPrescribedMedicinesApi get instance => _singleton;

  Future<PrescribedMedicineModel> getPrescribedMedicines() async {
    try {
      Response response = await getHttp(Endpoints.getPrescribedMedicineApi());

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));
        return PrescribedMedicineModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
