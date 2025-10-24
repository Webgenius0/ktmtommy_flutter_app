import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class StoreApi {
  static final StoreApi _singleton = StoreApi._internal();
  StoreApi._internal();
  static StoreApi get instance => _singleton;

  Future<Map<String, dynamic>> storePostApi({
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
      // Create the request data map
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

      // Make the POST request
      Response response = (await postHttp(Endpoints.storeMedicationApi(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        EasyLoading.showSuccess('Successfully saved medication! 🎉');
        print("=========>>>>>>>>>>>>Successfully saved medication");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during medication store: $error");
      rethrow;
    }
  }
}