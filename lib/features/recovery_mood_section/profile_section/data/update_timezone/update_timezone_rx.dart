import 'dart:developer';
import 'package:ktmtommy_apps/features/recovery_mood_section/profile_section/data/update_timezone/update_timezone_api.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';

final class UpdateTimezoneRx extends RxResponseInt<Map<String, dynamic>> {
  final api = UpdateTimezoneApi.instance;

  UpdateTimezoneRx({required super.empty, required super.dataFetcher});

  Future<bool> updateTimezone(String timezone) async {
    try {
      Map<String, dynamic> data = await api.updateTimezone(timezone);
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      log("Error updating timezone: $error");
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
      return false;
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
