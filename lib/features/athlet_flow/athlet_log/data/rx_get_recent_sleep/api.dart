import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/model/GetAllSleep.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetRecentSleepApi {
  static final GetRecentSleepApi _singleton = GetRecentSleepApi._internal();
  GetRecentSleepApi._internal();

  static GetRecentSleepApi get instance => _singleton;

  Future<GetAllSleepDataModel> getHome() async {
    try {
      Response response = await getHttp(Endpoints.saveSleepGetApiLink());
      if (response.statusCode == 200) {
        final data =  GetAllSleepDataModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
