import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/log_activity_calander.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/custom_time_clock.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/hydro_therapy.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/notification_dropdwon.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import '../widget/duration_time.dart';

class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({super.key});

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController dateController;
  final TextEditingController notesController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay _selectedTimeOfDay = TimeOfDay.now();
  String _selectedDurationStr = '30 minutes';
  String _selectedNotificationStr = '10 minutes before';
  String _selectedRepeatStr = 'Once';

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    nameController.dispose();
    notesController.dispose();
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
                  onTap: () {
                    NavigationService.goBack;
                  },
                  text: 'Add session',
                ),
                UIHelper.verticalSpace(12.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 18.h),
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Session type',
                                style:
                                    TextFontStyle.textStyle14w400cA3A3A3poppins,
                              ),
                              UIHelper.verticalSpace(4.h),
                              // CustomTextfield(
                              //   isRead: true,
                              //   suffixIcon: PopupMenuButton<String>(
                              //     color: AppColors.c2A2A2A,
                              //     offset: const Offset(0, 40),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(12.r),
                              //     ),
                              //     icon: SvgPicture.asset(
                              //       AppIcons.bottomdrodwonicon,
                              //       height: 18.h,
                              //     ),
                              //     onSelected: (value) {
                              //       nameController.text = value;
                              //     },
                              //     itemBuilder: (context) => [
                              //       const PopupMenuItem(
                              //         value: '🏃 Physio Therapy',
                              //         child: Text(
                              //           '🏃 Physio Therapy',
                              //           style: TextStyle(color: Colors.white),
                              //         ),
                              //       ),
                              //       const PopupMenuItem(
                              //         value: '💧 Hydro Therapy',
                              //         child: Text(
                              //           '💧 Hydro Therapy',
                              //           style: TextStyle(color: Colors.white),
                              //         ),
                              //       ),
                              //       const PopupMenuItem(
                              //         value: '🗣 Speech Therapy',
                              //         child: Text(
                              //           '🗣 Speech Therapy',
                              //           style: TextStyle(color: Colors.white),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              //   idoNotErrorBorder: true,
                              //   controller: nameController,
                              //   textAlign: TextAlign.start,
                              //   hintText: 'Select session type',
                              //   hintTextSyle:
                              //       TextFontStyle.textStyle14w400cA3A3A3poppins,
                              //   fillColor: AppColors.c2A2A2A,
                              //   borderRadius: 20.r,
                              //   borderColor: Colors.transparent,
                              //   contentPadding:
                              //       EdgeInsets.symmetric(horizontal: 12.w),
                              //   style: const TextStyle(color: Colors.white),
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Enter activity type';
                              //     }
                              //     return null;
                              //   },
                              // ),

                              CustomTextfield(
                                controller: nameController,
                                textAlign: TextAlign.start,
                                borderRadius: 20.r,
                                fillColor: AppColors.c2A2A2A,
                                hintText: 'Add session here',
                                hintTextSyle:
                                TextFontStyle.textStyle14w400cA3A3A3poppins,
                                style:
                                const TextStyle(color: AppColors.cFFFFFF),
                              ),
                              UIHelper.verticalSpace(18.h),
                              Text(
                                'Date',
                                style:
                                    TextFontStyle.textStyle14w400cA3A3A3poppins,
                              ),
                              UIHelper.verticalSpace(4.h),
                              LogActivityCalander(
                                controller: dateController,
                                hintText: 'Select Date',
                                onDateSelected: (date) {
                                  setState(() {
                                    _selectedDate = date;
                                  });
                                },
                              ),
                              UIHelper.verticalSpace(18.h),
                              Text(
                                'Time',
                                style:
                                    TextFontStyle.textStyle14w400cA3A3A3poppins,
                              ),
                              UIHelper.verticalSpace(4.h),
                              CustomTimeClock(
                                onTimeSelected: (time) {
                                  setState(() {
                                    _selectedTimeOfDay = time;
                                  });
                                },
                              ),
                              UIHelper.verticalSpace(18.h),
                              Text(
                                'Duration',
                                style:
                                    TextFontStyle.textStyle14w400cA3A3A3poppins,
                              ),
                              UIHelper.verticalSpace(4.h),
                              DurationTime(
                                onDurationSelected: (val) {
                                  setState(() {
                                    _selectedDurationStr = val;
                                  });
                                },
                              ),
                              UIHelper.verticalSpace(18.h),
                              Text(
                                'Notification',
                                style:
                                    TextFontStyle.textStyle14w400cA3A3A3poppins,
                              ),
                              UIHelper.verticalSpace(4.h),
                              NotificationDropdwon(
                                onNotificationSelected: (val) {
                                  setState(() {
                                    _selectedNotificationStr = val;
                                  });
                                },
                              ),
                              UIHelper.verticalSpace(18.h),
                              Text(
                                'Repeat',
                                style:
                                    TextFontStyle.textStyle14w400cA3A3A3poppins,
                              ),
                              UIHelper.verticalSpace(4.h),
                              HydroTherapy(
                                onRepeatSelected: (val) {
                                  setState(() {
                                    _selectedRepeatStr = val;
                                  });
                                },
                              ),
                              UIHelper.verticalSpace(18.h),
                              Text(
                                'Notes',
                                style:
                                    TextFontStyle.textStyle14w400cA3A3A3poppins,
                              ),
                              UIHelper.verticalSpace(4.h),
                              CustomTextfield(
                                controller: notesController,
                                textAlign: TextAlign.start,
                                maxline: 4,
                                borderRadius: 20.r,
                                fillColor: AppColors.c2A2A2A,
                                hintText: 'Add notes here',
                                hintTextSyle:
                                    TextFontStyle.textStyle14w400cA3A3A3poppins,
                                style:
                                    const TextStyle(color: AppColors.cFFFFFF),
                              ),
                              UIHelper.verticalSpace(18.h),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(18.h),
                        CustomButtonWidget(
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (_selectedDate == null) {
                                EasyLoading.showError('Please select a date');
                                return;
                              }

                              EasyLoading.show(status: 'Saving session...');

                              final String dateStr = DateFormat('yyyy-MM-dd')
                                  .format(_selectedDate!);
                              final String timeStr =
                                  "${_selectedTimeOfDay.hour.toString().padLeft(2, '0')}:${_selectedTimeOfDay.minute.toString().padLeft(2, '0')}";

                              final int durationVal = int.tryParse(
                                      _selectedDurationStr.split(' ')[0]) ??
                                  30;
                              final int notificationVal = int.tryParse(
                                      _selectedNotificationStr.split(' ')[0]) ??
                                  10;

                              String repeatType = "Once";
                              List<String> customDays = [];

                              if (_selectedRepeatStr == "Once") {
                                repeatType = "Once";
                              } else if (_selectedRepeatStr ==
                                  "DailyEveryday") {
                                repeatType = "DailyEveryday";
                              } else if (_selectedRepeatStr.trim() ==
                                  "Fortnightly") {
                                repeatType = "Fortnightly";
                              } else {
                                repeatType = "Custom";
                                customDays = _selectedRepeatStr
                                    .split(', ')
                                    .map((e) => e.trim())
                                    .where((e) => e.isNotEmpty)
                                    .toList();
                              }

                              final Map<String, dynamic> body = {
                                "session_name": nameController.text,
                                "date": dateStr,
                                "time": timeStr,
                                "duration": durationVal,
                                "notification_before": notificationVal,
                                "repeat": repeatType,
                                "custom_days": customDays,
                                "notes": notesController.text,
                              };

                              scheduleRxObj.storeSchedule(body).then((_) {
                                EasyLoading.showSuccess(
                                    'Session added successfully! 🎉');

                                // Auto refresh the calendar feedback!
                                final now = DateTime.now();
                                final fromDate =
                                    now.subtract(const Duration(days: 15));
                                final toDate =
                                    now.add(const Duration(days: 15));
                                final fromStr =
                                    DateFormat('yyyy-MM-dd').format(fromDate);
                                final toStr =
                                    DateFormat('yyyy-MM-dd').format(toDate);
                                scheduleFeedbackRxObj.getScheduleFeedback(
                                    fromStr, toStr);

                                Navigator.of(context).pop();
                              }).catchError((err) {
                                EasyLoading.showError('Failed to save session');
                              });
                            }
                          },
                          text: 'Add Session',
                        ),
                        UIHelper.verticalSpace(24.h),
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
