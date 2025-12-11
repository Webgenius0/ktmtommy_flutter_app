import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomLoogFood extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final Widget plusicon;
  final VoidCallback? onTap;

  const CustomLoogFood({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  this.onTap, required this.plusicon,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: AppColors.c181818,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  icon,
                 UIHelper.horizontalSpace(60.h),
                 plusicon,
                ],
              ),


              UIHelper.verticalSpace(12.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              UIHelper.verticalSpace(8.h),
              Text(
                subtitle,
               // 'Record Medication',
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle14w400c454545poppins,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
