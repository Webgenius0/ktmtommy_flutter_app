import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class SavePrescribedMedicineApi {
  SavePrescribedMedicineApi._internal();
  static final SavePrescribedMedicineApi _instance = SavePrescribedMedicineApi._internal();
  static SavePrescribedMedicineApi get instance => _instance;

  Future<Map<String, dynamic>> storePrescribedMedicine({
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
      final Map<String, dynamic> body = {
        "medicine_name": medicineName,
        "dosage": dosage,
        "dosage_type": dosageType,
        "medicine_type": medicineType,
        "start_date": startDate,
        "before_meal": beforeMeal,
        "notification": notification,
        "notify_before": notifyBefore,
        "doctor_note": doctorNote,
      };

      if (endDate != null) {
        body["end_date"] = endDate;
      }

      for (int i = 0; i < takingTimes.length; i++) {
        body["taking_times[$i]"] = takingTimes[i];
      }

      final formData = FormData.fromMap(body);

      Response response = await postHttp(Endpoints.storePrescribedMedicineApi(), formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Prescribed medicine saved successfully! 🎉');
        return response.data is Map<String, dynamic>
            ? response.data
            : Map<String, dynamic>.from(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException {
      throw DataSource.DEFAULT.getFailure();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updatePrescribedMedicine({
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
      final Map<String, dynamic> body = {
        "medicine_name": medicineName,
        "dosage": dosage,
        "dosage_type": dosageType,
        "medicine_type": medicineType,
        "start_date": startDate,
        "before_meal": beforeMeal,
        "notification": notification,
        "notify_before": notifyBefore,
        "doctor_note": doctorNote,
      };

      if (endDate != null) {
        body["end_date"] = endDate;
      }

      for (int i = 0; i < takingTimes.length; i++) {
        body["taking_times[$i]"] = takingTimes[i];
      }

      final formData = FormData.fromMap(body);

      Response response = await postHttp(Endpoints.updatePrescribedMedicineApi(id), formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Prescribed medicine updated successfully! 🎉');
        return response.data is Map<String, dynamic>
            ? response.data
            : Map<String, dynamic>.from(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException {
      throw DataSource.DEFAULT.getFailure();
    } catch (e) {
      rethrow;
    }
  }
}
