import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class CustomMinitues extends StatefulWidget {
  final ValueChanged<int>? onHoursChanged;
  final ValueChanged<int>? onMinutesChanged;
  final int initialHours;
  final int initialMinutes;

  const CustomMinitues({
    super.key,
    this.onHoursChanged,
    this.onMinutesChanged,
    this.initialHours = 0,
    this.initialMinutes = 15,
  });

  @override
  State<CustomMinitues> createState() => _CustomMinituesState();
}

class _CustomMinituesState extends State<CustomMinitues> {
  late int hours;
  late int minutes;

  @override
  void initState() {
    super.initState();
    hours = widget.initialHours;
    minutes = widget.initialMinutes;
  }

  void _incrementHours() {
    setState(() {
      hours++;
      widget.onHoursChanged?.call(hours);
    });
  }

  void _decrementHours() {
    if (hours > 0) {
      setState(() {
        hours--;
        widget.onHoursChanged?.call(hours);
      });
    }
  }

  void _incrementMinutes() {
    setState(() {
      minutes++;
      if (minutes >= 60) {
        minutes = 0;
        hours++;
        widget.onHoursChanged?.call(hours);
      }
      widget.onMinutesChanged?.call(minutes);
    });
  }

  void _decrementMinutes() {
    setState(() {
      if (minutes > 0) {
        minutes--;
      } else if (hours > 0) {
        minutes = 59;
        hours--;
        widget.onHoursChanged?.call(hours);
      }
      widget.onMinutesChanged?.call(minutes);
    });
  }

  Widget _buildTimeControl({
    required String label,
    required String value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextFontStyle.textStyle14w400cA3A3A3poppins),
        UIHelper.verticalSpace(4.h),
        Container(
          decoration: ShapeDecoration(
            color: AppColors.c2A2A2A,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              spacing: 6,
              children: [
                GestureDetector(
                  onTap: onDecrement,
                  child: SvgPicture.asset(AppIcons.mintuesicon, height: 18.h),
                ),
                UIHelper.horizontalSpace(16.w),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle14w400cBABABApoppins.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                UIHelper.horizontalSpace(16.w),
                GestureDetector(
                  onTap: onIncrement,
                  child: SvgPicture.asset(AppIcons.plusiconadd, height: 18.h),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTimeControl(
          label: 'Hours',
          value: hours.toString(),
          onDecrement: _decrementHours,
          onIncrement: _incrementHours,
        ),
        //UIHelper.horizontalSpace(16.w),
        Spacer(),
        _buildTimeControl(
          label: 'Minutes',
          value: minutes.toString().padLeft(2, '0'),
          onDecrement: _decrementMinutes,
          onIncrement: _incrementMinutes,
        ),
      ],
    );
  }
}
