import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/chat/model/chat_history.dart';
import 'package:ktmtommy_apps/features/chat/widget/ai_side_widget.dart';
import 'package:ktmtommy_apps/features/chat/widget/sendbar_widget.dart';
import 'package:ktmtommy_apps/features/chat/widget/user_side_widget.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  late TextEditingController messageController;
  late StreamSubscription _chatSubscription;
  List<Messages> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    log(">>>>>>>>>>>>>>>>>> this is access token ${appData.read(kKeyAccessToken)}");
    super.initState();
    messageController = TextEditingController();

    // Subscribe to chat updates
    _chatSubscription = getChatMessageRx.combinedStream.listen((chatData) {
      if (mounted) {
        setState(() {
          _messages = chatData.data?.messages ?? [];
          _isLoading = false;
        });

        // Scroll to bottom when new messages arrive
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    }, onError: (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });

    // Load initial chat history
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    try {
      await getChatMessageRx.getChatList();
    } catch (error) {
      log("Error loading chat history: $error");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendMessage() async {
    final String message = messageController.text.trim();
    if (message.isEmpty || _isSending) return;

    setState(() {
      _isSending = true;
    });

    try {
      await sendMessageRx.addChat(message: message);
    } catch (error) {
      log("Error sending message: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send message'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
          messageController.clear();
        });
      }
    }
  }

  String _formatTime(String? createdAt) {
    if (createdAt == null) return "";

    try {
      final dateTime = DateTime.parse(createdAt);
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return "";
    }
  }

  Widget _buildMessageWidget(Messages message) {
    final formattedTime = _formatTime(message.createdAt);

    if (message.role == "user") {
      return UserChatWidget(
        time: formattedTime,
        message: message.message ?? "",
      );
    } else {
      return AdminChatWidget(
        message: message.message ?? "",
        time: formattedTime,
      );
    }
  }

  @override
  void dispose() {
    _chatSubscription.cancel();
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.chatBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigationService.goBack;
                        },
                        child: Container(
                          width: 42,
                          height: 42,
                          padding: const EdgeInsets.all(9),
                          decoration: ShapeDecoration(
                            color: const Color(0x99090809),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFF55216),
                              ),
                              borderRadius: BorderRadius.circular(21),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x2DF55216),
                                blurRadius: 16,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      ),
                      UIHelper.horizontalSpace(12.w),
                      Text(
                        "Outrageous Tom",
                        style: TextFontStyle.textStyle20w700c000000poppins
                            .copyWith(color: Colors.deepOrange),
                      ),
                      Spacer(),
                      // Refresh button
                      if (!_isLoading)
                        IconButton(
                          onPressed: _loadChatHistory,
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.deepOrange,
                          ),
                        ),
                    ],
                  ),

                  // Chat Messages
                  Expanded(
                    child: _isLoading
                        ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    )
                        : _messages.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Start a conversation with Tom!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Send a message to begin chatting",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    )
                        : NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        // Handle scroll events if needed
                        return false;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        reverse: true, // New messages at bottom
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          top: 16.h,
                          bottom: 16.h,
                        ),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return _buildMessageWidget(_messages[index]);
                        },
                      ),
                    ),
                  ),

                  // Loading indicator when sending
                  if (_isSending)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.deepOrange,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "Tom is typing...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Chat Bottom Bar - ALWAYS VISIBLE
                  ChatBottomBarWidget(
                    chatController: messageController,
                    onSendTap: _sendMessage,
                    isSending: _isSending,
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


