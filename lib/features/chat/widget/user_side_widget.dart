import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class UserChatWidget extends StatelessWidget {
  final String message;

  final String time;
  const UserChatWidget({super.key, required this.message,    required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(

            onLongPress: () {
              Clipboard.setData(ClipboardData(text: message));
              ToastUtil.showLongToast("Test copied");
            },
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              decoration: const BoxDecoration(
                color: Color(0x33F55216),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: TextFontStyle.textStyle14w400c87B842poppins
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white),
                  ),
                  Text(
                    time,
                    style: TextFontStyle.textStyle14w400c87B842poppins
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white60),
                  ),
                ],
              ),
            ),
          ),
          UIHelper.horizontalSpace(10),
        ],
      ),
    );
  }
}
