import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/presentation/your_12_week_plan_screen.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AthleteTodayGoalCard extends StatelessWidget {
  final String dateText;
  final String aiSummaryText;

  const AthleteTodayGoalCard({
    super.key,
    required this.dateText,
    required this.aiSummaryText,
  });

  @override
  Widget build(BuildContext context) {
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
          Text(
            dateText,
            style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          UIHelper.verticalSpace(2.h),
          Text(
            "TODAY'S GOAL PLAN",
            style: TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
              fontSize: 16.sp,
              color: AppColors.orangeColor,
              letterSpacing: 0.5,
            ),
          ),
          UIHelper.verticalSpace(14.h),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1715),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.orangeColor.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 22.w,
                      height: 22.w,
                      child: Icon(Icons.masks,color: AppColors.orangeColor,),
                    ),
                    UIHelper.horizontalSpace(8.w),
                    Text(
                      "Today's AI Plan",
                      style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.orangeColor,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(8.h),
                Text(
                  aiSummaryText,
                  style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                    fontSize: 13.sp,
                    color: const Color(0xFFD1D1D1),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
