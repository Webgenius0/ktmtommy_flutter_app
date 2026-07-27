import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; //
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/custom_notification.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/log_activity_calander.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/minute_custom.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/time_custom.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class LogActivityScreen extends StatefulWidget {
  const LogActivityScreen({super.key});

  @override
  State<LogActivityScreen> createState() => _LogActivityScreenState();
}

class _LogActivityScreenState extends State<LogActivityScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? _selectedDateTime;
  bool _isLoading = false;

  String _selectedTime = '18:30:00';
  String _selectedDuration = '30';
  int _selectedNotification = 10;

  @override
  void dispose() {
    nameController.dispose();
    notesController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomAppbarWidget(
                  onTap: () => NavigationService.goBack,
                  text: 'Log Activity',
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Activity Type',
                                  style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                              UIHelper.verticalSpace(4.h),
                              CustomTextfield(
                                idoNotErrorBorder: true,
                                controller: nameController,
                                textAlign: TextAlign.start,
                                hintText: 'Enter activity name',
                                hintTextSyle: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                fillColor: AppColors.c2A2A2A,
                                borderRadius: 20.r,
                                borderColor: Colors.transparent,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                                style: const TextStyle(color: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter activity type';
                                  }
                                  return null;
                                },
                              ),
                              UIHelper.verticalSpace(18.h),

                              Text('Date', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                              UIHelper.verticalSpace(4.h),
                              LogActivityCalander(
                                controller: dateController,
                                hintText: 'Select Date',
                                onDateSelected: (DateTime selectedDate) {
                                  setState(() {
                                    _selectedDateTime = selectedDate;

                                    dateController.text = DateFormat('dd MMM yyyy').format(selectedDate);
                                  });
                                },
                              ),
                              UIHelper.verticalSpace(18.h),

                              Text('Time', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                              UIHelper.verticalSpace(4.h),
                              LogActivityTimePicker(
                                controller: timeController,
                                hintText: 'Select time',
                                onTimeSelected: (DateTime selectedTime) {
                                  setState(() {
                                    _selectedDateTime = selectedTime; // This combines date and time
                                    _selectedTime = DateFormat('HH:mm:ss').format(selectedTime);
                                  });
                                },
                              ),
                              UIHelper.verticalSpace(18.h),

                              Text('Time', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                              UIHelper.verticalSpace(4.h),
                              TimeCustom(
                                initialTime: '18:30:00',
                                onTimeSelected: (selectedTime) {
                                  _selectedTime = selectedTime;
                                },
                              ),
                              UIHelper.verticalSpace(18.h),

                              Text('Duration', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                              UIHelper.verticalSpace(4.h),
                              MinuteCustom(
                                initialMinute: "30",
                                onMinuteSelected: (minute) {
                                  _selectedDuration = minute;
                                },
                              ),
                              UIHelper.verticalSpace(18.h),

                              Text('Notification', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                              UIHelper.verticalSpace(4.h),
                              CustomNotification(
                                initialMinutes: 30,
                                onMinutesSelected: (minutes) {
                                  _selectedNotification = minutes;
                                },
                              ),
                              UIHelper.verticalSpace(18.h),

                              Text('Notes', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                              UIHelper.verticalSpace(4.h),
                              CustomTextfield(
                                controller: notesController,
                                textAlign: TextAlign.start,
                                maxline: 4,
                                borderRadius: 20.r,
                                fillColor: AppColors.c2A2A2A,
                                hintText: 'Add notes here',
                                hintTextSyle: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                style: const TextStyle(color: AppColors.cFFFFFF),
                              ),
                              UIHelper.verticalSpace(18.h),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(24.h),

                        _isLoading
                            ? const CircularProgressIndicator(color: AppColors.c87B842)
                            : CustomButtonWidget(
                          onTap: () async {

                            if (!_formKey.currentState!.validate()) return;


                            if (_selectedDateTime == null) {

                              return;
                            }

                            setState(() => _isLoading = true);

                            try {
                              String apiDate = DateFormat('yyyy-MM-dd').format(_selectedDateTime!);

                              await logActivityRxObj.storeActivityPostApi(
                                name: nameController.text.trim(),
                                date: apiDate,
                                time: _selectedTime,
                                duration_minutes: int.parse(_selectedDuration),
                                notify_before_minutes: _selectedNotification,
                                notes: notesController.text.trim(),
                              );

                              if (mounted) {
                                log("==========>>>>>Add Activity Button Clicked go to recentScreen");
                                NavigationService.navigateTo(Routes.recentScreen);
                              }
                            } catch (e) {
                              debugPrint("===========>>>>Activity log failed: $e");
                            } finally {
                              if (mounted) {
                                setState(() => _isLoading = false);
                              }
                            }
                          },
                          text: 'Add Activity',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}