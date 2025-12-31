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
                text: '•$bulletContent',
                style: TextStyle(color: Colors.white,fontSize: 14),
              ),
            );
          } else if (line.isNotEmpty) {
            spans.add(
              TextSpan(
                text: line,
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          if (i < lines.length - 1) {
            spans.add(TextSpan(text: '\n'));
          }
        }
      }

      // মূল কোড
      List<TextSpan> spans = [];
      final regex = RegExp(r'\*\*(.*?)\*\*');
      int currentIndex = 0;

      text.splitMapJoin(
        regex,
        onMatch: (Match match) {
          // ** এর আগের টেক্সট যোগ করুন (বুলেট সহ)
          if (currentIndex < match.start) {
            String beforeText = text.substring(currentIndex, match.start);
            addTextWithBullets(beforeText, spans);
          }

          // ** এর ভিতরের টেক্সট (বোল্ড)
          spans.add(
            TextSpan(
              text: match.group(1),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15
              ),
            ),
          );

          // কারেন্ট ইনডেক্স আপডেট করুন
          currentIndex = match.end;
          return '';
        },
        onNonMatch: (String nonMatch) {
          // এটি পুরো টেক্সট ফিরিয়ে দেয়, তাই আমরা currentIndex ব্যবহার করব
          return '';
        },
      );

      // লাস্টে অবশিষ্ট টেক্সট যোগ করুন
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
                  ToastUtil.showLongToast("Test copied");
                },
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  decoration: BoxDecoration(
                    color: Color(0x0CFFF6EE),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      RichText(
                        text: TextSpan(
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


