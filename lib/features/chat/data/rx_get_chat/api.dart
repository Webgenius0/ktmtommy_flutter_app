





import 'dart:developer';

import 'package:ktmtommy_apps/features/chat/model/chat_history.dart';
import 'package:ktmtommy_apps/networks/dio/dio.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/networks/exception_handler/data_source.dart';



final class GetChatMessageApi {
  static final GetChatMessageApi _singleton = GetChatMessageApi._internal();
  GetChatMessageApi._internal();

  static GetChatMessageApi get instance => _singleton;

  Future<AiChatHistoryDataModel> getChatListInfo( ) async {





    try {
      final response = await getHttp(Endpoints.getChatList());
      if (response.statusCode == 200) {
        return AiChatHistoryDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
