import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AddMedicineTakingScheduleScreen extends StatefulWidget {
  final bool isEdit;
  const AddMedicineTakingScheduleScreen({super.key, this.isEdit = false});

  @override
  State<AddMedicineTakingScheduleScreen> createState() => _AddMedicineTakingScheduleScreenState();
}

class _AddMedicineTakingScheduleScreenState extends State<AddMedicineTakingScheduleScreen> {
  List<TimeOfDay> takingTimes = [
    const TimeOfDay(hour: 8, minute: 0),
    const TimeOfDay(hour: 12, minute: 0),
  ];

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: takingTimes[index],
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xffA6FF00),
              onPrimary: Colors.black,
              surface: Color(0xff181818),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xff181818),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != takingTimes[index]) {
      setState(() {
        takingTimes[index] = picked;
      });
    }
  }

  void _addTime() {
    setState(() {
      takingTimes.add(const TimeOfDay(hour: 18, minute: 0));
    });
  }

  void _removeTime(int index) {
    if (takingTimes.length > 1) {
      setState(() {
        takingTimes.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(20.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => NavigationService.goBack(),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpace(16.w),
                  Text(
                    widget.isEdit ? 'Edit Medicine' : 'Add Medicine',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              
              // Progress bar
              Row(
                children: [
                  Expanded(child: Container(height: 4.h, color: const Color(0xffA6FF00))),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(child: Container(height: 4.h, color: const Color(0xffA6FF00))),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(child: Container(height: 4.h, color: Colors.white24)),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(child: Container(height: 4.h, color: Colors.white24)),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              
              Text(
                'Taking Schedule',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              UIHelper.verticalSpace(4.h),
              Text(
                'When do you take this medicine?',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
              ),
              UIHelper.verticalSpace(24.h),
              
              Text(
                'Taking Times',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              
              Expanded(
                child: ListView.builder(
                  itemCount: takingTimes.length,
                  itemBuilder: (context, index) {
                    final time = takingTimes[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectTime(context, index),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: AppColors.c181818,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      time.format(context),
                                      style: TextFontStyle.textStyle14w500c242424.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(Icons.access_time, color: const Color(0xffA6FF00), size: 20.sp),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          UIHelper.horizontalSpace(12.w),
                          GestureDetector(
                            onTap: () => _removeTime(index),
                            child: Icon(Icons.delete_outline, color: Colors.red, size: 24.sp),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              GestureDetector(
                onTap: _addTime,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: const Color(0xffA6FF00)),
                  ),
                  child: Center(
                    child: Text(
                      '+ Add Another Time',
                      style: TextFontStyle.textStyle14w500c242424.copyWith(
                        color: const Color(0xffA6FF00),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(16.h),
              
              CustomButtonWidget(
                text: 'Next',
                onTap: () {
                  NavigationService.navigateToWithArgs(
                    Routes.addMedicineDurationScreen,
                    {'isEdit': widget.isEdit},
                  );
                },
              ),
              UIHelper.verticalSpace(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
