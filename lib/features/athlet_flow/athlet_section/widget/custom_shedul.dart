import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class CustomShedul extends StatelessWidget {
  final String text;
  final VoidCallback? onPillTap;

  const CustomShedul({
    super.key,
    required this.text,
    this.onPillTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: TextAlign.start,
          style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
        ),
        UIHelper.verticalSpace(8.h),
        GestureDetector(
          onTap: onPillTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.c181818,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.orangeColor,
                width: 1.0,
              ),
            ),
            child: Text(
              '🏁 TRIATHLON — Week 2 • Day 8 >',
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}