import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/model/get_all_equipment_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class GetAllEquipmentApi  {
  static final GetAllEquipmentApi _singleton = GetAllEquipmentApi._internal();
  GetAllEquipmentApi._internal();

  static GetAllEquipmentApi get instance => _singleton;

  Future<GetAllEquipmentModel> getAllEquipmentScreenApi() async {
    try {
      Response response = await getHttp(
        Endpoints.getAllEquipments(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data =
        json.decode(json.encode(response.data));

        return GetAllEquipmentModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}

