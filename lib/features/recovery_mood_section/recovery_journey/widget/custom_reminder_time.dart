import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class CustomReminderTime extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isSelected;
   const CustomReminderTime({
    super.key,
    required this.title,
    required this.subtitle, this.onTap, required this.isSelected,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 3.w),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
             side: BorderSide(width: 2,    color: isSelected ? AppColors.c87B842 : AppColors.c5E5E5E,),

            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Text(
            title,
              maxLines: 1,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            UIHelper.verticalSpace(10.h),
            Text(
              subtitle,
              maxLines: 1,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
