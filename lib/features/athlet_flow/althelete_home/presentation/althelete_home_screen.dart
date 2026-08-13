import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/athlete_daily_progress_card.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/athlete_home_header.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/athlete_task_card.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/athlete_today_goal_card.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_send.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class AltheleteHomeScreen extends StatefulWidget {
  const AltheleteHomeScreen({super.key});

  @override
  State<AltheleteHomeScreen> createState() => _AltheleteHomeScreenState();
}

class _AltheleteHomeScreenState extends State<AltheleteHomeScreen> {
  @override
  void initState() {
    super.initState();
    _updateTimezone();
  }

  Future<void> _updateTimezone() async {
    try {
      final timezone = (await FlutterTimezone.getLocalTimezone()).identifier;
      await updateTimezoneRx.updateTimezone(timezone);
    } catch (e) {
      log("Error updating timezone: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.restbacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Row
                AthleteHomeHeader(
                  title: "LET'S GRIND, ALEX. NO EXCUSES TODAY.",
                  goalText: '🏁 TRIATHLON — Week 2 • Day 8 >',
                  onProfileTap: () {
                    NavigationService.navigateTo(
                        Routes.myProfileSettingScreenAthlet);
                  },
                ),
                UIHelper.verticalSpace(18.h),

                // 2. Today's Goal Plan Card
                const AthleteTodayGoalCard(
                  dateText: 'Monday, 19 May 2026',
                  aiSummaryText:
                      "Yesterday you slept only 5.5 hours and recovery was low. Today's running volume has been reduced by 20%.",
                ),
                UIHelper.verticalSpace(18.h),

                // 3. Daily Progress Gauge Card ("READY TO START")
                const AthleteDailyProgressCard(
                  completedTasks: 0,
                  totalTasks: 4,
                  activityProgress: 0.0,
                  foodProgress: 0.0,
                  sleepProgress: 0.0,
                  suppsProgress: 0.0,
                ),
                UIHelper.verticalSpace(22.h),

                // 4. AI GENERATED TASKS Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'AI GENERATED TASKS',
                      style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Improve 5K Pace • Wk 2',
                      style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                        fontSize: 12.sp,
                        color: const Color(0xFFA0A0A0),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(12.h),

                // 5. Task Cards
                // Card 1: Activity
                AthleteTaskCard(
                  icon: SvgPicture.asset(
                    AppIcons.logactivity,
                    colorFilter: const ColorFilter.mode(
                      AppColors.orangeColor,
                      BlendMode.srcIn,
                    ),
                    height: 20.h,
                  ),
                  iconBgColor: AppColors.orangeColor,
                  title: 'Run 1 KM',
                  targetText: 'Target: 1 km',
                  progress: 0.0,
                  loggedText: '0.0 km',
                  weightText: '40%',
                  buttonColor: AppColors.orangeColor,
                  onLogTap: () {
                    NavigationService.navigateTo(Routes.athletLogActivityScreen);
                  },
                ),
                UIHelper.verticalSpace(12.h),

                // Card 2: Food
                AthleteTaskCard(
                  icon: SvgPicture.asset(
                    AppIcons.logfoodicon,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF87B842),
                      BlendMode.srcIn,
                    ),
                    height: 20.h,
                  ),
                  iconBgColor: const Color(0xFF87B842),
                  title: 'Eat 120g Protein',
                  targetText: 'Target: 120g protein • 2400 kcal',
                  progress: 0.0,
                  loggedText: '0g • 0 kcal',
                  weightText: '25%',
                  buttonColor: const Color(0xFF87B842),
                  onLogTap: () {
                    NavigationService.navigateTo(
                        Routes.athletLogFoodEmptyScreen);
                  },
                ),
                UIHelper.verticalSpace(12.h),

                // Card 3: Sleep
                AthleteTaskCard(
                  icon: SvgPicture.asset(
                    AppIcons.logsleepicon,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF3B82F6),
                      BlendMode.srcIn,
                    ),
                    height: 20.h,
                  ),
                  iconBgColor: const Color(0xFF3B82F6),
                  title: 'Sleep 8 Hours',
                  targetText: 'Target: 8h',
                  progress: 0.0,
                  loggedText: 'Not logged',
                  weightText: '25%',
                  buttonColor: const Color(0xFF3B82F6),
                  onLogTap: () {
                    NavigationService.navigateTo(Routes.logSleepScreen);
                  },
                ),
                UIHelper.verticalSpace(12.h),

                // Card 4: Supplements
                AthleteTaskCard(
                  icon: SvgPicture.asset(
                    AppIcons.logTableticon,
                    colorFilter: const ColorFilter.mode(
                      AppColors.orangeColor,
                      BlendMode.srcIn,
                    ),
                    height: 20.h,
                  ),
                  iconBgColor: AppColors.orangeColor,
                  title: 'Take Supplements',
                  targetText: 'Target: 4 supplements',
                  progress: 0.0,
                  loggedText: '0/4 taken',
                  weightText: '10%',
                  buttonColor: AppColors.orangeColor,
                  onLogTap: () {
                    NavigationService.navigateTo(Routes.logSupplementScreen);
                  },
                ),
                UIHelper.verticalSpace(20.h),

                // 6. Ask your coach
                const CustomSend(),
                UIHelper.verticalSpace(24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
