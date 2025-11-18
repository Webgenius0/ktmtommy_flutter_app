import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';

class TimeCustom extends StatefulWidget {
  final Function(String time)? onTimeSelected;

  final String? initialTime;

  const TimeCustom({
    super.key,
    this.onTimeSelected,
    this.initialTime,
  });

  @override
  State<TimeCustom> createState() => _TimeCustomState();
}

class _TimeCustomState extends State<TimeCustom> {
  final List<String> durationList = [
    '15:30:00',
    '13:20:00',
    '12:30:00',
    '14:30:00',
    '20:10:00',
    '18:30:00',
    '09:00:00',
    '17:45:00',
  ];

  late String selectedUnit;

  @override
  void initState() {
    super.initState();
    selectedUnit = widget.initialTime ?? durationList[0];
  }

  String _formatTo12Hour(String time24) {
    final parts = time24.split(':');
    int hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: ShapeDecoration(
        color: AppColors.c2A2A2A,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: PopupMenuButton<String>(
        color: const Color(0xFF2A2A2A),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        offset: const Offset(0, 50),
        elevation: 4,
        onSelected: (String value) {
          setState(() {
            selectedUnit = value;
          });

          debugPrint('=======>>>>>>>>Selected Time (24-hour): $value');

          widget.onTimeSelected?.call(value);
        },
        itemBuilder: (BuildContext context) {
          return durationList.map((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(
                _formatTo12Hour(value),
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatTo12Hour(selectedUnit),
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SvgPicture.asset(AppIcons.timePopup, height: 18.h),
          ],
        ),
      ),
    );
  }
}
