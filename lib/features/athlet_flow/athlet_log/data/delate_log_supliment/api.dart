import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class DeleteLogSupplementApi {
  static final DeleteLogSupplementApi _singleton = DeleteLogSupplementApi._internal();
  DeleteLogSupplementApi._internal();
  static DeleteLogSupplementApi get instance => _singleton;

  Future<Map<dynamic, dynamic>> deleteLogSupplementApi({

    required dynamic id,

  }) async {
    try {
      ///==================== Create JSON payload ====================///


      ///======================= Make POST request ======================///
      Response response = await deleteHttp(Endpoints.deleteLogSupplementApiLink(id:id),);

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