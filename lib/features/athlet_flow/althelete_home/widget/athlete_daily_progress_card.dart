import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AthleteDailyProgressCard extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;
  final double activityProgress;
  final double foodProgress;
  final double sleepProgress;
  final double suppsProgress;

  const AthleteDailyProgressCard({
    super.key,
    this.completedTasks = 0,
    this.totalTasks = 4,
    this.activityProgress = 0.0,
    this.foodProgress = 0.0,
    this.sleepProgress = 0.0,
    this.suppsProgress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    double overallProgress = totalTasks == 0 ? 0.0 : (completedTasks / totalTasks);
    int overallPercentage = (overallProgress * 100).toInt();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.c181818,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2F2F2F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'READY TO START',
                    style: TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.orangeColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  UIHelper.verticalSpace(2.h),
                  Text(
                    '$completedTasks of $totalTasks tasks logged today',
                    style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xFFA0A0A0),
                    ),
                  ),
                ],
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Row(
            children: [
              // Left Circular Gauge
              SizedBox(
                width: 90.w,
                height: 90.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 90.w,
                      height: 90.w,
                      child: CircularProgressIndicator(
                        value: overallProgress,
                        strokeWidth: 9.w,
                        backgroundColor: const Color(0xFF2F2F2F),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.orangeColor,
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$overallPercentage%',
                          style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                        Text(
                          'Daily',
                          style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                            fontSize: 11.sp,
                            color: const Color(0xFFA0A0A0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              UIHelper.horizontalSpace(20.w),

              // Right Progress bars list
              Expanded(
                child: Column(
                  children: [
                    _buildTaskProgressBar('Activity', activityProgress),
                    UIHelper.verticalSpace(8.h),
                    _buildTaskProgressBar('Food', foodProgress),
                    UIHelper.verticalSpace(8.h),
                    _buildTaskProgressBar('Sleep', sleepProgress),
                    UIHelper.verticalSpace(8.h),
                    _buildTaskProgressBar('Supps', suppsProgress),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskProgressBar(String label, double progress) {
    int percentage = (progress * 100).toInt();
    return Row(
      children: [
        SizedBox(
          width: 52.w,
          child: Text(
            label,
            style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
              fontSize: 12.sp,
              color: const Color(0xFFA0A0A0),
            ),
          ),
        ),
        UIHelper.horizontalSpace(8.w),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: const Color(0xFF2F2F2F),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.c87B842,
              ),
            ),
          ),
        ),
        UIHelper.horizontalSpace(8.w),
        SizedBox(
          width: 26.w,
          child: Text(
            '$percentage%',
            textAlign: TextAlign.end,
            style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
              fontSize: 11.sp,
              color: AppColors.c87B842,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
