
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';






class NotificationDropdwon extends StatefulWidget {
  final ValueChanged<String>? onNotificationSelected;

  const NotificationDropdwon({
    super.key,
    this.onNotificationSelected,
  });

  @override
  State<NotificationDropdwon> createState() => _NotificationDropdwonState();
}

class _NotificationDropdwonState extends State<NotificationDropdwon> {
  List<String> durationList = ['10 minutes before', '1 minutes before', '20 minutes before'];

  // Default selected value is the first item of the list
  late String selectedUnit = durationList[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      decoration: ShapeDecoration(
        color: AppColors.c2A2A2A,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: PopupMenuButton<String>(
        color: const Color(0xFF2A2A2A),
        onSelected: (String value) {
          setState(() {
            selectedUnit = value;
          });
          if (widget.onNotificationSelected != null) {
            widget.onNotificationSelected!(value);
          }
        },
        itemBuilder: (BuildContext context) {
          return durationList.map((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList();
        },
        offset: const Offset(30, 40),
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedUnit,
              maxLines: 1,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SvgPicture.asset(AppIcons.bottomdrodwonicon, height: 18.h),
          ],
        ),
      ),
    );
  }
}
