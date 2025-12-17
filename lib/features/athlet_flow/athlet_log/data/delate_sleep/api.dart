import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class DeleteSleepApi {
  static final DeleteSleepApi _singleton = DeleteSleepApi._internal();
  DeleteSleepApi._internal();
  static DeleteSleepApi get instance => _singleton;

  Future<Map<dynamic, dynamic>> deleteSleepApi({

    required dynamic id,

  }) async {
    try {
      ///==================== Create JSON payload ====================///


      ///======================= Make POST request ======================///
      Response response = await deleteHttp(Endpoints.deleteSleepGetApiLink(id:id),);

      log("Recovery Register API Response: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data is String
            ? json.decode(response.data)
            : (response.data as Map<dynamic, dynamic>);

        if (responseData['success'] == true) {
          ToastUtil.showShortToast(responseData['message'] ?? 'Delate Successful');
          return responseData;
        } else {
          throw Exception(responseData['message'] ?? 'Delate Failed');
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