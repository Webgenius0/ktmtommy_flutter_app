import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';

class CustomNotification extends StatefulWidget {
  final Function(int minutes)? onMinutesSelected;


  final int? initialMinutes;

  const CustomNotification({
    super.key,
    this.onMinutesSelected,
    this.initialMinutes,
  });

  @override
  State<CustomNotification> createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> {

  final List<int> notificationMinutes = [10, 20, 30, 45, 60];

  late int selectedMinutes;

  @override
  void initState() {
    super.initState();
    selectedMinutes = widget.initialMinutes ?? 10;

    if (widget.initialMinutes != null && !notificationMinutes.contains(widget.initialMinutes)) {
      selectedMinutes = 10;
    }
  }

  String _formatDisplay(int minutes) {
    return '$minutes minutes before';
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
      child: PopupMenuButton<int>(
        color: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        offset: const Offset(0, 50),
        elevation: 4,
        onSelected: (int value) {
          setState(() {
            selectedMinutes = value;
          });

          debugPrint('Notification set: $value minutes before');

          widget.onMinutesSelected?.call(value);
        },
        itemBuilder: (BuildContext context) {
          return notificationMinutes.map((int minutes) {
            return PopupMenuItem<int>(
              value: minutes,
              child: Text(
                _formatDisplay(minutes),
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
              _formatDisplay(selectedMinutes),
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