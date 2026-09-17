import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_circular_progress.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/model/athlete_weekly_progress_model.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/widget/custom_shedul.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/widget/custom_daystrike_calander.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class AthletProgressScreen extends StatefulWidget {
  const AthletProgressScreen({super.key});

  @override
  State<AthletProgressScreen> createState() => _AthletProgressScreenState();
}

class _AthletProgressScreenState extends State<AthletProgressScreen> {
  String selectedButton = 'Workout Volume';
  int? _currentWeek;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _fetchProgress();
  }

  Future<void> _fetchProgress({int? week}) async {
    setState(() {
      _isFetching = true;
    });
    final response = await athleteWeeklyProgressRxObj.getWeeklyProgress(week: week);
    if (mounted) {
      setState(() {
        _isFetching = false;
        if (response?.data?.weekOverview?.selectedWeek != null) {
          _currentWeek = response!.data!.weekOverview!.selectedWeek;
        }
      });
    }
  }

  bool _checkIsFirstWeek(AthleteWeeklyProgressData? data) {
    final current = _currentWeek ?? data?.weekOverview?.selectedWeek ?? 3;
    final available = data?.availableWeeks;

    if (available != null && available.isNotEmpty) {
      final index = available.indexWhere((w) => w.week == current);
      if (index != -1) {
        return index == 0;
      }
    }
    return current <= 1;
  }

  bool _checkIsLastWeek(AthleteWeeklyProgressData? data) {
    final current = _currentWeek ?? data?.weekOverview?.selectedWeek ?? 3;
    final available = data?.availableWeeks;

    if (available != null && available.isNotEmpty) {
      final index = available.indexWhere((w) => w.week == current);
      if (index != -1) {
        return index == available.length - 1;
      }
    }
    return current >= 16;
  }

  void _onPreviousWeek(AthleteWeeklyProgressData? data) {
    if (_isFetching || _checkIsFirstWeek(data)) return;

    final current = _currentWeek ?? data?.weekOverview?.selectedWeek ?? 3;
    final available = data?.availableWeeks;

    if (available != null && available.isNotEmpty) {
      final currentIndex = available.indexWhere((w) => w.week == current);
      if (currentIndex > 0) {
        final prevWeek = available[currentIndex - 1].week;
        if (prevWeek != null) {
          _fetchProgress(week: prevWeek);
          return;
        }
      }
    }

    if (current > 1) {
      _fetchProgress(week: current - 1);
    }
  }

  void _onNextWeek(AthleteWeeklyProgressData? data) {
    if (_isFetching || _checkIsLastWeek(data)) return;

    final current = _currentWeek ?? data?.weekOverview?.selectedWeek ?? 3;
    final available = data?.availableWeeks;

    if (available != null && available.isNotEmpty) {
      final currentIndex = available.indexWhere((w) => w.week == current);
      if (currentIndex >= 0 && currentIndex < available.length - 1) {
        final nextWeek = available[currentIndex + 1].week;
        if (nextWeek != null) {
          _fetchProgress(week: nextWeek);
          return;
        }
      }
    }

    _fetchProgress(week: current + 1);
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: StreamBuilder<AthleteWeeklyProgressModel>(
              stream: athleteWeeklyProgressRxObj.getWeeklyProgressStream,
              builder: (context, snapshot) {
                final progressData = snapshot.data?.data;
                final planInfo = progressData?.planInfo;
                final readiness = progressData?.readiness;
                final weekOverview = progressData?.weekOverview;
                final chartDataList = progressData?.chartData;
                final aiInsight = progressData?.aiWeeklyInsight;

                final bool isFirstWeek = _checkIsFirstWeek(progressData);
                final bool isLastWeek = _checkIsLastWeek(progressData);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShedul(
                      text: 'My Progress',
                      subText: planInfo?.displayText,
                      onPillTap: () {
                        NavigationService.navigateToWithArgs(
                          Routes.your12WeekPlanScreen,
                          {'isFromProgress': true},
                        );
                      },
                    ),
                    UIHelper.verticalSpace(24.h),
                    Expanded(
                      child: _isFetching && progressData == null
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.orangeColor,
                              ),
                            )
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  CustomCircularProgress(
                                    title: 'RACE READINESS',
                                    score: readiness?.score,
                                    readinessTitle: readiness?.title,
                                    subtitle: readiness?.subtitle,
                                  ),
                                  UIHelper.verticalSpace(24.h),

                                  // Date & Week Calendar
                                  CustomDaystrikeCalander(
                                    selectedWeek: weekOverview?.selectedWeek ?? _currentWeek,
                                    daystreak: weekOverview?.daystreak,
                                    dateRange: weekOverview?.dateRange,
                                    days: weekOverview?.days,
                                    isFirstWeek: isFirstWeek,
                                    isLastWeek: isLastWeek,
                                    isLoading: _isFetching,
                                    onPreviousWeek: () => _onPreviousWeek(progressData),
                                    onNextWeek: () => _onNextWeek(progressData),
                                  ),
                                  UIHelper.verticalSpace(24.h),

                                  // Line Chart Section
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Workout Volume",
                                        style: TextFontStyle.textStyle24w700cFFFFFFTeko,
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpace(18.h),
                                  SizedBox(
                                    height: 204.h,
                                    width: 320.w,
                                    child: LineChart(getChartData(chartDataList)),
                                  ),
                                  UIHelper.verticalSpace(24.h),

                                  // AI Insight Box
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(16.r),
                                    decoration: ShapeDecoration(
                                      color: AppColors.c202020,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.r),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          AppIcons.linecharticon,
                                          height: 40.h,
                                        ),
                                        UIHelper.horizontalSpace(8.w),
                                        Expanded(
                                          child: Text(
                                            aiInsight?.insight ??
                                                'AI Insight: Your training balance is excellent — risk of injury low.',
                                            style: TextFontStyle
                                                .textStyle24w600cFFFFFFpoppins
                                                .copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  UIHelper.verticalSpace(20.h),
                                ],
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  LineChartData getChartData(List<ChartData>? chartDataList) {
    List<FlSpot> spots = [];
    List<String> xLabels = [];

    if (chartDataList != null && chartDataList.isNotEmpty) {
      for (int i = 0; i < chartDataList.length; i++) {
        final item = chartDataList[i];
        spots.add(FlSpot(i.toDouble(), (item.percentage ?? 0).toDouble()));
        xLabels.add(item.dayShort ?? item.dayName ?? '');
      }
    } else {
      spots = const [
        FlSpot(0, 0), FlSpot(1, 0), FlSpot(2, 0), FlSpot(3, 0),
        FlSpot(4, 0), FlSpot(5, 0), FlSpot(6, 0),
      ];
      xLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    }

    double maxY = 100;
    double minY = 0;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: maxY / 5,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) => FlLine(
          color: AppColors.cFFFFFF.withValues(alpha: 0.2),
          strokeWidth: 1,
          dashArray: [4, 4],
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: AppColors.cFFFFFF.withValues(alpha: 0.2),
          strokeWidth: 1,
          dashArray: [4, 4],
        ),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: maxY / 5,
            getTitlesWidget: (value, meta) => Text(
              value.toInt().toString(),
              style: TextStyle(color: AppColors.cFFFFFF, fontSize: 12.sp),
            ),
          ),
        ),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              int index = value.toInt();
              if (index >= 0 && index < xLabels.length) {
                return Text(
                  xLabels[index],
                  style: TextStyle(color: AppColors.cFFFFFF, fontSize: 12.sp),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: AppColors.c666666.withValues(alpha: 0.2)),
      ),
      minX: 0,
      maxX: (xLabels.length - 1).toDouble() > 0 ? (xLabels.length - 1).toDouble() : 6,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: AppColors.orangeColor,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.orangeColor.withValues(alpha: 0.4),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
