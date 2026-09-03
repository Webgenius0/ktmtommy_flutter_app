import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/athlete_daily_progress_card.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/athlete_home_header.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/athlete_task_card.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/athlete_today_goal_card.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_send.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/model/generate_daily_plan_model.dart';
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
    _fetchDailyPlan();
  }

  void _fetchDailyPlan() {
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    generateDailyPlanRxObj.generateDailyPlan(date: todayDate);
  }

  Future<void> _updateTimezone() async {
    try {
      final timezone = (await FlutterTimezone.getLocalTimezone()).identifier;
      await updateTimezoneRx.updateTimezone(timezone);
    } catch (e) {
      log("Error updating timezone: $e");
    }
  }

  Widget _buildTaskCard(DailyTaskModel task) {
    final category = (task.category ?? '').toLowerCase();
    Widget iconWidget;
    Color iconBgColor;
    Color buttonColor;
    String routeName;

    if (category.contains('activity')) {
      iconWidget = SvgPicture.asset(
        AppIcons.logactivity,
        colorFilter: const ColorFilter.mode(
          AppColors.orangeColor,
          BlendMode.srcIn,
        ),
        height: 20.h,
      );
      iconBgColor = AppColors.orangeColor;
      buttonColor = AppColors.orangeColor;
      routeName = Routes.athletLogActivityScreen;
    } else if (category.contains('food')) {
      iconWidget = SvgPicture.asset(
        AppIcons.logfoodicon,
        colorFilter: const ColorFilter.mode(
          Color(0xFF87B842),
          BlendMode.srcIn,
        ),
        height: 20.h,
      );
      iconBgColor = const Color(0xFF87B842);
      buttonColor = const Color(0xFF87B842);
      routeName = Routes.athletLogFoodEmptyScreen;
    } else if (category.contains('sleep')) {
      iconWidget = SvgPicture.asset(
        AppIcons.logsleepicon,
        colorFilter: const ColorFilter.mode(
          Color(0xFF3B82F6),
          BlendMode.srcIn,
        ),
        height: 20.h,
      );
      iconBgColor = const Color(0xFF3B82F6);
      buttonColor = const Color(0xFF3B82F6);
      routeName = Routes.logSleepScreen;
    } else {
      // supplement
      iconWidget = SvgPicture.asset(
        AppIcons.logTableticon,
        colorFilter: const ColorFilter.mode(
          AppColors.orangeColor,
          BlendMode.srcIn,
        ),
        height: 20.h,
      );
      iconBgColor = AppColors.orangeColor;
      buttonColor = AppColors.orangeColor;
      routeName = Routes.logSupplementScreen;
    }

    String targetStr = task.targetValue != null && task.targetUnit != null
        ? 'Target: ${task.targetValue} ${task.targetUnit}'
        : (task.targetValue != null ? 'Target: ${task.targetValue}' : '');

    double progressVal = 0.0;
    if (task.progressPercentage != null) {
      progressVal = (task.progressPercentage!.toDouble() / 100.0).clamp(0.0, 1.0);
    } else if (task.isCompleted == true) {
      progressVal = 1.0;
    }

    String loggedText = (task.isCompleted ?? false)
        ? 'Completed'
        : (task.loggedValue != null && task.targetUnit != null
            ? '${task.loggedValue} ${task.targetUnit}'
            : (task.loggedValue != null ? '${task.loggedValue}' : '0 ${task.targetUnit ?? ''}'));

    String weightText = task.weight != null ? '${task.weight}%' : '';

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: AthleteTaskCard(
        icon: iconWidget,
        iconBgColor: iconBgColor,
        title: task.title ?? '',
        targetText: targetStr,
        progress: progressVal,
        loggedText: loggedText,
        weightText: weightText,
        buttonColor: buttonColor,
        onLogTap: () {
          NavigationService.navigateTo(routeName);
        },
      ),
    );
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
          child: StreamBuilder<GenerateDailyPlanModel>(
            stream: generateDailyPlanRxObj.getDailyPlanStream,
            builder: (context, snapshot) {
              String dateText =
                  DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
              String aiSummaryText =
                  "Yesterday you slept only 5.5 hours and recovery was low. Today's running volume has been reduced by 20%.";
              String goalText = '🏁 TRIATHLON — Week 2 • Day 8 >';
              List<DailyTaskModel>? tasks;
              double actProg = 0.0;
              double foodProg = 0.0;
              double sleepProg = 0.0;
              double suppProg = 0.0;

              if (snapshot.hasData && snapshot.data?.data != null) {
                final planData = snapshot.data!.data!;
                if (planData.summary != null && planData.summary!.isNotEmpty) {
                  aiSummaryText = planData.summary!;
                }
                if (planData.planInfo != null) {
                  final info = planData.planInfo!;
                  final goalStr = info.goal?.replaceAll('_', ' ') ?? 'TRIATHLON';
                  goalText = '🏁 $goalStr — Week ${info.week ?? 1} • Day ${info.day ?? 1} >';
                }
                if (planData.progress?.categories != null) {
                  final cat = planData.progress!.categories!;
                  actProg = ((cat.activity ?? 0) / 100.0).clamp(0.0, 1.0);
                  foodProg = ((cat.food ?? 0) / 100.0).clamp(0.0, 1.0);
                  sleepProg = ((cat.sleep ?? 0) / 100.0).clamp(0.0, 1.0);
                  suppProg = ((cat.supplement ?? 0) / 100.0).clamp(0.0, 1.0);
                }
                tasks = planData.tasks;
              }

              int totalTasks = tasks?.length ?? 4;
              int completedTasks =
                  tasks?.where((t) => t.isCompleted == true).length ?? 0;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header Row
                    AthleteHomeHeader(
                      title: "LET'S GRIND, ALEX. NO EXCUSES TODAY.",
                      goalText: goalText,
                      onProfileTap: () {
                        NavigationService.navigateTo(
                            Routes.myProfileSettingScreenAthlet);
                      },
                    ),
                    UIHelper.verticalSpace(18.h),

                    // 2. Today's Goal Plan Card
                    AthleteTodayGoalCard(
                      dateText: dateText,
                      aiSummaryText: aiSummaryText,
                    ),
                    UIHelper.verticalSpace(14.h),

                    // Generate Today's Plan Button
                    CustomButtonWidget(
                      onTap: () {
                        NavigationService.navigateTo(
                            Routes.athletDailyCheckInScreen);
                      },
                      textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                      image: DecorationImage(
                        image: AssetImage(AppImages.orangebutton),
                      ),
                      text: "Generate Today's Plan ✨",
                    ),
                    UIHelper.verticalSpace(18.h),

                    // 3. Daily Progress Gauge Card ("READY TO START")
                    AthleteDailyProgressCard(
                      completedTasks: completedTasks,
                      totalTasks: totalTasks,
                      activityProgress: actProg,
                      foodProgress: foodProg,
                      sleepProgress: sleepProg,
                      suppsProgress: suppProg,
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
                          style: TextFontStyle.textStyle14w400cE8E8E8poppins
                              .copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xFFA0A0A0),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(12.h),

                    // 5. Task Cards
                    if (tasks != null && tasks.isNotEmpty)
                      ...tasks.map((task) => _buildTaskCard(task))
                    else if (snapshot.connectionState == ConnectionState.waiting)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: const CircularProgressIndicator(
                            color: AppColors.orangeColor,
                          ),
                        ),
                      )
                    else
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Text(
                            'No tasks found for today.',
                            style: TextFontStyle.textStyle14w400cE8E8E8poppins
                                .copyWith(
                              color: const Color(0xFFA0A0A0),
                            ),
                          ),
                        ),
                      ),
                    UIHelper.verticalSpace(20.h),

                    // 6. Ask your coach
                    const CustomSend(),
                    UIHelper.verticalSpace(24.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

