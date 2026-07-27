
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_circular_progress.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/widget/custom_shedul.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/widget/custom_daystrike_calander.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class AthletProgressScreen extends StatefulWidget {
  const AthletProgressScreen({super.key});

  @override
  State<AthletProgressScreen> createState() => _AthletProgressScreenState();
}

class _AthletProgressScreenState extends State<AthletProgressScreen> {

  String selectedButton = 'Workout Volume';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShedul(text: 'My Progress'),
                UIHelper.verticalSpace(24.h),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        CustomCircularProgress(title: 'RACE READINESS'),
                        UIHelper.verticalSpace(24.h),

                        //=============================== Date ================================//

                        CustomDaystrikeCalander(),
                        UIHelper.verticalSpace(24.h),


                        //=================================== Line chart ======================================//

                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Workout Volume", style: TextFontStyle.textStyle24w700cFFFFFFTeko,),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     buildButton('Workout Volume'),
                        //     // UIHelper.horizontalSpace(8.w),
                        //     // buildButton('VO2 Max'),
                        //     // UIHelper.horizontalSpace(8.w),
                        //     // buildButton('Heart Rate'),
                        //   ],
                        // ),
                        UIHelper.verticalSpace(18.h),

                        SizedBox(
                          height: 204.h,
                          width: 320.w,
                          child: LineChart(getChartData()),
                        ),



                        UIHelper.verticalSpace(24.h),



                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: ShapeDecoration(
                            color: AppColors.c202020,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                  AppIcons.linecharticon, height: 40.h),
                              UIHelper.horizontalSpace(8.w),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 215,
                                    child: Text(
                                        'AI Insight: Your training balance is excellent — risk of injury low.',
                                        style: TextFontStyle
                                            .textStyle24w600cFFFFFFpoppins
                                            .copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                        )
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(20.h),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


//============================== graphchart ===================================================//


  Widget buildButton(String title) {
    final isSelected = selectedButton == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButton = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: AppColors.c181818,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isSelected ? AppColors.orangeColor : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

// Chart data for different metrics
  LineChartData getChartData() {
    List<FlSpot> spots;
    double maxY;
    double minY = 0;
    List<String> xLabels;

    if (selectedButton == 'Workout Volume') {
      spots = [
        FlSpot(0, 50),
        FlSpot(1, 60),
        FlSpot(2, 30),
        FlSpot(3, 75),
        FlSpot(4, 0),
        FlSpot(5, 90),
        FlSpot(6, 50),
      ];
      maxY = 100;
      xLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    } else if (selectedButton == 'VO2 Max') {
      spots = [
        FlSpot(0, 30),
        FlSpot(1, 35),
        FlSpot(2, 32),
        FlSpot(3, 40),
        FlSpot(4, 38),
        FlSpot(5, 45),
        FlSpot(6, 42),
      ];
      maxY = 50;
      xLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    } else {
      // Heart Rate
      spots = [
        FlSpot(0, 70),
        FlSpot(1, 75),
        FlSpot(2, 80),
        FlSpot(3, 78),
        FlSpot(4, 82),
        FlSpot(5, 85),
        FlSpot(6, 80),
      ];
      maxY = 200;
      xLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: maxY / 5,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) =>
            FlLine(
              color: AppColors.cFFFFFF.withOpacity(0.2),
              strokeWidth: 1,
              dashArray: [4, 4],
            ),
        getDrawingVerticalLine: (value) =>
            FlLine(
              color: AppColors.cFFFFFF.withOpacity(0.2),
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
            getTitlesWidget: (value, meta) =>
                Text(
                  value.toInt().toString(),
                  style: TextStyle(color: AppColors.cFFFFFF, fontSize: 12.sp),
                ),
          ),
        ),
        rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              return Text(
                xLabels[value.toInt()],
                style: TextStyle(color: AppColors.cFFFFFF, fontSize: 12.sp),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: AppColors.c666666.withOpacity(0.2)),
      ),
      minX: 0,
      maxX: 6,
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
                AppColors.orangeColor.withOpacity(0.4),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

// In your build method, Row of buttons
}
