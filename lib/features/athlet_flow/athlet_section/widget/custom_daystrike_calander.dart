import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/model/athlete_weekly_progress_model.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class CustomDaystrikeCalander extends StatelessWidget {
  final int? selectedWeek;
  final int? daystreak;
  final String? dateRange;
  final List<OverviewDay>? days;
  final bool isFirstWeek;
  final bool isLastWeek;
  final bool isLoading;
  final VoidCallback? onPreviousWeek;
  final VoidCallback? onNextWeek;

  const CustomDaystrikeCalander({
    super.key,
    this.selectedWeek,
    this.daystreak,
    this.dateRange,
    this.days,
    this.isFirstWeek = false,
    this.isLastWeek = false,
    this.isLoading = false,
    this.onPreviousWeek,
    this.onNextWeek,
  });

  Widget _getStatusIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return SvgPicture.asset(AppIcons.greensigneture, height: 17.h);
      case 'missed':
        return SvgPicture.asset(AppIcons.crossicon, height: 17.h);
      case 'rest':
        return SvgPicture.asset(AppIcons.bedicon, height: 17.h);
      default:
        return SvgPicture.asset(AppIcons.greensigneture, height: 17.h);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<OverviewDay> dayList = days ?? [
      OverviewDay(dayName: 'Thu', status: 'missed'),
      OverviewDay(dayName: 'Fri', status: 'missed'),
      OverviewDay(dayName: 'Sat', status: 'missed'),
      OverviewDay(dayName: 'Sun', status: 'missed'),
      OverviewDay(dayName: 'Mon', status: 'missed'),
      OverviewDay(dayName: 'Tue', status: 'missed'),
      OverviewDay(dayName: 'Wed', status: 'completed'),
    ];

    final bool isLeftDisabled = isFirstWeek || isLoading;
    final bool isRightDisabled = isLastWeek || isLoading;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Week + Daystreak Header
          Row(
            children: [
              Text(
                'Week ${selectedWeek ?? 3}',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(AppIcons.powericon, height: 13.h),
              UIHelper.horizontalSpace(8.w),
              Text(
                'Daystreak ${daystreak ?? 1}',
                style: TextFontStyle.textStyle14w400cF55216poppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(16.h),

          // Week Navigator Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 24.sp,
                  color: isLeftDisabled ? Colors.grey : Colors.white,
                ),
                onPressed: isLeftDisabled ? null : onPreviousWeek,
              ),
              UIHelper.horizontalSpace(8.w),
              isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.orangeColor,
                      ),
                    )
                  : Text(
                      dateRange ?? "Sep 10 - Sep 16",
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              UIHelper.horizontalSpace(8.w),
              IconButton(
                icon: Icon(
                  Icons.chevron_right,
                  size: 24.sp,
                  color: isRightDisabled ? Colors.grey : Colors.white,
                ),
                onPressed: isRightDisabled ? null : onNextWeek,
              ),
            ],
          ),
          UIHelper.verticalSpace(20.h),

          // Days Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: dayList.map((dayData) {
              return _buildDayContainer(
                dayData.dayName ?? '',
                _getStatusIcon(dayData.status),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDayContainer(String dayName, Widget icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: AppColors.c101010,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              Text(
                dayName,
                style: TextFontStyle.textStyle14w400cBABABApoppins,
              ),
              UIHelper.verticalSpace(8.h),
              icon,
            ],
          ),
        ),
      ],
    );
  }
}