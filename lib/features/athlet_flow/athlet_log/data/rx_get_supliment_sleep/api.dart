import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/model/GetAllSleep.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/model/log_suppliment_data_model.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetLogSupplementApi {
  static final GetLogSupplementApi _singleton = GetLogSupplementApi._internal();
  GetLogSupplementApi._internal();

  static GetLogSupplementApi get instance => _singleton;

  Future<LogSupplementModelData> getLogSupplement() async {
    try {
      Response response = await getHttp(Endpoints.getLogSupplementApiLink());
      if (response.statusCode == 200) {
        final data =  LogSupplementModelData.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
