import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class CustomCircularProgress extends StatelessWidget {
  final String title;
  final num? score;
  final String? readinessTitle;
  final String? subtitle;

  const CustomCircularProgress({
    super.key,
    required this.title,
    this.score,
    this.readinessTitle,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final double scoreVal = (score ?? 73).toDouble();
    final double percentVal = (scoreVal / 100).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.c090809,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: AppColors.orangeColor,
          ),
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppIcons.raceicon, height: 24.h),
                      UIHelper.horizontalSpace(4.w),
                      Text(
                        title,
                        style: TextFontStyle.textStyle18w400cF55216Teko,
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    readinessTitle ?? 'YOU RE ${scoreVal.toInt()}% READY!',
                    style: TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    subtitle ?? 'Keep up the great work on those\nbrick sessions',
                    style: TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            CircularPercentIndicator(
              reverse: true,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: AppColors.c2F2F2F,
              radius: 52.0,
              lineWidth: 12.0,
              percent: percentVal,
              center: Text(
                "${scoreVal.toInt()}%",
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 18.sp),
              ),
              progressColor: AppColors.orangeColor,
            ),
          ],
        ),
      ),
    );
  }
}
