import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/custom_loog_food.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/custom_time_line.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/tbi_recovery.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/model/schedule_model.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/model/daily_activity_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0; // 0 for Today's Session, 1 for Today's Activity

  @override
  void initState() {
    super.initState();
    _updateTimezone();
    _fetchDataForSelectedTab();
  }

  void _fetchDataForSelectedTab() {
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (_selectedTab == 0) {
      getScheduleRxObj.getSchedule(todayStr);
    } else {
      dailyActivityRxObj.getDailyActivity(todayStr);
    }
  }

  Future<void> _updateTimezone() async {
    try {
      final timezone = (await FlutterTimezone.getLocalTimezone()).identifier;
      await updateTimezoneRx.updateTimezone(timezone);
    } catch (e) {
      log("Error updating timezone: $e");
    }
  }

  List<Map<String, dynamic>> _getSortedActivities(DailyActivityData? data) {
    if (data == null) return [];
    
    final List<Map<String, dynamic>> list = [];
    
    if (data.morning != null) {
      for (var a in data.morning!) {
        list.add({'activity': a, 'period': 'Morning'});
      }
    }
    if (data.afternoon != null) {
      for (var a in data.afternoon!) {
        list.add({'activity': a, 'period': 'Afternoon'});
      }
    }
    if (data.evening != null) {
      for (var a in data.evening!) {
        list.add({'activity': a, 'period': 'Evening'});
      }
    }
    if (data.night != null) {
      for (var a in data.night!) {
        list.add({'activity': a, 'period': 'Night'});
      }
    }
    
    list.sort((a, b) {
      final t1 = (a['activity'] as DailyActivityItem).time ?? '';
      final t2 = (b['activity'] as DailyActivityItem).time ?? '';
      return t1.compareTo(t2);
    });
    
    return list;
  }

  Widget _getIconForActivityType(String? type, String title) {
    if (type == null) return _getIconForSession(title);
    
    final lowerType = type.toLowerCase();
    if (lowerType == 'food' || lowerType == 'diet' || lowerType == 'nutrition') {
      return SvgPicture.asset(AppIcons.logfoodicon);
    }
    if (lowerType == 'step' || lowerType == 'steps' || lowerType == 'walk') {
      return SvgPicture.asset(AppIcons.logSteps);
    }
    if (lowerType == 'medication' || lowerType == 'tablet' || lowerType == 'medicine' || lowerType == 'pill') {
      return SvgPicture.asset(AppIcons.logTableticon);
    }
    if (lowerType == 'activity' || lowerType == 'workout') {
      return SvgPicture.asset(AppIcons.logactivity);
    }
    return _getIconForSession(title);
  }

  Widget _buildTabItem(int index, String title) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        if (_selectedTab != index) {
          setState(() {
            _selectedTab = index;
          });
          _fetchDataForSelectedTab();
        }
      },
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 16.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : Colors.white38,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            Container(
              height: 2.h,
              color: isSelected ? const Color(0xFF87B842) : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getSortedSessions(ScheduleData? data) {
    if (data == null) return [];
    
    final List<Map<String, dynamic>> list = [];
    
    if (data.morning != null) {
      for (var s in data.morning!) {
        list.add({'session': s, 'period': 'Morning'});
      }
    }
    if (data.afternoon != null) {
      for (var s in data.afternoon!) {
        list.add({'session': s, 'period': 'Afternoon'});
      }
    }
    if (data.evening != null) {
      for (var s in data.evening!) {
        list.add({'session': s, 'period': 'Evening'});
      }
    }
    if (data.night != null) {
      for (var s in data.night!) {
        list.add({'session': s, 'period': 'Night'});
      }
    }
    
    list.sort((a, b) {
      final t1 = (a['session'] as ScheduleSession).time ?? '';
      final t2 = (b['session'] as ScheduleSession).time ?? '';
      return t1.compareTo(t2);
    });
    
    return list;
  }

  String _formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return '';
    try {
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final dt = DateTime(2026, 1, 1, hour, minute);
        return DateFormat('h:mm a').format(dt);
      }
    } catch (e) {
      // fallback
    }
    return timeStr;
  }

  Widget _getIconForSession(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('food') ||
        lower.contains('lunch') ||
        lower.contains('dinner') ||
        lower.contains('breakfast') ||
        lower.contains('meal') ||
        lower.contains('eat') ||
        lower.contains('nutrition') ||
        lower.contains('diet')) {
      return SvgPicture.asset(AppIcons.logfoodicon);
    }
    if (lower.contains('step') ||
        lower.contains('walk')) {
      return SvgPicture.asset(AppIcons.logSteps);
    }
    if (lower.contains('medication') ||
        lower.contains('tablet') ||
        lower.contains('pill') ||
        lower.contains('medicine') ||
        lower.contains('rx')) {
      return SvgPicture.asset(AppIcons.logTableticon);
    }
    return SvgPicture.asset(AppIcons.logactivity);
  }

  ///================= MEDICINE DIALOG =================
  void showMedicineDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.bacroundColorBlack,
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: AppColors.c5E5E5E.withOpacity(.3),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                ///=========== TOP IMAGE ===========
                Image.asset(
                  AppImages.logo225,
                  height: 70.h,
                ),

                UIHelper.verticalSpace(18.h),

                ///=========== TITLE ===========
                Text(
                  "Log Medicines",
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                UIHelper.verticalSpace(28.h),

                ///=========== LOG PRESCRIBED ===========
                customDialogCard(
                  onTap: () {
                    Navigator.pop(context);

                    log("Log Prescribed Medicine");
                    NavigationService.navigateTo(Routes.myMedicinesScreen);
                  },
                  icon: Icons.add,
                  iconBg: const Color(0xffA6FF00),
                  title: "Log Prescribed Medicine",
                  subtitle: "Add a new medicine to your schedule",
                ),

                UIHelper.verticalSpace(18.h),

                ///=========== LOG TABLET ===========
                customDialogCard(
                  onTap: () {
                    Navigator.pop(context);

                    log("Log Tablet");

                    NavigationService.navigateTo(
                      Routes.logTabletScreen,
                    );
                  },
                  icon: Icons.grid_view_rounded,
                  iconBg: Colors.red,
                  title: "Log Tablet",
                  subtitle: "Record Medication",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///================= CUSTOM DIALOG CARD =================
  Widget customDialogCard({
    required VoidCallback onTap,
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 18.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff121212),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: const Color(0xffA6FF00),
            width: 1,
          ),
        ),
        child: Row(
          children: [

            ///=========== ICON ===========
            Container(
              height: 46.h,
              width: 46.w,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22.sp,
              ),
            ),

            UIHelper.horizontalSpace(14.w),

            ///=========== TEXT ===========
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  UIHelper.verticalSpace(4.h),

                  Text(
                    subtitle,
                    style: TextFontStyle.textStyle14w500c242424.copyWith(
                      color: Colors.white38,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  TBIRecovery(
                    widget: Image.asset(AppImages.logo225),
                    onTap: () {
                      NavigationService.navigateTo(
                        Routes.myProfileSettingScreen,
                      );
                    },
                    title: 'My Balance Day',
                  ),
                ],
              ),
            ),

            UIHelper.verticalSpace(24.h),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ///=========== LOG TABLET =================
                        CustomLoogFood(
                          onTap: () {

                            /// OPEN DIALOG
                            showMedicineDialog();

                          },
                          icon: SvgPicture.asset(AppIcons.logTableticon),
                          subtitle: 'Record Medication',
                          plusicon: SvgPicture.asset(
                            AppIcons.pluseadd,
                            color: AppColors.c757575,
                            height: 24.h,
                          ),
                          title: 'Log Tablet',
                        ),

                        UIHelper.horizontalSpace(20.w),

                        ///=========== LOG FOOD =================
                        CustomLoogFood(
                          onTap: () {
                            log(
                              "========>>>>>>>>>Log Food Clicked",
                            );

                            NavigationService.navigateTo(
                              Routes.logFoodEmptyScreen,
                            );
                          },
                          icon: SvgPicture.asset(AppIcons.logfoodicon),
                          subtitle: 'Track Nutrition',
                          plusicon: SvgPicture.asset(
                            AppIcons.pluseadd,
                            height: 24.h,
                            color: AppColors.c757575,
                          ),
                          title: 'Log Food',
                        ),
                      ],
                    ),

                    UIHelper.verticalSpace(20.h),

                    ///=========== SECOND ROW =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ///=========== LOG STEPS =================
                        CustomLoogFood(
                          onTap: () {
                            NavigationService.navigateTo(
                              Routes.logStepsScreen,
                            );
                          },
                          icon: SvgPicture.asset(AppIcons.logSteps),
                          subtitle: 'Sync your steps',
                          plusicon: SvgPicture.asset(
                            AppIcons.pluseadd,
                            color: AppColors.c757575,
                            height: 24.h,
                          ),
                          title: 'Log Steps',
                        ),

                        UIHelper.horizontalSpace(20.w),

                        ///=========== LOG ACTIVITY =================
                        CustomLoogFood(
                          onTap: () {
                            NavigationService.navigateTo(
                              Routes.logActivityScreen,
                            );
                          },
                          icon: SvgPicture.asset(AppIcons.logactivity),
                          subtitle: 'Add your workout',
                          plusicon: SvgPicture.asset(
                            AppIcons.pluseadd,
                            height: 24.h,
                            color: AppColors.c757575,
                          ),
                          title: 'Log Activity',
                        ),
                      ],
                    ),

                    UIHelper.verticalSpace(24.h),

                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          height: 1.h,
                          width: double.infinity,
                          color: Colors.white12,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Row(
                            children: [
                              _buildTabItem(0, "Today’s Session"),
                              UIHelper.horizontalSpace(24.w),
                              _buildTabItem(1, "Today’s Activity"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    UIHelper.verticalSpace(20.h),

                    if (_selectedTab == 0)
                      StreamBuilder<ScheduleModel>(
                        stream: getScheduleRxObj.scheduleStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(color: AppColors.c87B842),
                            );
                          }

                          final sessions = _getSortedSessions(snapshot.data?.data);

                          if (sessions.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                                child: Text(
                                  'No scheduled tasks for today.',
                                  style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                    color: Colors.white30,
                                  ),
                                ),
                              ),
                            );
                          }

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: sessions.length,
                            separatorBuilder: (context, index) => UIHelper.verticalSpace(18.h),
                            itemBuilder: (context, index) {
                              final item = sessions[index];
                              final session = item['session'] as ScheduleSession;
                              final period = item['period'] as String;

                              final isCompleted = session.status?.toLowerCase() == 'completed';
                              final dotColor = isCompleted ? const Color(0xFF87B842) : const Color(0xFF5E5E5E);

                              final durationStr = session.duration != null ? '${session.duration} mins' : '';
                              final statusStr = session.status ?? 'upcoming';
                              String subtitle = statusStr.toUpperCase();
                              if (durationStr.isNotEmpty) subtitle = '$subtitle • $durationStr';

                              return CustomTimeLine(
                                color: dotColor,
                                title: session.sessionName ?? '',
                                subtitle: subtitle,
                                icon: _getIconForSession(session.sessionName ?? ''),
                                morningText: period,
                                amText: _formatTime(session.time),
                              );
                            },
                          );
                        },
                      )
                    else
                      StreamBuilder<DailyActivityModel>(
                        stream: dailyActivityRxObj.dailyActivityStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(color: AppColors.c87B842),
                            );
                          }

                          final activities = _getSortedActivities(snapshot.data?.data);

                          if (activities.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                                child: Text(
                                  'No activities recorded for today.',
                                  style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                    color: Colors.white30,
                                  ),
                                ),
                              ),
                            );
                          }

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: activities.length,
                            separatorBuilder: (context, index) => UIHelper.verticalSpace(18.h),
                            itemBuilder: (context, index) {
                              final item = activities[index];
                              final activity = item['activity'] as DailyActivityItem;
                              final period = item['period'] as String;

                              final isCompleted = activity.status?.toLowerCase() == 'completed';
                              final dotColor = isCompleted ? const Color(0xFF87B842) : const Color(0xFF5E5E5E);

                              final statusStr = activity.status ?? 'upcoming';

                              return CustomTimeLine(
                                color: dotColor,
                                title: activity.title ?? '',
                                subtitle: statusStr.toUpperCase(),
                                icon: _getIconForActivityType(activity.type, activity.title ?? ''),
                                morningText: period,
                                amText: activity.time ?? '',
                              );
                            },
                          );
                        },
                      ),

                    UIHelper.verticalSpace(44.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}