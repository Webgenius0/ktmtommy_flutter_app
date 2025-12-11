import 'package:ktmtommy_apps/features/chat/data/rx_get_chat/rx.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class SendMessageRx extends RxResponseInt<Map> {
  final api = AddMessageApi.instance;
  final GetChatMessageRx chatHistoryRx;

  SendMessageRx({
    required super.empty,
    required super.dataFetcher,
    required this.chatHistoryRx,
  });

  ValueStream get chatListStream => dataFetcher.stream;

  Future<Map?> addChat({required String message}) async {
    try {
      // 1. Add user message locally for instant UI update
      chatHistoryRx.addLocalMessage(
        role: "user",
        message: message,
        isTemporary: true,
      );

      // 2. Send to server
      final data = await api.addChat(message: message);

      // 3. If successful, add AI response locally
      if (data != null && data['success'] == true) {
        // Remove temporary user message
        chatHistoryRx.removeTemporaryMessages();

        // Add actual user message from server (if returned)
        chatHistoryRx.addLocalMessage(
          role: "user",
          message: message,
          isTemporary: false,
        );

        // Add AI response
        final aiResponse = data['data']['reply'] ?? "No response";
        chatHistoryRx.addLocalMessage(
          role: "assistant",
          message: aiResponse,
          isTemporary: false,
        );

        // Refresh full chat history from server to ensure consistency
        // await chatHistoryRx.getChatList();
      }

      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      // Remove temporary message on error
      chatHistoryRx.removeTemporaryMessages();
      handleErrorWithReturn(error);
      return null;
    }
  }
}