
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class CustomTrainer extends StatefulWidget {
  final String text;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final String imagePath;

  const CustomTrainer({
    super.key,
    required this.text,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap, required this.imagePath,
  });

  @override
  State<CustomTrainer> createState() => _CustomTrainerState();
}

class _CustomTrainerState extends State<CustomTrainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: AppColors.c151515,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(
              color: widget.isSelected ? AppColors.c87B842 : Colors.grey,
              width: 1.w,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [

                 Image.asset(
                    widget.imagePath,
                    height: 70.h,
                     fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: ShapeDecoration(
                        color: widget.isSelected ? AppColors.c87B842 : AppColors.c757575,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.r),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 5.w,
                        ),
                        decoration: ShapeDecoration(
                          color: widget.isSelected ? AppColors.c87B842 : AppColors.c757575,
                          shape: OvalBorder(
                            side: BorderSide(
                              width: 2,
                              color: AppColors.cFFFFFF,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.horizontalSpace(18.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 18.sp,
                      ),
                    ),
                    UIHelper.verticalSpace(6.h),
                    Text(
                      widget.title,
                      style: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    UIHelper.verticalSpace(12.h),
                    Text(
                      widget.subtitle,
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ktmtommy_app/assets_helper/app_colors.dart';
// import 'package:ktmtommy_app/assets_helper/app_fonts.dart';
// import 'package:ktmtommy_app/helpers/ui_helpers.dart';
//
// class CustomTrainer extends StatefulWidget {
//   final String text;
//   final String title;
//   final String subtitle;
//   final bool isSelected;
//   final VoidCallback onTap;
//   final String imagePath; // <-- Changed from Widget to String
//
//   const CustomTrainer({
//     super.key,
//     required this.text,
//     required this.title,
//     required this.subtitle,
//     required this.isSelected,
//     required this.onTap,
//     required this.imagePath, // <-- changed
//   });
//
//   @override
//   State<CustomTrainer> createState() => _CustomTrainerState();
// }
//
// class _CustomTrainerState extends State<CustomTrainer> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         width: double.infinity,
//         decoration: ShapeDecoration(
//           color: AppColors.c151515,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.r),
//             side: BorderSide(
//               color: widget.isSelected ? AppColors.c87B842 : Colors.grey,
//               width: 1.w,
//             ),
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   Image.asset(
//                     widget.imagePath,
//                     height: 70.h,
//                     fit: BoxFit.cover,
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       padding: EdgeInsets.all(3.r),
//                       decoration: ShapeDecoration(
//                         color: widget.isSelected
//                             ? AppColors.c87B842
//                             : AppColors.c757575,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(11.r),
//                         ),
//                       ),
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 5.h,
//                           horizontal: 5.w,
//                         ),
//                         decoration: ShapeDecoration(
//                           color: widget.isSelected
//                               ? AppColors.c87B842
//                               : AppColors.c757575,
//                           shape: OvalBorder(
//                             side: BorderSide(
//                               width: 2,
//                               color: AppColors.cFFFFFF,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               UIHelper.horizontalSpace(18.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.text,
//                       style: TextFontStyle.textStyle24w600cFFFFFFpoppins
//                           .copyWith(
//                         fontSize: 18.sp,
//                       ),
//                     ),
//                     UIHelper.verticalSpace(6.h),
//                     Text(
//                       widget.title,
//                       style: TextFontStyle.textStyle24w400cA3A3A3poppins
//                           .copyWith(
//                         fontSize: 12.sp,
//                       ),
//                     ),
//                     UIHelper.verticalSpace(12.h),
//                     Text(
//                       widget.subtitle,
//                       style: TextFontStyle.textStyle24w600cFFFFFFpoppins
//                           .copyWith(
//                         fontSize: 18.sp,
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
