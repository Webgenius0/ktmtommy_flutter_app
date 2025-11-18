import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';


final class DeleteActivityApi {
  static final DeleteActivityApi _singleton = DeleteActivityApi._internal();

  DeleteActivityApi._internal();

  static DeleteActivityApi get instance => _singleton;

  // Method to call follow/unfollow API using dynamic id
  Future<Map> deleteActivityPostApi({
    required String id, // id should be passed as parameter
  }) async {
    try {
      Response response = await deleteHttp(Endpoints.deleteActivityApi(id));

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Activity deleted successfully 🎉');
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
