import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';

typedef OnDateSelected = void Function(DateTime selectedDate);

class LogActivityCalander extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final OnDateSelected? onDateSelected;

  const LogActivityCalander({
    super.key,
    required this.controller,
    required this.hintText,
    this.onDateSelected,
  });

  @override
  State<LogActivityCalander> createState() => _LogActivityCalanderState();
}

class _LogActivityCalanderState extends State<LogActivityCalander> {
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.cFFFFFF,
              onPrimary: AppColors.c2A2A2A,
              onSurface: AppColors.cFFFFFF,
              background: AppColors.c2A2A2A,
              surface: AppColors.c2A2A2A,
            ),
            dialogBackgroundColor: AppColors.c2A2A2A,
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.c2A2A2A,
              dividerColor: AppColors.cFFFFFF,
              headerForegroundColor: AppColors.cFFFFFF,
              dayOverlayColor: MaterialStateProperty.all(Colors.white10),
              yearOverlayColor: MaterialStateProperty.all(Colors.white10),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.cFFFFFF,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final String displayDate = DateFormat('dd MMM yyyy').format(picked);

      setState(() {
        widget.controller.text = displayDate;
      });

      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      isRead: true,
      textAlign: TextAlign.start,
      ontap: _selectDate,
      controller: widget.controller,
      borderRadius: 20.r,
      fillColor: AppColors.c2A2A2A,
      hintText: widget.hintText,
      hintTextSyle: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
        fontSize: 14.sp,
      ),
      style: const TextStyle(color: Colors.white),
      suffixIcon: Transform.scale(
        scale: 0.50,
        child: SvgPicture.asset(
          AppIcons.calandericon,
          height: 20,
        ),
      ),
    );
  }
}




typedef OnTimeSelected = void Function(DateTime selectedTime);

class LogActivityTimePicker extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final OnTimeSelected? onTimeSelected;

  const LogActivityTimePicker({
    super.key,
    required this.controller,
    required this.hintText,
    this.onTimeSelected,
  });

  @override
  State<LogActivityTimePicker> createState() => _LogActivityTimePickerState();
}

class _LogActivityTimePickerState extends State<LogActivityTimePicker> {
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.cFFFFFF,
              onPrimary: AppColors.c2A2A2A,
              onSurface: AppColors.cFFFFFF,
              background: AppColors.c2A2A2A,
              surface: AppColors.c2A2A2A,
            ),
            dialogBackgroundColor: AppColors.c2A2A2A,
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppColors.c2A2A2A,
              hourMinuteColor: AppColors.c2A2A2A,
              hourMinuteTextColor: AppColors.cFFFFFF,
              dialHandColor: AppColors.c87B842,
              dialBackgroundColor: AppColors.c2A2A2A,
              dialTextColor: AppColors.cFFFFFF,
              entryModeIconColor: AppColors.cFFFFFF,
              dayPeriodColor: AppColors.c2A2A2A,
              dayPeriodTextColor: AppColors.cFFFFFF,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.cFFFFFF,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final DateTime now = DateTime.now();
      final DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      final String displayTime = DateFormat('hh:mm a').format(selectedDateTime);

      setState(() {
        widget.controller.text = displayTime;
      });

      widget.onTimeSelected?.call(selectedDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      isRead: true,
      textAlign: TextAlign.start,
      ontap: _selectTime,
      controller: widget.controller,
      borderRadius: 20.r,
      fillColor: AppColors.c2A2A2A,
      hintText: widget.hintText,
      hintTextSyle: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
        fontSize: 14.sp,
      ),
      style: const TextStyle(color: Colors.white),
      suffixIcon: Transform.scale(
        scale: 0.50,
        child: SvgPicture.asset(
          AppIcons.clockicon, // You'll need a clock icon in your AppIcons
          height: 20,
        ),
      ),
    );
  }
}