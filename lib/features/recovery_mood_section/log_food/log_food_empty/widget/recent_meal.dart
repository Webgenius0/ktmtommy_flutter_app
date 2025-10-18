import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class RecentMeal extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget image;
  final String title;
  final String subtitle;
  final String timeText;

  const RecentMeal({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    required this.subtitle, required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:

      Container(
        margin: EdgeInsets.only(bottom: 12.h),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: AppColors.c181818,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            image,
          //  Image.asset(AppImages.breakfastimage, height: 55.h),
            UIHelper.horizontalSpace(16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
               title,
                 // 'Breakfast',
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  subtitle,
                 // '425 Calories',
                  style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.clcokicon, height: 16.h),
                    UIHelper.horizontalSpace(4.w),
                    Text(
                      timeText,
                      //'8:00 AM',
                      style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
