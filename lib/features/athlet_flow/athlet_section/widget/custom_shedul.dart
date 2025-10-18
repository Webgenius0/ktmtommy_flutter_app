import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';






class CustomShedul extends StatelessWidget {
  final String text;

  const CustomShedul({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            text,
            // 'My schedule',
            textAlign: TextAlign.center,
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 20.sp,fontWeight: FontWeight.w500
            )
        ),
        UIHelper.verticalSpace(8.h),

        Container(
          padding:  EdgeInsets.all(10.sp),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1.w,
                  color: AppColors.orangeColor
              ),
              borderRadius: BorderRadius.circular(80.r),
            ),
          ),
          child: Text(
              '🏁 TRIATHLON — 12 WEEKS TO GO',
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 14.sp,fontWeight: FontWeight.w400
              )
          ),
        ),


      ],
    );

  }
}