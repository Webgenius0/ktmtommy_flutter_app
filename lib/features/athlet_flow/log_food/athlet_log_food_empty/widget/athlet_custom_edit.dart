
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class AthletCustomEdit extends StatefulWidget {
  const AthletCustomEdit({super.key});

  @override
  State<AthletCustomEdit> createState() => _AthletCustomEditState();
}

class _AthletCustomEditState extends State<AthletCustomEdit> {


  TimeOfDay selectedTime = TimeOfDay(hour: 13, minute: 12);
  DateTime selectedDate = DateTime.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
          child: Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.c87B842,
                onPrimary: AppColors.cFFFFFF,
                surface: AppColors.c181818,
                onSurface: AppColors.cFFFFFF,
              ),
              dialogBackgroundColor: AppColors.c000000,
              timePickerTheme: TimePickerThemeData(
                backgroundColor: AppColors.c181818,
                hourMinuteTextStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.cFFFFFF,
                ),
                dayPeriodTextStyle: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.cFFFFFF,
                ),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.35,
              child: child!,
            ),
          ),
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  String _getShortDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    if (selected == today) return 'Today';
    if (selected == today.subtract(const Duration(days: 1))) return 'Yday';
    if (selected == today.add(const Duration(days: 1))) return 'Tmrw';
    return '${selectedDate.day}/${selectedDate.month}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.clockicon, height: 24.h,color: AppColors.orangeColor,),
          UIHelper.horizontalSpace(8.w),
          Text(
            '${_getShortDate()}, ${selectedTime.format(context)}',
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _selectTime(context),
            child: Text(
              'Edit',
              style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.orangeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}