
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ktmtommy_apps/features/chat/model/chat_history.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/networks/rx_base.dart';
import 'api.dart';

final class GetChatMessageRx extends RxResponseInt<AiChatHistoryDataModel> {
  final api = GetChatMessageApi.instance;
  final BehaviorSubject<AiChatHistoryDataModel> _localDataFetcher =
  BehaviorSubject<AiChatHistoryDataModel>.seeded(
    AiChatHistoryDataModel(
      success: true,
      data: Data(messages: []),
      message: "Loading...",
    ),
  );
  late final Stream<AiChatHistoryDataModel> _combinedStream;

  GetChatMessageRx({required super.empty, required super.dataFetcher}) {
    // Combine both streams: server data and local updates
    // Use startWith(dataFetcher.valueOrNull) so combinedStream emits immediately upon subscription
    _combinedStream = Rx.combineLatest2<AiChatHistoryDataModel?,
        AiChatHistoryDataModel, AiChatHistoryDataModel>(
      dataFetcher.stream
          .cast<AiChatHistoryDataModel?>()
          .startWith(dataFetcher.valueOrNull),
      _localDataFetcher.stream,
      (AiChatHistoryDataModel? serverData, AiChatHistoryDataModel localData) {
        if (serverData != null && serverData.success == true) {
          final serverMessages = serverData.data?.messages ?? [];
          final localMessages = localData.data?.messages ?? [];

          final List<Messages> combinedMessages = <Messages>[...serverMessages];

          for (final localMsg in localMessages) {
            if (!combinedMessages.any((serverMsg) =>
                serverMsg.message == localMsg.message &&
                serverMsg.createdAt == localMsg.createdAt)) {
              combinedMessages.add(localMsg);
            }
          }

          combinedMessages.sort((a, b) {
            try {
              final timeA = DateTime.parse(a.createdAt ?? '');
              final timeB = DateTime.parse(b.createdAt ?? '');
              return timeB.compareTo(timeA); // Descending order
            } catch (e) {
              return 0;
            }
          });

          return AiChatHistoryDataModel(
            success: true,
            data: Data(messages: combinedMessages),
            message: serverData.message,
          );
        }
        return localData;
      },
    ).asBroadcastStream();
  }

  Stream<AiChatHistoryDataModel> get combinedStream => _combinedStream;

  List<Messages> get currentMessages {
    final localData = _localDataFetcher.valueOrNull;
    final serverData = dataFetcher.valueOrNull;

    final localMessages = localData?.data?.messages ?? [];
    final serverMessages = serverData?.data?.messages ?? [];

    if (serverData != null &&
        serverData.success == true &&
        serverMessages.isNotEmpty) {
      final List<Messages> combined = [...serverMessages];
      for (final localMsg in localMessages) {
        if (!combined.any((s) =>
            s.message == localMsg.message &&
            s.createdAt == localMsg.createdAt)) {
          combined.add(localMsg);
        }
      }
      combined.sort((a, b) {
        try {
          final timeA = DateTime.parse(a.createdAt ?? '');
          final timeB = DateTime.parse(b.createdAt ?? '');
          return timeB.compareTo(timeA);
        } catch (e) {
          return 0;
        }
      });
      return combined;
    }
    return localMessages;
  }

  // Add a new message locally (for instant UI update)
  void addLocalMessage({
    required String role,
    required String message,
    String? image,
    bool isTemporary = false,
  }) {
    final currentData = _localDataFetcher.value;
    final newMessage = Messages(
      id: isTemporary ? -1 * DateTime.now().millisecondsSinceEpoch : null,
      role: role,
      message: message,
      image: image,
      createdAt: DateTime.now().toIso8601String(),
    );

    // Create a new list with proper type
    final List<Messages> updatedMessages = [
      newMessage,
      ...(currentData.data?.messages ?? []),
    ];

    final updatedData = AiChatHistoryDataModel(
      success: true,
      data: Data(messages: updatedMessages),
      message: "Local update",
    );

    _localDataFetcher.add(updatedData);
  }

  // Remove temporary messages (when server response comes)
  void removeTemporaryMessages() {
    final currentData = _localDataFetcher.value;
    final List<Messages> filteredMessages = (currentData.data?.messages
        ?.where((msg) => msg.id == null || msg.id! >= 0)
        .toList() ?? []);

    final updatedData = AiChatHistoryDataModel(
      success: true,
      data: Data(messages: filteredMessages),
      message: currentData.message,
    );

    _localDataFetcher.add(updatedData);
  }

  Future<AiChatHistoryDataModel?> getChatList() async {
    try {
      final data = await api.getChatListInfo();
      final result = handleSuccessWithReturn(data);

      // Update local stream with fresh data from server
      if (result != null) {
        final currentLocalMsgs = _localDataFetcher.value.data?.messages ?? [];
        final temporaryMsgs = currentLocalMsgs
            .where((msg) => msg.id != null && msg.id! < 0)
            .toList();
        final serverMsgs = result.data?.messages ?? [];

        final List<Messages> combined = [...temporaryMsgs, ...serverMsgs];

        final updatedData = AiChatHistoryDataModel(
          success: true,
          data: Data(messages: combined),
          message: result.message,
        );
        _localDataFetcher.add(updatedData);
      }

      return result;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final errorMessage = error.response?.data?["error"] ??
          error.response?.data?["message"] ??
          "An unknown error occurred.";

      if (statusCode == 401) {
        appData.write(kKeyIsLoggedIn, false);
        ToastUtil.showLongToast("You are unauthorized");
        // NavigationService.navigateToUntilReplacement(Routes.login);
      } else {
        ToastUtil.showShortToast(errorMessage);
      }
    } else {
      ToastUtil.showShortToast("An unexpected error occurred.");
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }

  @override
  void dispose() {
    _localDataFetcher.close();
    super.dispose();
  }
}