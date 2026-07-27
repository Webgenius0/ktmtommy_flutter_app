import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/streams.dart';
import 'api.dart';

final class SavePrescribedMedicineRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SavePrescribedMedicineApi.instance;

  SavePrescribedMedicineRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> savePrescribedMedicineInfo({
    required String medicineName,
    required String dosage,
    required String dosageType,
    required String medicineType,
    required List<String> takingTimes,
    required String startDate,
    required String? endDate,
    required int beforeMeal,
    required int notification,
    required dynamic notifyBefore,
    required String doctorNote,
  }) async {
    try {
      Map<String, dynamic> data = await api.storePrescribedMedicine(
        medicineName: medicineName,
        dosage: dosage,
        dosageType: dosageType,
        medicineType: medicineType,
        takingTimes: takingTimes,
        startDate: startDate,
        endDate: endDate,
        beforeMeal: beforeMeal,
        notification: notification,
        notifyBefore: notifyBefore,
        doctorNote: doctorNote,
      );

      await handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  Future<bool> updatePrescribedMedicineInfo({
    required dynamic id,
    required String medicineName,
    required String dosage,
    required String dosageType,
    required String medicineType,
    required List<String> takingTimes,
    required String startDate,
    required String? endDate,
    required int beforeMeal,
    required int notification,
    required dynamic notifyBefore,
    required String doctorNote,
  }) async {
    try {
      Map<String, dynamic> data = await api.updatePrescribedMedicine(
        id: id,
        medicineName: medicineName,
        dosage: dosage,
        dosageType: dosageType,
        medicineType: medicineType,
        takingTimes: takingTimes,
        startDate: startDate,
        endDate: endDate,
        beforeMeal: beforeMeal,
        notification: notification,
        notifyBefore: notifyBefore,
        doctorNote: doctorNote,
      );

      await handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  Future<bool> handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      dataFetcher.sink.add(data);
      return true;
    } catch (e) {
      log("Failed to process data: $e");
      return false;
    }
  }

  @override
  bool handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 400 || error.response?.statusCode == 422) {
        ToastUtil.showShortToast(
            error.response?.data["message"] ?? "Invalid request details");
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
