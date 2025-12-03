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

  const CustomCircularProgress({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(AppIcons.raceicon, height: 24.h),
                        UIHelper.horizontalSpace(4.w),
                        Text(
                          title,
                          //'RACE READINESS',
                          style: TextFontStyle.textStyle18w400cF55216Teko,
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(4.h),
                    Text(
                      'YOU RE 73% READY!',
                      style: TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    UIHelper.verticalSpace(4.h),
                    Text(
                      'Keep up the great work on those\nbrick sessions',
                      style: TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    reverse: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: AppColors.c2F2F2F,
                    radius: 52.0,
                    lineWidth: 12.0,
                    percent: 0.7,
                    center: Text("73%",
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins),
                    progressColor: AppColors.orangeColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
