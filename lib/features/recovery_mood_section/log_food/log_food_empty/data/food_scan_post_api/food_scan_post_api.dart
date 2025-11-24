import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class FoodScanPostApi {
  static final FoodScanPostApi _singleton =
  FoodScanPostApi._internal();
  FoodScanPostApi._internal();
  static FoodScanPostApi get instance => _singleton;

  Future<Map<String, dynamic>> foodScanApi({
    required File image,
  }) async {
    try {
      // Convert File to MultipartFile
      String fileName = image.path.split('/').last;
      MultipartFile multipartImage = await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      );

      FormData formData = FormData.fromMap({
        "image": multipartImage,
      });

      Response response = await postHttp(Endpoints.pstFoodScanApi(), formData);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast(" Food scan successful");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
