import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/balance_dialouge_box.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/tbi_recovery.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/custom_morning.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/date_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/model/schedule_model.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/model/daily_activity_model.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedTab = 0; // 0 for Today's Session, 1 for Today's Activity
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);
    if (_selectedTab == 0) {
      getScheduleRxObj.getSchedule(dateStr);
    } else {
      dailyActivityRxObj.getDailyActivity(dateStr);
    }
  }

  Widget _getIconForActivityType(String? type, String title) {
    final lowerType = type?.toLowerCase() ?? '';
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
    return SvgPicture.asset(AppIcons.shedulicon); // Default
  }

  Widget _buildTabItem(int index, String title) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        if (_selectedTab != index) {
          setState(() {
            _selectedTab = index;
          });
          _fetchData();
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

  Widget _buildActivitySection(String title, List<DailyActivityItem>? activities) {
    if (activities == null || activities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(12.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activities.length,
          separatorBuilder: (context, index) => UIHelper.verticalSpace(12.h),
          itemBuilder: (context, index) {
            final activity = activities[index];
            final timeStr = activity.time ?? '';
            final statusStr = activity.status ?? '';

            String subtitle = timeStr;
            if (statusStr.isNotEmpty) subtitle += ' • ${statusStr.toUpperCase()}';

            return CustomMorning(
              title: activity.title ?? '',
              subtitle: subtitle,
              icon: _getIconForActivityType(activity.type, activity.title ?? ''),
            );
          },
        ),
        UIHelper.verticalSpace(24.h),
      ],
    );
  }

  Widget _buildSection(String title, List<ScheduleSession>? sessions) {
    if (sessions == null || sessions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(12.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sessions.length,
          separatorBuilder: (context, index) => UIHelper.verticalSpace(12.h),
          itemBuilder: (context, index) {
            final session = sessions[index];
            final timeStr = session.time ?? '';
            final durationStr = session.duration != null ? '${session.duration} mins' : '';
            final statusStr = session.status ?? '';

            String subtitle = timeStr;
            if (durationStr.isNotEmpty) subtitle += ' • $durationStr';
            if (statusStr.isNotEmpty) subtitle += ' • ${statusStr.toUpperCase()}';

            return CustomMorning(
              title: session.sessionName ?? '',
              subtitle: subtitle,
              icon: SvgPicture.asset(AppIcons.shedulicon),
            );
          },
        ),
        UIHelper.verticalSpace(24.h),
      ],
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
              padding: EdgeInsets.all(24.sp),
              child: TBIRecovery(title: 'Schedule', widget: Image.asset(AppImages.logo225)),
            ),
            UIHelper.verticalSpace(18.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DateWidget(
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                        _fetchData();
                      },
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
                    UIHelper.verticalSpace(24.h),

                    if (_selectedTab == 0)
                      StreamBuilder<ScheduleModel>(
                        stream: getScheduleRxObj.scheduleStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(color: AppColors.c87B842),
                            );
                          }

                          final data = snapshot.data?.data;
                          final hasNight = data?.night != null && data!.night!.isNotEmpty;
                          final hasMorning = data?.morning != null && data!.morning!.isNotEmpty;
                          final hasAfternoon = data?.afternoon != null && data!.afternoon!.isNotEmpty;
                          final hasEvening = data?.evening != null && data!.evening!.isNotEmpty;

                          final noData = !hasNight && !hasMorning && !hasAfternoon && !hasEvening;

                          if (noData) {
                            return Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 40.h),
                              child: Text(
                                'No scheduled sessions for this day.',
                                style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                  color: Colors.white60,
                                ),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSection('Morning', data.morning),
                              _buildSection('Afternoon', data.afternoon),
                              _buildSection('Evening', data.evening),
                              _buildSection('Night', data.night),
                            ],
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

                          final data = snapshot.data?.data;
                          final hasNight = data?.night != null && data!.night!.isNotEmpty;
                          final hasMorning = data?.morning != null && data!.morning!.isNotEmpty;
                          final hasAfternoon = data?.afternoon != null && data!.afternoon!.isNotEmpty;
                          final hasEvening = data?.evening != null && data!.evening!.isNotEmpty;

                          final noData = !hasNight && !hasMorning && !hasAfternoon && !hasEvening;

                          if (noData) {
                            return Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 40.h),
                              child: Text(
                                'No activities recorded for this day.',
                                style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                  color: Colors.white60,
                                ),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildActivitySection('Morning', data.morning),
                              _buildActivitySection('Afternoon', data.afternoon),
                              _buildActivitySection('Evening', data.evening),
                              _buildActivitySection('Night', data.night),
                            ],
                          );
                        },
                      ),

                    UIHelper.verticalSpace(24.h),
                    CustomButton(
                      name: "Complete The Day",
                      onCallBack: () {
                        showDialog(
                          context: context,
                          builder: (context) => const BalanceDialog(),
                        );
                      },
                      context: context,
                      color: Colors.transparent,
                      borderRadius: 50.r,
                      borderColor: const Color(0xFF87B842),
                    ),
                    UIHelper.verticalSpace(32.w),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: AppColors.c87B842,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(Icons.add, color: AppColors.c181818),
          onPressed: () {
            NavigationService.navigateTo(Routes.addSessionScreen);
          },
        ),
      ),
    );
  }
}


