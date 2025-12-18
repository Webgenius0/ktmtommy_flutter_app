
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/calander_today.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:intl/intl.dart';

import '../../../../networks/api_acess.dart';

class CustomNightDayTime extends StatefulWidget {

  const CustomNightDayTime({
    super.key,
  });

  @override
  State<CustomNightDayTime> createState() => _CustomNightDayTimeState();
}

class _CustomNightDayTimeState extends State<CustomNightDayTime> {
  late TextEditingController dateController = TextEditingController();
  TimeOfDay _selectedBedTime = TimeOfDay(hour: 22, minute: 30);
  TimeOfDay _selectedWakeUpTime = TimeOfDay(hour: 6, minute: 45);
  String _bedTimeText = '10:30 PM';
  String _wakeUpTimeText = '06:45 AM';
  String _totalSleepTime = '8h 15m';
  DateTime _selectedDate = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Set initial date text
    dateController.text = _formatDate(_selectedDate);
    _updateBedTimeText();
    _updateWakeUpTimeText();
    _calculateSleepDuration();
  }

  String _formatDate(DateTime date) {
    return DateFormat("'Today' dd MMM, yy").format(date);
  }

  void _updateBedTimeText() {
    setState(() {
      _bedTimeText = _formatTime(_selectedBedTime);
    });
  }

  void _updateWakeUpTimeText() {
    setState(() {
      _wakeUpTimeText = _formatTime(_selectedWakeUpTime);
    });
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  void _calculateSleepDuration() {
    DateTime bedDateTime = DateTime(2023, 1, 1, _selectedBedTime.hour, _selectedBedTime.minute);
    DateTime wakeDateTime = DateTime(2023, 1, 1, _selectedWakeUpTime.hour, _selectedWakeUpTime.minute);

    if (wakeDateTime.isBefore(bedDateTime)) {
      wakeDateTime = wakeDateTime.add(const Duration(days: 1));
    }

    Duration difference = wakeDateTime.difference(bedDateTime);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);

    setState(() {
      _totalSleepTime = '${hours}h ${minutes}m';
    });
  }

  // Function to get the date display text
  String _getDateDisplayText() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDay = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);

    if (selectedDay == today) {
      return 'Today';
    } else if (selectedDay == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return DateFormat('dd MMM, yy').format(_selectedDate);
    }
  }

  Future<void> _handleDatePick() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)), // 10 years forward
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.orangeColor,
              onPrimary: Colors.white,
              surface: AppColors.c181818,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: AppColors.c181818,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        dateController.text = _formatDate(_selectedDate);
      });
    }
  }

  Future<void> _handleBedTimePick() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedBedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppColors.c181818,
              hourMinuteColor: AppColors.orangeColor,
              hourMinuteTextColor: AppColors.cFFFFFF,
              dialBackgroundColor: AppColors.c2A2A2A,
              dialTextColor: AppColors.cFFFFFF,
              entryModeIconColor: AppColors.c2A2A2A,
              dayPeriodColor: AppColors.orangeColor,
              dayPeriodTextColor: AppColors.cFFFFFF,
            ),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
            colorScheme: ColorScheme.dark(
              primary: AppColors.orangeColor,
              onSurface: Colors.white,
            ),
          ),
          child: Center(
            child: SizedBox(
              width: 350,
              height: 500,
              child: Transform.scale(
                scale: 0.90,
                child: child!,
              ),
            ),
          ),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _selectedBedTime = pickedTime;
        _updateBedTimeText();
        _calculateSleepDuration();
      });
    }
  }

  Future<void> _handleWakeUpTimePick() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedWakeUpTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppColors.c181818,
              hourMinuteColor: AppColors.orangeColor,
              hourMinuteTextColor: AppColors.cFFFFFF,
              dialBackgroundColor: AppColors.c2A2A2A,
              dialTextColor: AppColors.cFFFFFF,
              entryModeIconColor: AppColors.c2A2A2A,
              dayPeriodColor: AppColors.orangeColor,
              dayPeriodTextColor: AppColors.cFFFFFF,
            ),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
            colorScheme: ColorScheme.dark(
              primary: AppColors.orangeColor,
              onSurface: Colors.white,
            ),
          ),
          child: Center(
            child: SizedBox(
              width: 350,
              height: 500,
              child: Transform.scale(
                scale: 0.90,
                child: child!,
              ),
            ),
          ),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _selectedWakeUpTime = pickedTime;
        _updateWakeUpTimeText();
        _calculateSleepDuration();
      });
    }
  }



  String convertTo24HourFormat(String time12Hour) {
    try {
      // Remove any AM/PM indicators and trim whitespace
      String cleanedTime = time12Hour.replaceAll(RegExp(r'[APMapm\s]'), '').trim();

      // Parse hours and minutes
      List<String> parts = cleanedTime.split(':');
      if (parts.length != 2) return time12Hour; // Return original if format is unexpected

      int hour = int.tryParse(parts[0]) ?? 0;
      int minute = int.tryParse(parts[1]) ?? 0;

      // Determine if it's PM (assuming original time12Hour contains PM indicator)
      bool isPM = time12Hour.toLowerCase().contains('pm');

      // Convert to 24-hour format
      if (isPM && hour < 12) {
        hour += 12;
      } else if (!isPM && hour == 12) {
        hour = 0; // 12 AM becomes 00
      }

      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return time12Hour; // Return original if conversion fails
    }
  }

  Future<void> _saveSleepData() async {
    setState(() {
      isLoading = true;
    });

    // Use the selected date instead of current date
    String dateText = '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';

    // Convert existing time strings to 24-hour format
    String bedTime24 = convertTo24HourFormat(_bedTimeText);
    String wakeUpTime24 = convertTo24HourFormat(_wakeUpTimeText);

    bool success = await saveSleepRx.saveSleepApiInfo(
        date: dateText,
        bedTime: bedTime24,
        wakeUpTime: wakeUpTime24
    );

    setState(() {
      isLoading = false;
    });

    if(success){
      getRecentSleepRx.getRecentSleepInfo();
    }

    // Print to console for debugging
    print('Sleep data saved!');
    print('Date: $dateText');
    print('Bedtime: $bedTime24');
    print('Wake up time: $wakeUpTime24');
    print('Total sleep time: $_totalSleepTime');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sleep data saved successfully!'),
        backgroundColor: AppColors.orangeColor,
      ),
    );
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
      child: Column(
        children: [
          // Date picker - make it clickable
          GestureDetector(
            onTap: _handleDatePick,
            child: AbsorbPointer(
              child: CalanderToday(
                controller: dateController,
                hintText: _formatDate(_selectedDate),
              ),
            ),
          ),
          UIHelper.verticalSpace(24.h),
          Row(
            children: [
              Image.asset(AppImages.bedtime, height: 20.h),
              UIHelper.horizontalSpace(6.w),
              Text(
                'Bedtime',
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          UIHelper.verticalSpace(12.h),
          GestureDetector(
            onTap: _handleBedTimePick,
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                color: AppColors.c2A2A2A,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.clockicon,
                      color: AppColors.orangeColor,
                      height: 24.h,
                    ),
                    UIHelper.horizontalSpace(8.w),
                    Text(
                      _bedTimeText,
                      textAlign: TextAlign.center,
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          UIHelper.verticalSpace(24.h),
          Row(
            children: [
              Image.asset(AppImages.wakeup, height: 20.h),
              UIHelper.horizontalSpace(6.w),
              Text(
                'Wake up',
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          UIHelper.verticalSpace(12.h),
          GestureDetector(
            onTap: _handleWakeUpTimePick,
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                color: AppColors.c2A2A2A,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.clockicon,
                      color: AppColors.orangeColor,
                      height: 24.h,
                    ),
                    UIHelper.horizontalSpace(8.w),
                    Text(
                      _wakeUpTimeText,
                      textAlign: TextAlign.center,
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          UIHelper.verticalSpace(24.h),
          Container(
            width: 193.w,
            height: 70.h,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.w,
                  color: const Color(0xFFF55216),
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.bedimage, height: 24.h),
                UIHelper.horizontalSpace(8.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Total Sleep time',
                      textAlign: TextAlign.center,
                      style: TextFontStyle.textStyle16w400c757575poppins,
                    ),
                    UIHelper.verticalSpace(2.h),
                    Text(
                      _totalSleepTime,
                      textAlign: TextAlign.center,
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 18.sp,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          UIHelper.verticalSpace(24.h),
          InkWell(
            onTap:isLoading ?null: _saveSleepData,
            borderRadius: BorderRadius.circular(12.r),
            child: CustomButtonWidget(
              textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
                fontWeight: FontWeight.w500,
              ),
              image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
              text: isLoading?'Save Sleeping':'Save Sleep',
            ),
          ),
        ],
      ),
    );
  }
}