import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:shimmer/shimmer.dart';

class ChatBottomBarWidget extends StatelessWidget {
  final VoidCallback onSendTap;
  final TextEditingController chatController;
  final bool isLoading;
  final bool isSending;
  final XFile? selectedImage;
  final VoidCallback? onImagePickTap;
  final VoidCallback? onRemoveImageTap;

  const ChatBottomBarWidget({
    super.key,
    required this.onSendTap,
    required this.chatController,
    this.isLoading = false,
    this.isSending = false,
    this.selectedImage,
    this.onImagePickTap,
    this.onRemoveImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preview thumbnail for selected image
        if (selectedImage != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.deepOrange.withOpacity(0.6),
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.file(
                      File(selectedImage!.path),
                      width: 70.w,
                      height: 70.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: -6.h,
                  right: -6.w,
                  child: GestureDetector(
                    onTap: onRemoveImageTap,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(4.r),
                      child: Icon(
                        Icons.cancel,
                        size: 18.sp,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      // Image Icon Button
                      IconButton(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        constraints: const BoxConstraints(),
                        onPressed: (isLoading || isSending) ? null : onImagePickTap,
                        icon: Icon(
                          Icons.image_outlined,
                          color: selectedImage != null ? Colors.deepOrange : Colors.grey,
                          size: 24.sp,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          cursorColor: Colors.white,
                          controller: chatController,
                          enabled: !isLoading && !isSending,
                          style: TextFontStyle.textStyle14w400c87B842poppins
                              .copyWith(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: isLoading
                                ? "Loading..."
                                : isSending
                                    ? "Sending..."
                                    : "Send a message...",
                            hintStyle: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                              color: isLoading || isSending ? Colors.grey : Colors.white54,
                              fontSize: 14,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(color: Colors.white, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(color: Colors.transparent, width: 1),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              if (isLoading)
                Shimmer.fromColors(
                  baseColor: Colors.grey[700]!,
                  highlightColor: Colors.grey[500]!,
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: SvgPicture.asset(
                      AppIcons.sendicon,
                      colorFilter: ColorFilter.mode(
                        Colors.grey[700]!,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                )
              else
                GestureDetector(
                  onTap: isSending ? null : onSendTap,
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(50.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      AppIcons.sendicon,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}