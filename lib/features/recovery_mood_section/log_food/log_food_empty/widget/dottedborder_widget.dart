import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class DottedborderWidget extends StatelessWidget {

  final String title;

  const  DottedborderWidget({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 1.5,
      dashPattern: [10, 4],
      borderType: BorderType.RRect,
      radius: Radius.circular(12.r),
      color: AppColors.c454545,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.c000000,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
          child: Column(
            children: [
              Image.asset(AppImages.camera, height: 80.h),
              UIHelper.verticalSpace(24.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle14w400cD1D1D1poppins.copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
