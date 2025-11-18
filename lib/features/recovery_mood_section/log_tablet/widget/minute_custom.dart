import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';

class MinuteCustom extends StatefulWidget {
  final Function(String minute)? onMinuteSelected;

  final String? initialMinute;

  const MinuteCustom({
    super.key,
    this.onMinuteSelected,
    this.initialMinute,
  });

  @override
  State<MinuteCustom> createState() => _MinuteCustomState();
}

class _MinuteCustomState extends State<MinuteCustom> {
  final List<String> minuteList =
      List.generate(13, (index) => (index * 5).toString().padLeft(2, '0'));

  late String selectedMinute;

  @override
  void initState() {
    super.initState();
    selectedMinute = widget.initialMinute ?? minuteList[0];
    if (widget.initialMinute != null &&
        minuteList.contains(widget.initialMinute)) {
      selectedMinute = widget.initialMinute!;
    }
  }

  String _formatMinute(String minute) {
    return '$minute min';
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
            selectedMinute = value;
          });

          debugPrint('========>>>>>>>>>Selected Minute: $value');

          widget.onMinuteSelected?.call(value);
        },
        itemBuilder: (BuildContext context) {
          return minuteList.map((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(
                _formatMinute(value),
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
              _formatMinute(selectedMinute),
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
