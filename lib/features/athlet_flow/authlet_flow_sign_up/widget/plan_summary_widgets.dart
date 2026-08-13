import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class PlanAiBadgeWidget extends StatelessWidget {
  const PlanAiBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF132B1B),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.c87B842.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '✨  AI generated - personalised for you',
            style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
              fontSize: 12.sp,
              color: AppColors.c87B842,
            ),
          ),
        ],
      ),
    );
  }
}

class PlanMetricTileWidget extends StatelessWidget {
  final String label;
  final String val;
  final bool isHighlight;

  const PlanMetricTileWidget({
    super.key,
    required this.label,
    required this.val,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.c2A2A2A.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isHighlight ? AppColors.orangeColor.withOpacity(0.4) : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
              fontSize: 11.sp,
            ),
          ),
          UIHelper.verticalSpace(4.h),
          Text(
            val,
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 14.sp,
              color: isHighlight ? AppColors.orangeColor : AppColors.cFFFFFF,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class PlanTrainingPhasesWidget extends StatelessWidget {
  final List<Map<String, String>> phases;

  const PlanTrainingPhasesWidget({
    super.key,
    required this.phases,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TRAINING PHASES',
          style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
            fontSize: 20.sp,
            letterSpacing: 1.2,
          ),
        ),
        UIHelper.verticalSpace(12.h),
        Column(
          children: phases.map((phase) {
            return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.c181818,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.c2F2F2F),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          phase['title']!,
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        UIHelper.verticalSpace(2.h),
                        Text(
                          phase['sub']!,
                          style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.c2F2F2F,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      phase['weeks']!,
                      style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.orangeColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class PlanWhatsIncludedWidget extends StatelessWidget {
  final List<String> features;

  const PlanWhatsIncludedWidget({
    super.key,
    this.features = const [
      'Daily task list adapted to your schedule',
      'AI coaching feedback after every session',
      'Weekly progress reports & plan adjustments',
      'Supplement & nutrition guidance',
      'Sleep & recovery optimisation',
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.c181818,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.c2F2F2F),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WHAT\'S INCLUDED',
            style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
              fontSize: 16.sp,
              color: AppColors.orangeColor,
              letterSpacing: 1.1,
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Column(
            children: features.map((feature) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: TextStyle(
                        color: AppColors.orangeColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.cA3A3A3,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
