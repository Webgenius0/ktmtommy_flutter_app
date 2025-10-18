// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../assets_helper/app_colors.dart';
// import '../assets_helper/app_fonts.dart';
//
//
// class ContainerRadio extends StatelessWidget {
//   ContainerRadio({
//     super.key,
//
//     required this.value,
//     required this.onChanged,
//   });
//
//
//   final String value;
//
//   final Function(int) onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 364,
//       height: 52,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: AppColors.cBDBDBD,
//         ),
//         borderRadius: BorderRadius.all(Radius.circular(16)),
//         color: AppColors.cE8E8E8,
//       ),
//       child: Row(
//         children: [
//           // Radio<int>(
//           //   value: value,
//           //   groupValue: groupValue,
//           //   onChanged: (int? newValue) {
//           //     if (newValue != null) {
//           //       onChanged(
//           //           newValue); // Trigger the callback when a radio button is selected
//           //     }
//           //     print('Clicked');
//           //   },
//           // ),
//           Text(
//             "$value",
//             style: TextFontStyle
//                 .textStyle14w400c6B6B6B
//                 .copyWith(fontSize: 13.sp),
//           ),
//         ],
//       ),
//     );
//   }
// }
