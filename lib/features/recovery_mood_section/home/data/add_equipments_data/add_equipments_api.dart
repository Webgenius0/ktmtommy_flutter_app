import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class AddEquipmentsApi {
  AddEquipmentsApi._internal();
  static final AddEquipmentsApi _instance = AddEquipmentsApi._internal();
  static AddEquipmentsApi get instance => _instance;

  Future<Map<String, dynamic>> storeEquipments({
    required File image,
    required dynamic name,
    required dynamic type,
    required dynamic note,

  }) async {
    try {
      final multipartImage = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );

      final formData = FormData.fromMap({
        "image": multipartImage,
        "name": name,
        "type": type,
        "note": note,

      });

      final response = await postHttp(Endpoints.addEquipments(), formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data is Map<String, dynamic>
            ? response.data
            : Map<String, dynamic>.from(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException catch (de) {
      throw DataSource.DEFAULT.getFailure();
    } catch (e) {
      rethrow;
    }
  }
}
