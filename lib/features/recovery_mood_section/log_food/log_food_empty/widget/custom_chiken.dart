import 'dart:developer';
import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class CustomChiken extends StatelessWidget {
  final String text;
  final String? imagePath;

  const CustomChiken({
    super.key,
    required this.text,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final foodName = appData.read(kKeyFoodName);
    final totalCalories = appData.read(kKeyTotalCalories);
    log('========>>>>>>>>>Food Name: ${appData.read(kKeyFoodName)}');
    log('========>>>>>>>>>TotalCalories: ${appData.read(kKeyTotalCalories)}');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              imagePath != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  File(imagePath!),
                  height: 32.h,
                  width: 32.h,
                  fit: BoxFit.cover,
                ),
              )
                  : Image.asset(AppImages.retakeimage, height: 32.h),
              UIHelper.horizontalSpace(8.w),
              Text(
                  text,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500
                  )
              )
            ],
          ),
          UIHelper.verticalSpace(18.h),
          Row(
            children: [
              Image.asset(AppImages.agunimage, height: 32.h),
              UIHelper.horizontalSpace(8.w),
              Text('$totalCalories', style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500
              )),
              UIHelper.horizontalSpace(9.w),
              Text('estimated calories', style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
              ))
            ],
          ),
        ],
      ),
    );
  }
}