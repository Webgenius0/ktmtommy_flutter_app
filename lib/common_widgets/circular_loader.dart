// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'loading_indicators.dart';
//
// class CircularLoader extends StatelessWidget {
//   final double? height;
//   final double? width;
//   const CircularLoader({
//     super.key,  this.height,  this.width,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: height ?? 80.h,
//           width: height ?? 80.w,
//           child: Center(
//             child: loadingIndicator(
//                 context: context,
//                 color: Colors.transparent),
//           ),
//         ),
//       ],
//     );
//   }
// }