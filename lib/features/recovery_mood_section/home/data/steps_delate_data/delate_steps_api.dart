import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';


final class DeleteStepsApi {
  static final DeleteStepsApi _singleton = DeleteStepsApi._internal();

  DeleteStepsApi._internal();

  static DeleteStepsApi get instance => _singleton;

  // Method to call follow/unfollow API using dynamic id
  Future<Map> deleteStepsPostApi({
    required String id, // id should be passed as parameter
  }) async {
    try {
      Response response = await deleteHttp(Endpoints.deleteRecentStepApi(id));

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Log Steps deleted successfully 🎉');
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow; // Rethrow the error to be caught in the calling method
    }
  }
}
