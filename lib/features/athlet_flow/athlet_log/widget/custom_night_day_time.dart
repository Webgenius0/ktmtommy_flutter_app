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

  @override
  void initState() {
    super.initState();
    _updateBedTimeText();
    _updateWakeUpTimeText();
    _calculateSleepDuration();
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

  //========================================= Night =================================//

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
              //================ tetxt
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


//================================================== Day ==================================================//

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

  void _saveSleepData() {
    print('Sleep data saved!');
    print('Bedtime: $_bedTimeText');
    print('Wake up time: $_wakeUpTimeText');
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
        child:   Column(
          children: [

            CalanderToday(
              controller: dateController,
              hintText: 'Today 27 July, 25',
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
                        fontSize: 16.sp, fontWeight: FontWeight.w500
                    )
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
                          height: 24.h
                      ),
                      UIHelper.horizontalSpace(8.w),
                      Text(
                          _bedTimeText,
                          textAlign: TextAlign.center,
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                              fontSize: 18.sp, fontWeight: FontWeight.w600
                          )
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
                        fontSize: 16.sp, fontWeight: FontWeight.w500
                    )
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
                          height: 24.h
                      ),
                      UIHelper.horizontalSpace(8.w),
                      Text(
                          _wakeUpTimeText,
                          textAlign: TextAlign.center,
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                              fontSize: 18.sp, fontWeight: FontWeight.w600
                          )
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
                          style:  TextFontStyle.textStyle16w400c757575poppins
                      ),
                      UIHelper.verticalSpace(2.h),
                      Text(
                          _totalSleepTime,
                          textAlign: TextAlign.center,
                          style:  TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                              fontSize: 18.sp
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
            UIHelper.verticalSpace(24.h),


            InkWell(
              onTap: _saveSleepData,
              borderRadius: BorderRadius.circular(12.r),
              child: CustomButtonWidget(
                textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
                    fontWeight: FontWeight.w500
                ),
                image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                text: 'Save Sleep',
              ),
            ),
          ],
        ),


    );
  }
}