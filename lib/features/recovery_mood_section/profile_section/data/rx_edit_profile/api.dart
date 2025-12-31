import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class EditProfileApi {
  static final EditProfileApi _singleton = EditProfileApi._internal();

  EditProfileApi._internal();

  static EditProfileApi get instance => _singleton;

  Future<Map<String, dynamic>> editProfileApi({


    XFile? avatar,    String? name,
  }) async {
    try {
      MultipartFile? avatarFile;
      MultipartFile? coverFile;

      if (avatar != null && await File(avatar.path).exists()) {
        avatarFile = await MultipartFile.fromFile(avatar.path);
      }


      FormData data = FormData.fromMap({
        "name": name?.toString().trim(),

        if (avatarFile != null) "avatar": avatarFile,

      });

      Response response = await postHttp(Endpoints.postEditProfileApiLink(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException catch (error) {
      print("DioException caught: ${error.response?.statusCode}");

      if (error.response != null) {
        final responseData = error.response!.data;
        final errorMessage = () {
          if (responseData is Map<String, dynamic>) {
            final message = responseData["message"];
            if (message is String) return message;
            if (message is Map) {
              return message.values
                  .whereType<List>()
                  .expand((e) => e)
                  .join("\n");
            }
          }
          return "An unexpected error occurred";
        }();

        ToastUtil.showShortToast(errorMessage);
        print("API Error Response: ${json.encode(responseData)}");
      } else {
        ToastUtil.showShortToast("Network error occurred. Please try again.");
      }

      rethrow;
    } catch (error) {
      print("Unexpected error: $error");
      ToastUtil.showShortToast("An unexpected error occurred.");
      rethrow;
    }
  }
}
