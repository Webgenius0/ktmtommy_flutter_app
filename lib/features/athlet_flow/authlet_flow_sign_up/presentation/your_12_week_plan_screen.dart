import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class Your12WeekPlanScreen extends StatelessWidget {
  const Your12WeekPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedGoal = appData.read(kKeyAthleteSelectGoal) ?? 'COMPLETE TRIATHLON';
    String reminderTime = appData.read(kKeyAthleteDailyReminder) ?? '6-10 AM';

    bool isTriathlon = selectedGoal.toUpperCase().contains('TRIATHLON');
    bool is5kPace = selectedGoal.toUpperCase().contains('5K');
    bool isMuscle = selectedGoal.toUpperCase().contains('MUSCLE');
    bool isEndurance = selectedGoal.toUpperCase().contains('ENDURANCE');

    // Dynamic Title
    String screenTitle = 'Your 12-Week Complete\nTriathlon Plan';
    if (is5kPace) {
      screenTitle = 'Your 12-Week 5K Pace Plan';
    } else if (isMuscle) {
      screenTitle = 'Your 12-Week Hypertrophy Plan';
    } else if (isEndurance) {
      screenTitle = 'Your 12-Week Endurance Plan';
    } else if (!isTriathlon) {
      screenTitle = 'Your 12-Week Energy &\nPerformance Plan';
    }

    // Dynamic Stats Grid (2x2)
    List<Map<String, String>> stats = [];
    if (isTriathlon) {
      stats = [
        {'label': 'Goal', 'val': 'Complete Triathlon', 'highlight': 'true'},
        {'label': 'Race Format', 'val': 'Sprint', 'highlight': 'false'},
        {'label': 'Reminder Time', 'val': reminderTime.contains('Morning') ? '6-10 AM' : reminderTime, 'highlight': 'false'},
        {'label': 'Duration', 'val': '12 Weeks', 'highlight': 'false'},
      ];
    } else if (is5kPace) {
      stats = [
        {'label': 'Goal', 'val': 'Improve 5K Pace', 'highlight': 'true'},
        {'label': 'Current 5K', 'val': '28:00 min', 'highlight': 'false'},
        {'label': 'Target 5K', 'val': '25:00 min', 'highlight': 'false'},
        {'label': 'Duration', 'val': '12 Weeks', 'highlight': 'false'},
      ];
    } else if (isMuscle) {
      stats = [
        {'label': 'Goal', 'val': 'Build Muscle Mass', 'highlight': 'true'},
        {'label': 'Current Weight', 'val': '70 kg', 'highlight': 'false'},
        {'label': 'Target Gain', 'val': '+4 kg', 'highlight': 'false'},
        {'label': 'Duration', 'val': '12 Weeks', 'highlight': 'false'},
      ];
    } else if (isEndurance) {
      stats = [
        {'label': 'Goal', 'val': 'Improve Endurance', 'highlight': 'true'},
        {'label': 'Target Event', 'val': 'Half Marathon', 'highlight': 'false'},
        {'label': 'Frequency', 'val': '4x / week', 'highlight': 'false'},
        {'label': 'Duration', 'val': '12 Weeks', 'highlight': 'false'},
      ];
    } else {
      stats = [
        {'label': 'Goal', 'val': 'Monitor Energy', 'highlight': 'true'},
        {'label': 'Primary Focus', 'val': 'Optimization', 'highlight': 'false'},
        {'label': 'Tracking', 'val': 'Daily HRV & Sleep', 'highlight': 'false'},
        {'label': 'Duration', 'val': '12 Weeks', 'highlight': 'false'},
      ];
    }

    // Dynamic Training Phases
    List<Map<String, String>> phases = [];
    if (isTriathlon) {
      phases = [
        {'title': 'Individual Discipline', 'weeks': 'Wks 1-4', 'sub': 'Swim, bike, and run base separately'},
        {'title': 'Brick Sessions', 'weeks': 'Wks 5-8', 'sub': 'Combined discipline training'},
        {'title': 'Race Simulation', 'weeks': 'Wks 9-11', 'sub': 'Full race-pace rehearsals'},
        {'title': 'Taper & Race Prep', 'weeks': 'Wk 12', 'sub': 'Reduce load, sharpen fitness'},
      ];
    } else if (is5kPace) {
      phases = [
        {'title': 'Base Building', 'weeks': 'Wks 1-4', 'sub': 'Easy runs, form drills, aerobic base'},
        {'title': 'Speed Development', 'weeks': 'Wks 5-8', 'sub': 'Interval training & tempo runs'},
        {'title': 'Race Preparation', 'weeks': 'Wks 9-11', 'sub': 'Race pace sessions, threshold work'},
        {'title': 'Taper & Peak', 'weeks': 'Wk 12', 'sub': 'Reduce volume, peak performance'},
      ];
    } else if (isMuscle) {
      phases = [
        {'title': 'Anatomical Adaptation', 'weeks': 'Wks 1-4', 'sub': 'Form mastery, hypertrophy base'},
        {'title': 'Hypertrophy Block', 'weeks': 'Wks 5-8', 'sub': 'Progressive overload & volume peak'},
        {'title': 'Strength & Density', 'weeks': 'Wks 9-11', 'sub': 'Heavy compound focus'},
        {'title': 'Deload & Recovery', 'weeks': 'Wk 12', 'sub': 'Supercompensation & muscle repair'},
      ];
    } else if (isEndurance) {
      phases = [
        {'title': 'Aerobic Foundation', 'weeks': 'Wks 1-4', 'sub': 'Zone 2 low-intensity volume'},
        {'title': 'Stamina Progression', 'weeks': 'Wks 5-8', 'sub': 'Long steady efforts & tempo'},
        {'title': 'Peak Volume', 'weeks': 'Wks 9-11', 'sub': 'Peak distance & simulation'},
        {'title': 'Taper & Rest', 'weeks': 'Wk 12', 'sub': 'Carbo-loading & peak taper'},
      ];
    } else {
      phases = [
        {'title': 'Baseline Assessment', 'weeks': 'Wks 1-4', 'sub': 'Biometric & habit tracking'},
        {'title': 'Circadian Optimization', 'weeks': 'Wks 5-8', 'sub': 'Sleep & recovery routines'},
        {'title': 'Performance Tuning', 'weeks': 'Wks 9-11', 'sub': 'Peak energy window alignment'},
        {'title': 'Sustainable Balance', 'weeks': 'Wk 12', 'sub': 'Long-term protocol integration'},
      ];
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArrowButtonAtheleteFlow(
                  onTap: () {
                    NavigationService.goBack();
                  },
                ),
                UIHelper.verticalSpace(12.h),
                Text(
                  screenTitle,
                  style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                    fontSize: 28.sp,
                    height: 1.1,
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                // AI Generated Badge
                Container(
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
                ),
                UIHelper.verticalSpace(20.h),
                // Stats Card Grid (2x2)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.c2F2F2F),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildMetricTile(stats[0]['label']!, stats[0]['val']!, isHighlight: stats[0]['highlight'] == 'true'),
                          ),
                          UIHelper.horizontalSpace(12.w),
                          Expanded(
                            child: _buildMetricTile(stats[1]['label']!, stats[1]['val']!, isHighlight: stats[1]['highlight'] == 'true'),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(12.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildMetricTile(stats[2]['label']!, stats[2]['val']!, isHighlight: stats[2]['highlight'] == 'true'),
                          ),
                          UIHelper.horizontalSpace(12.w),
                          Expanded(
                            child: _buildMetricTile(stats[3]['label']!, stats[3]['val']!, isHighlight: stats[3]['highlight'] == 'true'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                // Training Phases Section
                Text(
                  'TRAINING PHASES',
                  style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                    fontSize: 20.sp,
                    letterSpacing: 1.0,
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                ...phases.map((p) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: _buildPhaseItem(p['title']!, p['weeks']!, p['sub']!),
                  );
                }),

                UIHelper.verticalSpace(24.h),
                // What's Included Section
                Container(
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
                          fontSize: 18.sp,
                          color: AppColors.orangeColor,
                          letterSpacing: 1.0,
                        ),
                      ),
                      UIHelper.verticalSpace(12.h),
                      _buildIncludedBullet('Daily task list adapted to your schedule'),
                      _buildIncludedBullet('AI coaching feedback after every session'),
                      _buildIncludedBullet('Weekly progress reports & plan adjustments'),
                      _buildIncludedBullet('Supplement & nutrition guidance'),
                      _buildIncludedBullet('Sleep & recovery optimisation'),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(32.h),
                CustomButtonWidget(
                  onTap: () {
                    NavigationService.navigateTo(Routes.allSetPersonalInformationScreen);
                  },
                  textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                  image: DecorationImage(
                    image: AssetImage(AppImages.orangebutton),
                  ),
                  text: 'Start My Plan',
                ),
                UIHelper.verticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricTile(String label, String value, {bool isHighlight = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.c101010,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
              fontSize: 12.sp,
            ),
          ),
          UIHelper.verticalSpace(4.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
              fontSize: 16.sp,
              color: isHighlight ? AppColors.orangeColor : AppColors.cFFFFFF,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseItem(String title, String weeks, String subtitle) {
    return Container(
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
                  title,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UIHelper.verticalSpace(2.h),
                Text(
                  subtitle,
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
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              weeks,
              style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedBullet(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              width: 6.w,
              height: 6.w,
              decoration: const BoxDecoration(
                color: AppColors.c87B842,
                shape: BoxShape.circle,
              ),
            ),
          ),
          UIHelper.horizontalSpace(10.w),
          Expanded(
            child: Text(
              text,
              style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
