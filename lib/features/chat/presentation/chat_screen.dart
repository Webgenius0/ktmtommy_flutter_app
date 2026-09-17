import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
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
  late StreamSubscription _sendingSubscription;
  List<Messages> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;
  XFile? _selectedImage;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    log(">>>>>>>>>>>>>>>>>> this is access token ${appData.read(kKeyAccessToken)}");
    super.initState();
    messageController = TextEditingController();
    _isSending = sendMessageRx.isSending;

    // Get immediate synchronous messages if available
    final initialMsgs = getChatMessageRx.currentMessages;
    if (initialMsgs.isNotEmpty || _isSending) {
      _messages = initialMsgs;
      _isLoading = false;
    }

    // Subscribe to chat updates
    _chatSubscription = getChatMessageRx.combinedStream.listen((chatData) {
      if (mounted) {
        final messages = chatData.data?.messages ?? [];
        setState(() {
          _messages = messages;
          if (_messages.isNotEmpty) {
            _isLoading = false;
          }
        });

        // Scroll to bottom when new messages arrive
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
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

    // Subscribe to sending status updates
    _sendingSubscription = sendMessageRx.isSendingStream.listen((isSending) {
      if (mounted) {
        setState(() {
          _isSending = isSending;
          if (isSending) {
            _isLoading = false;
          }
        });
        if (isSending) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      }
    });

    // Load initial chat history
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    if (_messages.isEmpty && !_isSending) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      await getChatMessageRx.getChatList();
    } catch (error) {
      log("Error loading chat history: $error");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.c181818,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UIHelper.verticalSpace(12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.c454545,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            UIHelper.verticalSpace(20.h),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.deepOrange),
              title: Text('Gallery', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.deepOrange),
              title: Text('Camera', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            UIHelper.verticalSpace(20.h),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage() async {
    final String message = messageController.text.trim();
    final XFile? imageToSend = _selectedImage;

    if ((message.isEmpty && imageToSend == null) || _isSending) return;

    try {
      messageController.clear();
      setState(() {
        _selectedImage = null;
      });

      await sendMessageRx.addChat(
        message: message,
        image: imageToSend,
      );
    } catch (error) {
      log("Error sending message: $error");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send message'),
            backgroundColor: Colors.red,
          ),
        );
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
        image: message.image,
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
    _sendingSubscription.cancel();
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
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFFF55216),
                              ),
                              borderRadius: BorderRadius.circular(21),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x2DF55216),
                                blurRadius: 16,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: const Icon(
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
                      const Spacer(),
                      // Refresh button
                      if (!_isLoading)
                        IconButton(
                          onPressed: _loadChatHistory,
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.deepOrange,
                          ),
                        ),
                    ],
                  ),

                  // Chat Messages
                  Expanded(
                    child: (_isLoading && _messages.isEmpty && !_isSending)
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepOrange,
                            ),
                          )
                        : (_messages.isEmpty && !_isSending)
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      size: 64,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      "Start a conversation with Tom!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
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
                                  return false;
                                },
                                child: ListView.builder(
                                  controller: _scrollController,
                                  reverse: true, // New messages at bottom
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(
                                    top: 16.h,
                                    bottom: 16.h,
                                  ),
                                  itemCount: _messages.length + (_isSending ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (_isSending && index == 0) {
                                      return const AiTypingShimmerWidget();
                                    }
                                    final messageIndex = _isSending ? index - 1 : index;
                                    return _buildMessageWidget(_messages[messageIndex]);
                                  },
                                ),
                              ),
                  ),

                  // Loading indicator when sending
                  // if (_isSending)
                  //   Padding(
                  //     padding: EdgeInsets.only(bottom: 8.h),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         const SizedBox(
                  //           width: 20,
                  //           height: 20,
                  //           child: CircularProgressIndicator(
                  //             strokeWidth: 2,
                  //             color: Colors.deepOrange,
                  //           ),
                  //         ),
                  //         SizedBox(width: 12.w),
                  //         const Text(
                  //           "Tom is typing...",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),

                  // Chat Bottom Bar - ALWAYS VISIBLE
                  ChatBottomBarWidget(
                    chatController: messageController,
                    onSendTap: _sendMessage,
                    isSending: _isSending,
                    selectedImage: _selectedImage,
                    onImagePickTap: _showImagePickerModal,
                    onRemoveImageTap: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
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
