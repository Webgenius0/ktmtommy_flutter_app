import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/data/dietitian_settings_api.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/model/dietitian_settings_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../networks/rx_base.dart';

final class DietitianSettingsRx extends RxResponseInt<DietitianSettingsModel> {
  final api = DietitianSettingsApi.instance;

  DietitianSettingsRx({required super.empty, required super.dataFetcher});

  ValueStream<DietitianSettingsModel> get dietitianSettingsStream => dataFetcher.stream;

  Future<void> getDietitianSettings() async {
    try {
      DietitianSettingsModel data = await api.getDietitianSettings();
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  Future<DietitianSettingsModel?> postDietitianSettings({
    required dynamic isEnabled,
    required String name,
    required String dietitianEmail,
    required String sendTime,
  }) async {
    try {
      DietitianSettingsModel data = await api.postDietitianSettings(
        isEnabled: isEnabled,
        name: name,
        dietitianEmail: dietitianEmail,
        sendTime: sendTime,
      );
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
      return null;
    }
  }

  @override
  handleSuccessWithReturn(DietitianSettingsModel data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
