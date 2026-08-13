import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AthleteTaskCard extends StatelessWidget {
  final Widget icon;
  final Color iconBgColor;
  final String title;
  final String targetText;
  final double progress;
  final String loggedText;
  final String weightText;
  final Color buttonColor;
  final VoidCallback onLogTap;

  const AthleteTaskCard({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.targetText,
    this.progress = 0.0,
    required this.loggedText,
    required this.weightText,
    required this.buttonColor,
    required this.onLogTap,
  });

  @override
  Widget build(BuildContext context) {
    int percentage = (progress * 100).toInt();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.c181818,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2F2F2F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Circular icon badge
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: iconBgColor.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: icon,
              ),
              UIHelper.horizontalSpace(12.w),

              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    UIHelper.verticalSpace(2.h),
                    Text(
                      targetText,
                      style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                        fontSize: 12.sp,
                        color: const Color(0xFFA0A0A0),
                      ),
                    ),
                  ],
                ),
              ),

              // Small circular progress
              SizedBox(
                width: 32.w,
                height: 32.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 32.w,
                      height: 32.w,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 3.5.w,
                        backgroundColor: const Color(0xFF2F2F2F),
                        valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
                      ),
                    ),
                    Text(
                      '$percentage%',
                      style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              UIHelper.horizontalSpace(10.w),

              // Log button
              GestureDetector(
                onTap: onLogTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Log',
                    style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8.h,
              backgroundColor: const Color(0xFF262626),
              valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
            ),
          ),
          UIHelper.verticalSpace(10.h),

          // Bottom stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Logged: $loggedText',
                style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                  fontSize: 12.sp,
                  color: const Color(0xFF8E8E93),
                ),
              ),
              Text(
                'Weight: $weightText',
                style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                  fontSize: 12.sp,
                  color: const Color(0xFF8E8E93),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
