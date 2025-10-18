import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';






class RecoveryGoal extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isSelected;

  const RecoveryGoal({
    super.key,
    required this.title,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 8.h),
          decoration: ShapeDecoration(
            color: AppColors.c2A2A2A,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: isSelected ? AppColors.c87B842 : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          child: Text(
            title,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}