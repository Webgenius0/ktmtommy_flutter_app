import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

class AddMessageApi {
  static final AddMessageApi _singleton = AddMessageApi._internal();
  AddMessageApi._internal();

  static AddMessageApi get instance => _singleton;

  Future<Map> addChat({
    String? message,
    XFile? image,
  }) async {
    try {
      MultipartFile? imageFile;
      if (image != null && await File(image.path).exists()) {
        imageFile = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }

      dynamic body;
      if (imageFile != null) {
        body = FormData.fromMap({
          if (message != null && message.trim().isNotEmpty) "message": message.trim(),
          "image": imageFile,
        });
      } else {
        body = {
          "message": message ?? "",
        };
      }

      Response response = await postHttp(Endpoints.sendMessageForAi(), body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      throw ErrorHandler.handle(error).failure.responseMessage;
    }
  }
}
