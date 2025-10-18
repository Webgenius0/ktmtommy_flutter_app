import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class CustomSleep extends StatelessWidget {
  final Widget image;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CustomSleep({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle, this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(6.sp),
        decoration: ShapeDecoration(
          color: AppColors.c090809,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Column(
          children: [
            image,
            UIHelper.verticalSpace(8.h),
            Text(
              title,
             // 'Sleep',
              textAlign: TextAlign.center,
              style: TextFontStyle.textStylePoppins.copyWith(
                color: AppColors.c757575,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              subtitle,
              style: TextFontStyle.textStylePoppins.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
