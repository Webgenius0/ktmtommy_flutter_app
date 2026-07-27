import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class DeleteAccountApi {
  static final DeleteAccountApi _singleton = DeleteAccountApi._internal();

  DeleteAccountApi._internal();

  static DeleteAccountApi get instance => _singleton;

  /// Method to delete the user account
  Future<Map<String, dynamic>> deleteAccount() async {
    try {
      Response response = await deleteHttp(Endpoints.deleteAccount());

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
