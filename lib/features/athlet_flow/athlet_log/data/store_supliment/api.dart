


import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class StoreSupplementApi {
  static final StoreSupplementApi _singleton = StoreSupplementApi._internal();
  StoreSupplementApi._internal();
  static StoreSupplementApi get instance => _singleton;

  Future<Map<dynamic, dynamic>> storeSupplementApiData({

    required dynamic type,
    required dynamic name,
    required dynamic amount,
    required dynamic amountUnit,
    required dynamic withMeal,
    required dynamic takenAt,
    required dynamic waterIntake,
    required dynamic glassOfWater,
    required dynamic note,


  }) async {
    try {
      ///==================== Create JSON payload ====================///
      final data = {
        'type': type,
        'name': name,
        'amount': amount,
        'amount_unit': amountUnit,
        'with_meal': withMeal,
        'taken_at': takenAt,
        'water_intake': waterIntake,
        'glass_of_water':glassOfWater,
        'note': note,


      };

      ///======================= Make POST request ======================///
      Response response = await postHttp(Endpoints.storeSupplementApiLink(), data);

      log("Recovery Register API Response: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data is String
            ? json.decode(response.data)
            : (response.data as Map<dynamic, dynamic>);

        if (responseData['success'] == true) {
          ToastUtil.showShortToast(responseData['message'] ?? 'Registration Successful');
          return responseData;
        } else {
          throw Exception(responseData['message'] ?? 'Registration Failed');
        }
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error during registration: $error");
      rethrow;
    }
  }
}