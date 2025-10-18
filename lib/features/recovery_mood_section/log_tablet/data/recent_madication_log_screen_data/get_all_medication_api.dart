import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/model/all_medication_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class GetAllMedicationApi  {
  static final GetAllMedicationApi _singleton = GetAllMedicationApi._internal();
  GetAllMedicationApi._internal();

  static GetAllMedicationApi get instance => _singleton;

  Future<AllMedicationModel> allMedicationGetApi() async {
    try {
      Response response = await getHttp(
        Endpoints.allMedicationApi(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data =
        json.decode(json.encode(response.data));

        return AllMedicationModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}

