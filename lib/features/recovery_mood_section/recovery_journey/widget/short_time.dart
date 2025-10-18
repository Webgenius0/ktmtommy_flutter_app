import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';







class ShortTime extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

   const ShortTime({
    super.key, required this.text, required this.isSelected, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: AppColors.c2A2A2A,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide(
              color: isSelected ? AppColors.c87B842 : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Text(
              text,
            //  'Short\nTerm',
              textAlign: TextAlign.center,
              maxLines: 2,


              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,fontWeight: FontWeight.w400
              )
          ),
        ),
      ),
    );
  }
}