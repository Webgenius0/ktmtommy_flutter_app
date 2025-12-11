// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
// // import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
// //
// // class ChatBottomBarWidget extends StatelessWidget {
// //
// //   final VoidCallback onSendTap;
// //   final TextEditingController chatController;
// //
// //   const ChatBottomBarWidget({
// //     super.key,
// //
// //     required this.onSendTap,
// //     required this.chatController,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       height: 50,
// //       width: double.infinity,
// //       child: Row(
// //         children: [
// //           Flexible(
// //             child: Container(
// //               height: 56,
// //               padding: const EdgeInsets.symmetric(vertical: 4),
// //               decoration: BoxDecoration(
// //                 color: Colors.black,
// //                 borderRadius: BorderRadius.circular(50),
// //               ),
// //               child: TextField(
// //                 cursorColor: Colors.white,
// //                 controller: chatController,
// //                 style: TextFontStyle.textStyle14w400c87B842poppins
// //                     .copyWith(color: Colors.white, fontSize: 14),
// //                 decoration: InputDecoration(
// //                   // prefixIcon: IconButton(
// //                   //   onPressed: onTapAdd,
// //                   //   icon: const Icon(
// //                   //     Icons.add,
// //                   //     color: Colors.white,
// //                   //   ),
// //                   // ),
// //                   // suffixIcon: IconButton(
// //                   //   onPressed: onTapMic,
// //                   //   icon: const Icon(Icons.mic, color: Colors.white),
// //                   // ),
// //                   hintText: "Send a message...",
// //                   hintStyle: TextFontStyle.textStyle14w400c87B842poppins
// //                       .copyWith(color: Colors.white, fontSize: 14),
// //                   contentPadding:
// //                   const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(50),
// //                     borderSide: const BorderSide(color: Colors.transparent),
// //                   ),
// //                   errorBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(50),
// //                     borderSide: const BorderSide(color: Colors.white, width: 1),
// //                   ),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(50),
// //                     borderSide:
// //                     const BorderSide(color: Colors.transparent, width: 1),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(width: 12),
// //           GestureDetector(
// //             onTap: onSendTap,
// //             child: Container(
// //                 height: 50,
// //                 width: 50,
// //                 padding: EdgeInsets.all(10.r),
// //                 decoration: BoxDecoration(
// //                     color: Colors.deepOrange,
// //                     borderRadius: BorderRadius.circular(50.r)
// //                 ),
// //                 child: SvgPicture.asset(AppIcons.sendicon,color: Colors.white,)
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
//
// class ChatBottomBarWidget extends StatelessWidget {
//   final TextEditingController chatController;
//   final VoidCallback onSendTap;
//   final bool isSending;
//
//   const ChatBottomBarWidget({
//     super.key,
//     required this.chatController,
//     required this.onSendTap,
//     this.isSending = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(
//           color: Colors.deepOrange.withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: chatController,
//               style: TextFontStyle.textStyle14w400c87B842poppins,
//               decoration: InputDecoration(
//                 hintText: "Type your message...",
//                 hintStyle: TextFontStyle.textStyle14w400c87B842poppins
//                     .copyWith(color: Colors.white.withOpacity(0.5)),
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 16.w,
//                   vertical: 12.h,
//                 ),
//               ),
//               maxLines: 3,
//               minLines: 1,
//               onSubmitted: (value) {
//                 if (!isSending && value.trim().isNotEmpty) {
//                   onSendTap();
//                 }
//               },
//             ),
//           ),
//           SizedBox(width: 8.w),
//           GestureDetector(
//             onTap: isSending ? null : onSendTap,
//             child: Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: isSending
//                     ? Colors.deepOrange.withOpacity(0.5)
//                     : Colors.deepOrange,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.deepOrange.withOpacity(0.3),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: isSending
//                     ? SizedBox(
//                   width: 16,
//                   height: 16,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: Colors.white,
//                   ),
//                 )
//                     : Icon(
//                   Icons.send,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:shimmer/shimmer.dart'; // shimmer package add করুন

class ChatBottomBarWidget extends StatelessWidget {
  final VoidCallback onSendTap;
  final TextEditingController chatController;
  final bool isLoading; // নতুন parameter যোগ করুন
  final bool isSending; // অথবা যদি message পাঠানোর সময় দেখাতে চান

  const ChatBottomBarWidget({
    super.key,
    required this.onSendTap,
    required this.chatController,
    this.isLoading = false, // ডিফল্ট false
    this.isSending = false, // ডিফল্ট false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              child: TextField(
                cursorColor: Colors.white,
                controller: chatController,
                enabled: !isLoading && !isSending, // লোডিং বা সেন্ডিং থাকলে disable
                style: TextFontStyle.textStyle14w400c87B842poppins
                    .copyWith(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: isLoading ? "Loading..." :
                  isSending ? "Sending..." : "Send a message...",
                  hintStyle: TextFontStyle.textStyle14w400c87B842poppins
                      .copyWith(
                      color: isLoading || isSending ? Colors.grey : Colors.white,
                      fontSize: 14
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
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
                    borderSide:
                    const BorderSide(color: Colors.transparent, width: 1),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                    const BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Condition 1: যদি isLoading true হয় (পুরো widget shimmer)
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
                  color: Colors.grey[700],
                ),
              ),
            ),

            GestureDetector(
              onTap: isSending?null: onSendTap,
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
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  AppIcons.sendicon,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}