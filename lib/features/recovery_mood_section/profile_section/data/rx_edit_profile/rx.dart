import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/streams.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'api.dart';

final class EditProfileApiRx extends RxResponseInt<Map<String, dynamic>> {
  final api = EditProfileApi.instance;

  EditProfileApiRx({required super.empty, required super.dataFetcher});

  ValueStream<Map<String, dynamic>> get getFileData => dataFetcher.stream;

  Future<bool> editProfileInfo({

    XFile? avatar,
    String? name,
  }) async {
    try {
      Map data = await api.editProfileApi(
        name: name,
        avatar: avatar,

      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error, stackTrace) {
      log("Error in setProfileApi: $error", stackTrace: stackTrace);
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(dynamic data) {
    ToastUtil.showShortToast(data["message"]);
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    String errorMessage = "Something went wrong.";
    if (error is DioException && error.response != null) {
      final responseData = error.response!.data;
      if (responseData is Map<String, dynamic>) {
        final msg = responseData["message"];
        if (msg is String) {
          errorMessage = msg;
        } else if (msg is Map) {
          errorMessage = msg.values
              .whereType<List>()
              .expand((e) => e)
              .join("\n");
        }
      }
    }

    ToastUtil.showShortToast(errorMessage);
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}

