import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class SpecialThanks extends StatelessWidget {
  final String title;
  const SpecialThanks({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return

      Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.c181818,
        border: Border(
          left: BorderSide(
            width: 2.w,
            color: AppColors.c87B842,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(16.h),


            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                UIHelper.horizontalSpace(6.w),
                SvgPicture.asset(
                  AppIcons.lovetwo,
                  height: 24.h,
                ),
              ],
            ),

            UIHelper.verticalSpace(6.h),


            Text(
                'To Jess and Keelie for their incredible support during this journey. '
                    'Your strength and kindness made this possible.',
                style: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                    fontSize: 14.sp
                )
            ),
          ],
        ),
      ),
    );
  }
}