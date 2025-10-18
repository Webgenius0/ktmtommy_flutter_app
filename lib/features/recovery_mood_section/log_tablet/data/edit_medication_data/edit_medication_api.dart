import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class EditMedicationApi {
  static final EditMedicationApi _singleton = EditMedicationApi._internal();
  EditMedicationApi._internal();
  static EditMedicationApi get instance => _singleton;

  Future<Map<String, dynamic>> editMedicationPutApi({
    required String id,
    required String name,
    required double dosage,
    required String dosageUnit,
    required bool isPrescribed,
    required String takenAt,
    required bool uprightPosture,
    required bool waterIntake,
    required int glassOfWater,
    required String notes,
  }) async {
    try {
      // Request data map
      Map<String, dynamic> data = {
        "name": name,
        "dosage": dosage,
        "dosage_unit": dosageUnit,
        "is_prescribed": isPrescribed,
        "taken_at": takenAt,
        "upright_posture": uprightPosture,
        "water_intake": waterIntake,
        "glass_of_water": glassOfWater,
        "notes": notes,
      };

      // Make the PUT request with the dynamic endpoint
      Response response = await putHttp(Endpoints.editMedicationApi(id), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Successfully updated medication');
        print("=========>>>>>>>>>>>>Successfully updated medication for ID: $id");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during medication update for ID: $id, Error: $error");
      rethrow;
    }
  }
}