
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomEditPicWidget extends StatefulWidget {
  const CustomEditPicWidget({super.key});

  @override
  State<CustomEditPicWidget> createState() => _CustomEditPicWidgetState();
}

class _CustomEditPicWidgetState extends State<CustomEditPicWidget> {


  TimeOfDay selectedTime = TimeOfDay(hour: 13, minute: 12);
  DateTime selectedDate = DateTime.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
          child:

          Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.orangeColor,
                onPrimary: AppColors.cFFFFFF,
                surface: AppColors.c181818,
                onSurface: AppColors.cFFFFFF,
                background: AppColors.c181818,
              ),
              dialogBackgroundColor: AppColors.c000000,
              timePickerTheme: TimePickerThemeData(
                backgroundColor: AppColors.c181818,
                hourMinuteTextStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.cFFFFFF,
                  fontWeight: FontWeight.w500,
                ),
                dayPeriodTextStyle: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.cFFFFFF,
                  fontWeight: FontWeight.w500,
                ),
                dayPeriodColor: AppColors.c2A2A2A,
                dayPeriodShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                dayPeriodBorderSide: BorderSide(color: AppColors.orangeColor, width: 1.w),
                dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.orangeColor;
                  }
                  return AppColors.cFFFFFF;
                }),
                      hourMinuteColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.orangeColor;
                  }
                  return AppColors.c2A2A2A;
                }),
                hourMinuteTextColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.cFFFFFF;
                  }
                  return AppColors.cFFFFFF;
                }),

                dialBackgroundColor: AppColors.c2A2A2A,
                dialHandColor: AppColors.orangeColor,
                dialTextColor: AppColors.cFFFFFF,
                entryModeIconColor: AppColors.orangeColor,
                helpTextStyle: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.cFFFFFF,
                  fontWeight: FontWeight.w500,
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
              style: TextFontStyle.textStyle24w600cF55216poppins.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,

              ),
            ),
          ),
        ],
      ),
    );
  }
}