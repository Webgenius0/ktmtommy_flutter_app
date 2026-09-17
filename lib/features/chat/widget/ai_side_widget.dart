import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';


class AdminChatWidget extends StatelessWidget {
  final String message;
  final String time;


  const AdminChatWidget({
    super.key,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {





    List<TextSpan> parseFormattedText(String text) {
      void addTextWithBullets(String text, List<TextSpan> spans) {
        if (text.isEmpty) return;

        List<String> lines = text.split('\n');

        for (int i = 0; i < lines.length; i++) {
          String line = lines[i];

          if (line.trim().startsWith('-')) {
            String bulletContent = line.trim().substring(1).trim();

            spans.add(
              TextSpan(
                text: '• $bulletContent',
                style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                  color: Colors.white,
                  fontSize: 14.sp,
                  height: 1.4,
                ),
              ),
            );
          } else if (line.isNotEmpty) {
            spans.add(
              TextSpan(
                text: line,
                style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                  color: Colors.white,
                  fontSize: 14.sp,
                  height: 1.4,
                ),
              ),
            );
          }

          if (i < lines.length - 1) {
            spans.add(const TextSpan(text: '\n'));
          }
        }
      }

      List<TextSpan> spans = [];
      final regex = RegExp(r'\*\*(.*?)\*\*');
      int currentIndex = 0;

      text.splitMapJoin(
        regex,
        onMatch: (Match match) {
          if (currentIndex < match.start) {
            String beforeText = text.substring(currentIndex, match.start);
            addTextWithBullets(beforeText, spans);
          }

          spans.add(
            TextSpan(
              text: match.group(1),
              style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
          );

          currentIndex = match.end;
          return '';
        },
        onNonMatch: (String nonMatch) {
          return '';
        },
      );

      if (currentIndex < text.length) {
        String remainingText = text.substring(currentIndex);
        addTextWithBullets(remainingText, spans);
      }

      return spans;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              UIHelper.horizontalSpace(5.w),
              GestureDetector(
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: message));
                  ToastUtil.showLongToast("Text copied");
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0x0CFFF6EE),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                            color: Colors.white,
                            fontSize: 14.sp,
                            height: 1.4,
                          ),
                          children: parseFormattedText(message),
                        ),
                      ),



                      // Text(
                      //   message,
                      //   style: TextFontStyle.textStyle14w400c87B842poppins
                      //       .copyWith(fontWeight: FontWeight.w700, fontSize: 14,color: Colors.white),
                      // ),
                      Text(
                        time,
                        style: TextFontStyle.textStyle14w400c87B842poppins
                            .copyWith(fontWeight: FontWeight.w700, fontSize: 12,color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AiTypingShimmerWidget extends StatefulWidget {
  const AiTypingShimmerWidget({super.key});

  @override
  State<AiTypingShimmerWidget> createState() => _AiTypingShimmerWidgetState();
}

class _AiTypingShimmerWidgetState extends State<AiTypingShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              UIHelper.horizontalSpace(5.w),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0x0CFFF6EE),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tom is typing",
                      style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                        color: Colors.white70,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(3, (index) {
                            final delay = index * 0.25;
                            final value = (_controller.value - delay) % 1.0;
                            final opacity = (value < 0.5 ? value * 2 : (1.0 - value) * 2).clamp(0.2, 1.0);
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: 6.r,
                              height: 6.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepOrangeAccent.withOpacity(opacity),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


