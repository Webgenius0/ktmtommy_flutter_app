
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class DateWidget extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;
  final Color? selectedColor;
  final Color? textColor;
  final Color? unselectedTextColor;
  final TextStyle? dayAbbreviationStyle;
  final TextStyle? dateTextStyle;
  final TextStyle? weekRangeTextStyle;

  const DateWidget({
    super.key,
    this.onDateSelected,
    this.selectedColor,
    this.textColor,
    this.unselectedTextColor,
    this.dayAbbreviationStyle,
    this.dateTextStyle,
    this.weekRangeTextStyle,
  });

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  late int selectedIndex;
  DateTime currentWeekStart = _findFirstDateOfTheWeek(DateTime.now());

  @override
  void initState() {
    super.initState();
    // Set selectedIndex to today's weekday index in the current week
    final today = DateTime.now();
    selectedIndex = today.difference(currentWeekStart).inDays;
  }

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

  String _formatWeekRange() {
    final firstDay = currentWeekStart;
    final lastDay = firstDay.add(const Duration(days: 6));
    return '${_getMonthName(firstDay.month)} ${firstDay.day} - ${_getMonthName(lastDay.month)} ${lastDay.day}';
  }

  String _getMonthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = getWeekDays(currentWeekStart);
    final dayAbbreviations = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _goToPreviousWeek,
              child: Icon(
                Icons.chevron_left,
                size: 24,
                color: widget.textColor ?? AppColors.cFFFFFF,
              ),
            ),
            UIHelper.horizontalSpace(6.w),
            Text(
              _formatWeekRange(),
              textAlign: TextAlign.center,
              style: widget.weekRangeTextStyle ??
                  TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: widget.textColor ?? AppColors.cFFFFFF,
                  ),
            ),
            UIHelper.horizontalSpace(6.w),
            GestureDetector(
              onTap: _goToNextWeek,
              child: Icon(
                Icons.chevron_right,
                size: 24,
                color: widget.textColor ?? AppColors.cFFFFFF,
              ),
            ),
          ],
        ),
        UIHelper.verticalSpace(18.h),

        // Day abbreviations row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            return SizedBox(
              width: 40.w,
              child: Text(
                dayAbbreviations[index],
                textAlign: TextAlign.center,
                style: widget.dayAbbreviationStyle ??
                    TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: widget.unselectedTextColor ?? Colors.grey,
                    ),
              ),
            );
          }),
        ),
        UIHelper.verticalSpace(10.h),

        // Dates row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final date = weekDays[index];
            bool isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                if (widget.onDateSelected != null) {
                  widget.onDateSelected!(date);
                }
              },
              child: Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? widget.selectedColor ?? AppColors.cCC1F28
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: widget.dateTextStyle ??
                        TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: isSelected
                              ? Colors.white
                              : widget.textColor ?? Colors.white,
                        ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
