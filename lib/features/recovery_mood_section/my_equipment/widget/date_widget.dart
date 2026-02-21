//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
// import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
//
//
//
//
//
// class DateWidget extends StatefulWidget {
//   final ValueChanged<DateTime>? onDateSelected;
//   final Color? selectedColor;
//   final Color? textColor;
//   final Color? unselectedTextColor;
//   final TextStyle? dayAbbreviationStyle;
//   final TextStyle? dateTextStyle;
//   final TextStyle? weekRangeTextStyle;
//
//   const DateWidget({
//     super.key,
//     this.onDateSelected,
//     this.selectedColor,
//     this.textColor,
//     this.unselectedTextColor,
//     this.dayAbbreviationStyle,
//     this.dateTextStyle,
//     this.weekRangeTextStyle,
//   });
//
//   @override
//   State<DateWidget> createState() => _DateWidgetState();
// }
//
// class _DateWidgetState extends State<DateWidget> {
//   late int selectedIndex;
//   DateTime currentWeekStart = _findFirstDateOfTheWeek(DateTime.now());
//
//   @override
//   void initState() {
//     super.initState();
//     // Set selectedIndex to today's weekday index in the current week
//     final today = DateTime.now();
//     selectedIndex = today.difference(currentWeekStart).inDays;
//   }
//
//   static DateTime _findFirstDateOfTheWeek(DateTime date) {
//     return date.subtract(Duration(days: date.weekday % 7));
//   }
//
//   List<DateTime> getWeekDays(DateTime firstDay) {
//     return List.generate(7, (index) => firstDay.add(Duration(days: index)));
//   }
//
//   void _goToPreviousWeek() {
//     setState(() {
//       currentWeekStart = currentWeekStart.subtract(const Duration(days: 7));
//       selectedIndex = -1;
//     });
//   }
//
//   void _goToNextWeek() {
//     setState(() {
//       currentWeekStart = currentWeekStart.add(const Duration(days: 7));
//       selectedIndex = -1;
//     });
//   }
//
//   String _formatWeekRange() {
//     final firstDay = currentWeekStart;
//     final lastDay = firstDay.add(const Duration(days: 6));
//     return '${_getMonthName(firstDay.month)} ${firstDay.day} - ${_getMonthName(lastDay.month)} ${lastDay.day}';
//   }
//
//   String _getMonthName(int month) {
//     const months = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec"
//     ];
//     return months[month - 1];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final weekDays = getWeekDays(currentWeekStart);
//     final dayAbbreviations = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
//
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: _goToPreviousWeek,
//               child: Icon(
//                 Icons.chevron_left,
//                 size: 24,
//                 color: widget.textColor ?? AppColors.cFFFFFF,
//               ),
//             ),
//             UIHelper.horizontalSpace(6.w),
//             Text(
//               _formatWeekRange(),
//               textAlign: TextAlign.center,
//               style: widget.weekRangeTextStyle ??
//                   TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w500,
//                     color: widget.textColor ?? AppColors.cFFFFFF,
//                   ),
//             ),
//             UIHelper.horizontalSpace(6.w),
//             GestureDetector(
//               onTap: _goToNextWeek,
//               child: Icon(
//                 Icons.chevron_right,
//                 size: 24,
//                 color: widget.textColor ?? AppColors.cFFFFFF,
//               ),
//             ),
//           ],
//         ),
//         UIHelper.verticalSpace(18.h),
//
//         // Day abbreviations row
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: List.generate(7, (index) {
//             return SizedBox(
//               width: 40.w,
//               child: Text(
//                 dayAbbreviations[index],
//                 textAlign: TextAlign.center,
//                 style: widget.dayAbbreviationStyle ??
//                     TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w400,
//                       color: widget.unselectedTextColor ?? Colors.grey,
//                     ),
//               ),
//             );
//           }),
//         ),
//         UIHelper.verticalSpace(10.h),
//
//         // Dates row
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: List.generate(7, (index) {
//             final date = weekDays[index];
//             bool isSelected = index == selectedIndex;
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//                 if (widget.onDateSelected != null) {
//                   widget.onDateSelected!(date);
//                 }
//               },
//               child: Container(
//                 height: 40.h,
//                 width: 40.h,
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? widget.selectedColor ?? AppColors.cCC1F28
//                       : Colors.transparent,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Text(
//                     date.day.toString(),
//                     style: widget.dateTextStyle ??
//                         TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                           color: isSelected
//                               ? Colors.white
//                               : widget.textColor ?? Colors.white,
//                         ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    final days = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
    final dates = ['19', '20', '21', '22', '23', '24', '25'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            const Icon(Icons.chevron_left, color: Colors.white, size: 26),
            SizedBox(width: 8.w),
            Text(
              'May 13 - May 19',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8.w),
            const Icon(Icons.chevron_right, color: Colors.white, size: 26),
          ],
        ),

        SizedBox(height: 18.h),

        /// Days
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            return SizedBox(
              width: 44.w,
              child: Text(
                days[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13.sp,
                ),
              ),
            );
          }),
        ),

        SizedBox(height: 12.h),

        /// Dates
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            return _DateCircle(
              label: dates[index],
              isSelected: index == selectedIndex,
              type: index == 0
                  ? DateType.crown
                  : index == 1
                  ? DateType.star
                  : index == 2
                  ? DateType.disabled
                  : DateType.normal,
              onTap: () {
                setState(() => selectedIndex = index);
              },
            );
          }),
        ),
      ],
    );
  }
}

enum DateType { crown, star, disabled, normal }

class _DateCircle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final DateType type;
  final VoidCallback onTap;

  const _DateCircle({
    required this.label,
    required this.isSelected,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.transparent;
    Widget? icon;
    Color textColor = Colors.white;

    if (type == DateType.crown) {
      bgColor = const Color(0xFFFFC107); // yellow
      icon = SvgPicture.asset(AppIcons.bestIcon,height: 20,);
    } else if (type == DateType.star) {
      bgColor = const Color(0xFF4CAF50); // green
      icon = SvgPicture.asset(AppIcons.goodIcon,height: 20,);
    } else if (type == DateType.disabled) {
      bgColor = const Color(0xFF5A5A5A); // grey
      icon = SvgPicture.asset(AppIcons.poorIcon,height: 20,);
      textColor = Colors.white70;
    }

    return GestureDetector(
      onTap: type == DateType.disabled ? null : onTap,
      child: Container(
        width: 38.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(50),
            left: Radius.circular(50)
          ),
          border: isSelected
              ? Border.all(color: Colors.red, width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (icon != null) ...[
              SizedBox(height: 2.h),
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}

