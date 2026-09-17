import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/features/chat/data/rx_get_chat/rx.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class SendMessageRx extends RxResponseInt<Map> {
  final api = AddMessageApi.instance;
  final GetChatMessageRx chatHistoryRx;
  final BehaviorSubject<bool> _isSendingSubject =
      BehaviorSubject<bool>.seeded(false);

  SendMessageRx({
    required super.empty,
    required super.dataFetcher,
    required this.chatHistoryRx,
  });

  ValueStream get chatListStream => dataFetcher.stream;
  Stream<bool> get isSendingStream => _isSendingSubject.stream;
  bool get isSending => _isSendingSubject.value;

  Future<Map?> addChat({
    String? message,
    XFile? image,
  }) async {
    try {
      _isSendingSubject.add(true);
      // 1. Add user message locally for instant UI update
      chatHistoryRx.addLocalMessage(
        role: "user",
        message: message ?? "",
        image: image?.path,
        isTemporary: true,
      );

      // 2. Send to server
      final data = await api.addChat(message: message, image: image);

      // 3. If successful, add AI response locally
      if (data['success'] == true) {
        // Remove temporary user message
        chatHistoryRx.removeTemporaryMessages();

        // Add actual user message from server (if returned)
        chatHistoryRx.addLocalMessage(
          role: "user",
          message: message ?? "",
          image: data['data']?['image'] ?? image?.path,
          isTemporary: false,
        );

        // Add AI response
        final aiResponse = data['data']?['reply'] ??
            data['data']?['message'] ??
            "No response";
        chatHistoryRx.addLocalMessage(
          role: "assistant",
          message: aiResponse,
          isTemporary: false,
        );
      }

      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      // Remove temporary message on error
      chatHistoryRx.removeTemporaryMessages();
      handleErrorWithReturn(error);
      return null;
    } finally {
      _isSendingSubject.add(false);
    }
  }

  @override
  void dispose() {
    _isSendingSubject.close();
    super.dispose();
  }
}