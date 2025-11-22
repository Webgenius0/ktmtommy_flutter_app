import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/model/get_all_food_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class GetAllFoodApi  {
  static final GetAllFoodApi _singleton = GetAllFoodApi._internal();
  GetAllFoodApi._internal();

  static GetAllFoodApi get instance => _singleton;

  Future<GetAllFoodModel> getAllFoodScreeApi() async {
    try {
      Response response = await getHttp(
        Endpoints.getAllFoodDataApi(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data =
        json.decode(json.encode(response.data));

        return GetAllFoodModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}

