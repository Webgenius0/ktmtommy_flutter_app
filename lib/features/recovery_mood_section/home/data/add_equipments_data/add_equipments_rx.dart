import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/data/add_equipments_data/add_equipments_api.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class AddEquipmentsRx extends RxResponseInt<Map<String, dynamic>> {
  final AddEquipmentsApi _api = AddEquipmentsApi.instance;

  AddEquipmentsRx({required super.empty, required super.dataFetcher});


  ValueStream<Map<String, dynamic>> get responseStream => dataFetcher.stream;

  Future<bool> storeEquipmentsApi({
    required File image,
    required dynamic name,
    required dynamic type,
    required dynamic note,


  }) async {
    try {
      final result = await _api.storeEquipments(
        image: image,
        name: name,
        type: type,
        note: note,
      );

      if (result['success'] == true) {
        final data = Map<String, dynamic>.from(result['data']);
        dataFetcher.sink.add(data);
        return true;
      } else {
        throw Exception(result['message'] ?? "Save failed");
      }
    } catch (e) {
      log("EquipmentStore Rx Error: $e");
      _handleError(e);
      return false;
    }
  }

  void _handleError(dynamic error) {
    String msg = "The image field must not be greater than 5120 kilobytes";

    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map) {
        msg = data['message'] ?? data['error'] ?? msg;
      } else if (data is String) {
        msg = data;
      }
    }

    ToastUtil.showShortToast(msg);
    dataFetcher.sink.addError(error);
  }

  @override
  void handleSuccessWithReturn(Map<String, dynamic> data) {
    dataFetcher.sink.add(data);
  }

  @override
  Future<bool> handleErrorWithReturn(dynamic error) async {
    _handleError(error);
    return false;
  }

  void dispose() => dataFetcher.close();
}