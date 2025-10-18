// import 'package:dotlottie_loader/dotlottie_loader.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
//
//
// Widget loadingIndicator({
//   required BuildContext context,
//   Color? color,
//   double? size,
// }) {
//   return DotLottieLoader.fromAsset(Assets.lottie.loading,
//       frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
//     if (dotlottie != null) {
//       return Center(
//         child: Container(
//           child: Lottie.memory(dotlottie.animations.values.single,
//               height: 200.sp, width: 200.sp),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   });
// }
//
// Widget shimmer({
//   String? name,
//   required BuildContext context,
//   Color? color,
//   double? size,
// }) {
//   return Center(
//     child: Container(
//       child: Lottie.asset(name ?? Assets.lottie.hamburger,
//           width: size, height: size),
//     ),
//   );
// }
