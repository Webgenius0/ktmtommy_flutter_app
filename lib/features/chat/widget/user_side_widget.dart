import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';

class UserChatWidget extends StatelessWidget {
  final String message;
  final String? image;
  final String time;

  const UserChatWidget({
    super.key,
    required this.message,
    this.image,
    required this.time,
  });

  Widget _buildImageWidget(BuildContext context) {
    if (image == null || image!.isEmpty) return const SizedBox.shrink();

    final isLocalFile = File(image!).existsSync();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: isLocalFile
            ? Image.file(
                File(image!),
                width: 200,
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                imageUrl: image!.startsWith("http") ? image! : "$baseUrl/${image!}",
                width: 200,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 120,
                  width: 200,
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.deepOrange),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image,
                  color: Colors.white54,
                  size: 40,
                ),
              ),
      ),
    );
  }

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
              if (message.isNotEmpty) {
                Clipboard.setData(ClipboardData(text: message));
                ToastUtil.showLongToast("Text copied");
              }
            },
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
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
                  if (image != null && image!.isNotEmpty) _buildImageWidget(context),
                  if (message.isNotEmpty)
                    Text(
                      message,
                      style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        height: 1.4,
                        color: Colors.white,
                      ),
                    ),
                  Text(
                    time,
                    style: TextFontStyle.textStyle14w400c87B842poppins
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white60),
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
