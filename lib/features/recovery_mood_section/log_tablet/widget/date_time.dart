
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';






class DateTimeSelector extends StatefulWidget {
  final DateTime initialDateTime;
  final ValueChanged<DateTime>? onDateTimeChanged;
  final bool restrictToCurrentMonth;

  DateTimeSelector({
    super.key,
    DateTime? initialDateTime,
    this.onDateTimeChanged,
    this.restrictToCurrentMonth = true,
  }) : initialDateTime = initialDateTime ?? DateTime.now();

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  late DateTime _selectedDateTime;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
    _selectedTime = TimeOfDay.fromDateTime(_selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
      decoration: ShapeDecoration(
       color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Column(
        children: [
          _buildTimeSelector(),
          UIHelper.verticalSpace(16.h),
          _buildAmPmIndicator(),
          UIHelper.verticalSpace(16.h),
          _buildDateSelector(),
        ],
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _handleTimePick,
          child: SvgPicture.asset(AppIcons.clockicon, height: 24.h),
        ),
        UIHelper.horizontalSpace(4.w),
        GestureDetector(
          onTap: _handleTimePick,
          child: Text(
            _selectedTime.format(context),
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins,
          ),
        ),
      ],
    );
  }

  Widget _buildAmPmIndicator() {
    final isAM = _selectedTime.hour < 12;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPeriodContainer('AM', isAM),
        UIHelper.horizontalSpace(16.w),
        _buildPeriodContainer('PM', !isAM),
      ],
    );
  }

  Widget _buildPeriodContainer(String period, bool isActive) {
    return Container(
      width: 70.h,
      padding: EdgeInsets.all(8.sp),
      decoration: ShapeDecoration(
       color: isActive ? AppColors.cCC1F28 : AppColors.c2F2F2F,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.r),
        ),
      ),
      child: Center(
        child: Text(
          period,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: isActive ? Colors.white : AppColors.cA3A3A3,
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: _handleDatePick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.calandericon, height: 24.h),
          UIHelper.horizontalSpace(5.w),
          Text(
            _formatDate(_selectedDateTime),
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _handleTimePick() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppColors.c181818,
              hourMinuteColor: AppColors.c2A2A2A,
              hourMinuteTextColor: AppColors.cFFFFFF,
              dialBackgroundColor: AppColors.c2A2A2A,
              dialTextColor: AppColors.cFFFFFF,
              entryModeIconColor: AppColors.c2A2A2A,
              dayPeriodColor: AppColors.c87B842,
              dayPeriodTextColor:AppColors.cFFFFFF,
            ),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
            colorScheme: const ColorScheme.dark(
              primary: AppColors.c87B842,
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
        _selectedTime = pickedTime;
        _updateDateTime();
      });
    }
  }





  Future<void> _handleDatePick() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: widget.restrictToCurrentMonth
          ? DateTime(_selectedDateTime.year, _selectedDateTime.month, 1)
          : DateTime(2000),
      lastDate: widget.restrictToCurrentMonth
          ? DateTime(_selectedDateTime.year, _selectedDateTime.month + 1, 0)
          : DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.black,
            colorScheme:  ColorScheme.dark(
              primary: AppColors.cFFFFFF,
              onSurface: Colors.white,
            ),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
          ),
          child: SizedBox(
              width: 250,
              height: 200,
              child: Transform.scale(
                scale: 0.85,
                child: child!,
              ),
              ),
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          _selectedDateTime.hour,
          _selectedDateTime.minute,
        );
        _notifyParent();
      });
    }
  }

  void _updateDateTime() {
    _selectedDateTime = DateTime(
      _selectedDateTime.year,
      _selectedDateTime.month,
      _selectedDateTime.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    _notifyParent();
  }

  void _notifyParent() {
    widget.onDateTimeChanged?.call(_selectedDateTime);
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} / "
        "${date.month.toString().padLeft(2, '0')} / "
        "${date.year}";
  }
}














