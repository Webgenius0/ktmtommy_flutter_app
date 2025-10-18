import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/data/edit_medication_data/edit_medication_api.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class EditMedicationRx extends RxResponseInt<Map<String, dynamic>> {
  final api = EditMedicationApi.instance;

  EditMedicationRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> putEditMedicationPutApi({
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
      print('============>>>>>>>>>API Request: {id: $id, name: $name, dosage: $dosage, dosage_unit: $dosageUnit, is_prescribed: $isPrescribed, taken_at: $takenAt, upright_posture: $uprightPosture, water_intake: $waterIntake, glass_of_water: $glassOfWater, notes: $notes}');

      Map<String, dynamic> data = await api.editMedicationPutApi(
        id: id, // ID পাঠানো হচ্ছে
        name: name,
        dosage: dosage,
        dosageUnit: dosageUnit,
        isPrescribed: isPrescribed,
        takenAt: takenAt,
        uprightPosture: uprightPosture,
        waterIntake: waterIntake,
        glassOfWater: glassOfWater,
        notes: notes,
      );

      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<bool> handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      dataFetcher.sink.add(data);
      return true;
    } catch (e) {
      print("========>>>>>>>>Failed to process data. Please try again.");
      return false;
    }
  }

  @override
  bool handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(
            error.response?.data["message"] ?? "Invalid request");
      } else {
        ToastUtil.showShortToast("An unexpected error occurred");
      }
    } else {
      ToastUtil.showShortToast("Something went wrong");
    }
    log('Error: $error');
    dataFetcher.sink.addError(error);
    return false;
  }
}