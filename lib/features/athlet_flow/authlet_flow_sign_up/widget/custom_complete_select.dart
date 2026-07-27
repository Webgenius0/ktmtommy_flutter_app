import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';




class CustomCompleteSelect extends StatelessWidget {
  final String title;
  final bool isSelected;
  const CustomCompleteSelect({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
      decoration: ShapeDecoration(
        color: isSelected ? AppColors.c111111 : AppColors.c1C1C1C,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: isSelected ? AppColors.orangeColor : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
            fontSize: 22.sp,
            color: isSelected ? AppColors.orangeColor : AppColors.cFFFFFF,
            letterSpacing: 1.1,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}
