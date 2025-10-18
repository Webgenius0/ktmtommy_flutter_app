
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';




class CustomTimeClock extends StatefulWidget {
  const CustomTimeClock({super.key});

  @override
  State<CustomTimeClock> createState() => _CustomTimeClockState();
}

class _CustomTimeClockState extends State<CustomTimeClock> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    final now = TimeOfDay.now();
    selectedTime = now;
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Center(
          child: SizedBox(
            width: 400,
            height: 420,
            child: Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: Colors.black,
                colorScheme: ColorScheme.dark(
                  primary: AppColors.c87B842,
                  onSurface: Colors.white,
                ),
                timePickerTheme: TimePickerThemeData(
                  dayPeriodTextColor: Colors.white,
                  dayPeriodShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  dayPeriodColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return AppColors.c87B842;
                    }
                    return const Color(0xFF3A3A3A);
                  }),
                ),
              ),
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

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: ShapeDecoration(
        color: AppColors.c2A2A2A,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //========================== Show selected time ================================//
          Text(
            _formatTime(selectedTime),
            maxLines: 1,
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          //======================================= Clock ==============================//
          InkWell(
            onTap: _pickTime,
            child: SvgPicture.asset(
              AppIcons.clockicon,
              height: 24.h,
            ),
          ),
        ],
      ),
    );
  }
}
