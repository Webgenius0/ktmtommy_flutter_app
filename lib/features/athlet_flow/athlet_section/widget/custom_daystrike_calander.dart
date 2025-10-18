import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomDaystrikeCalander extends StatefulWidget {
  const CustomDaystrikeCalander({
    super.key,
  });

  @override
  State<CustomDaystrikeCalander> createState() => _CustomDaystrikeCalanderState();
}

class _CustomDaystrikeCalanderState extends State<CustomDaystrikeCalander> {
  DateTime currentWeekStart = _findFirstDateOfTheWeek(DateTime.now());
  int selectedIndex = -1;
  bool _showMonthView = false;

  static DateTime _findFirstDateOfTheWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday % 7));
  }

  List<DateTime> getWeekDays(DateTime firstDay) {
    return List.generate(7, (index) => firstDay.add(Duration(days: index)));
  }

  void _goToPreviousWeek() {
    setState(() {
      currentWeekStart = currentWeekStart.subtract(const Duration(days: 7));
      selectedIndex = -1;
    });
  }

  void _goToNextWeek() {
    setState(() {
      currentWeekStart = currentWeekStart.add(const Duration(days: 7));
      selectedIndex = -1;
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      int newMonth = currentWeekStart.month - 1;
      int newYear = currentWeekStart.year;

      if (newMonth < 1) {
        newMonth = 12;
        newYear--;
      }

      currentWeekStart = DateTime(newYear, newMonth, 1);
      currentWeekStart = _findFirstDateOfTheWeek(currentWeekStart);
    });
  }

  void _goToNextMonth() {
    setState(() {
      int newMonth = currentWeekStart.month + 1;
      int newYear = currentWeekStart.year;

      if (newMonth > 12) {
        newMonth = 1;
        newYear++;
      }

      currentWeekStart = DateTime(newYear, newMonth, 1);
      currentWeekStart = _findFirstDateOfTheWeek(currentWeekStart);
    });
  }

  String _formatWeekRange() {
    final firstDay = currentWeekStart;
    final lastDay = firstDay.add(const Duration(days: 6));
    return '${_getMonthName(firstDay.month)} ${firstDay.day} - ${_getMonthName(lastDay.month)} ${lastDay.day}';
  }

  String _getMonthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }


  void _toggleMonthView() {
    setState(() {
      _showMonthView = !_showMonthView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        decoration: ShapeDecoration(
          color: AppColors.c181818,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

  //================================ Week + Daystrike =================================//
            Row(
              children: [
                Text(
                  'Week 3',
                  style:  TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 16.sp,fontWeight: FontWeight.w500
                  )
                ),
                 Spacer(),
                SvgPicture.asset(AppIcons.powericon, height: 13.h),
                UIHelper.horizontalSpace(8.w),
                Text(
                  'Daystrike 5',
                  style:  TextFontStyle.textStyle14w400cF55216poppins.copyWith(
                    fontSize: 16.sp,fontWeight: FontWeight.w500
                  )
                ),
              ],
            ),
            UIHelper.verticalSpace(16.h),
//================================================= Week ========================//
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left, size: 24, color: Colors.white),
                  onPressed: _showMonthView ? _goToPreviousMonth : _goToPreviousWeek,
                ),
                UIHelper.horizontalSpace(8.w),
                GestureDetector(
                  onTap: _toggleMonthView,
                  child: Text(
                    _showMonthView
                        ? _getMonthName(currentWeekStart.month)
                        : _formatWeekRange(),
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontSize: 16.sp,fontWeight: FontWeight.w500
                    )
                  ),
                ),
                UIHelper.horizontalSpace(8.w),
                IconButton(
                  icon: Icon(Icons.chevron_right, size: 24, color: Colors.white),
                  onPressed: _showMonthView ? _goToNextMonth : _goToNextWeek,
                ),
              ],
            ),
            UIHelper.verticalSpace(20.h),

        //==================================== Day ================================//
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Sat
                _buildDayContainer('Sat', SvgPicture.asset(AppIcons.greensigneture, height: 17.h)),

                // Sun
                _buildDayContainer('Sun', SvgPicture.asset(AppIcons.crossicon, height: 17.h)),

                // Mon
                _buildDayContainer('Mon', SvgPicture.asset(AppIcons.greensigneture, height: 17.h)),

                // Tue
                _buildDayContainer('Tue', SvgPicture.asset(AppIcons.greensigneture, height: 17.h)),

                // Wed
                _buildDayContainer('Wed', SvgPicture.asset(AppIcons.bedicon, height: 17.h)),

                // Thu
                _buildDayContainer('Thu', SvgPicture.asset(AppIcons.greensigneture, height: 17.h)),

                // Fri
                _buildDayContainer('Fri', SvgPicture.asset(AppIcons.greensigneture, height: 17.h)),
              ],
            ),
          ],
        ),


    );
  }

  Widget _buildDayContainer(String dayName, Widget icon) {
    return Column(
      children: [
        Container(
         padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: AppColors.c101010,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              Text(
                dayName,
                style: TextFontStyle.textStyle14w400cBABABApoppins
              ),
              UIHelper.verticalSpace(8.h),
              icon,
            ],
          ),
        ),
      ],
    );
  }
}