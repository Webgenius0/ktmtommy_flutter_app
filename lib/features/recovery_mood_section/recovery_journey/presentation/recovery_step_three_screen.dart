import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/custom_stepbar.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/recovery_goal.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/short_time.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/slider_custom.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/weeks_dropdwon.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:intl/intl.dart';

class RecoveryStepThreeScreen extends StatefulWidget {
  const RecoveryStepThreeScreen({super.key});

  @override
  State<RecoveryStepThreeScreen> createState() => _RecoveryStepThreeScreenState();
}

class _RecoveryStepThreeScreenState extends State<RecoveryStepThreeScreen> {
  bool _isLoading = false;
  double sliderValue = 0.5;
  String selectedRecoveryGoal = 'Return to work';
  String selectedDuration = '4 Weeks';
  List<String> durationList = ['4 Weeks', '1 Week', '3 Weeks', '5 Weeks']; // Fixed typo: '1 Weeks' to '1 Week'
  String selectedTimePeriod = 'short';
  String progressLabel = 'middle';

  // Map time period to Postman format
  String getFormattedTimePeriod(String timePeriod) {
    switch (timePeriod) {
      case 'short':
        return 'Short Term';
      case 'medium':
        return 'Medium Term';
      case 'long':
        return 'Long Term';
      default:
        return 'Short Term';
    }
  }

  // Map selectedDuration to API format (e.g., "4 Weeks" -> "4_week")
  String getFormattedDuration(String duration) {
    switch (duration) {
      case '1 Week':
        return '1_week';
      case '3 Weeks':
        return '3_week';
      case '4 Weeks':
        return '4_week';
      case '5 Weeks':
        return '5_week';
      default:
        return '4_week';
    }
  }

  // Time formatting function
  String formatTime(String? time) {
    try {
      final DateFormat inputFormat = DateFormat('H:m');
      final DateFormat outputFormat = DateFormat('HH:mm:ss');
      final DateTime parsedTime = inputFormat.parse(time ?? '08:00');
      return outputFormat.format(parsedTime);
    } catch (e) {
      log('Time format error: $e');
      return time == 'reminder_from' ? '08:00:00' : '20:00:00';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbarWidget(
                onTap: () {
                  NavigationService.goBack();
                },
                text: 'Your Recovery Journey',
              ),
              UIHelper.verticalSpace(24.h),

              CustomStepBar(
                currentStep: 2,
                onTap: () {
                  NavigationService.navigateTo(Routes.recoveryStepTwoScreen);
                },
                onStepTap: (int index) {},
              ),
              UIHelper.verticalSpace(24.h),

              /// ===================== Goal Time Selection =====================
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: AppColors.c181818,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Set Recovery Goal Time',
                        style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),

                      /// Time Period Selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ShortTime(
                              text: 'Short\nTime',
                              isSelected: selectedTimePeriod == 'short',
                              onTap: () {
                                setState(() {
                                  selectedTimePeriod = 'short';
                                });
                              },
                            ),
                          ),
                          UIHelper.horizontalSpace(16.w),
                          Expanded(
                            child: ShortTime(
                              text: 'Medium\nTerm',
                              isSelected: selectedTimePeriod == 'medium',
                              onTap: () {
                                setState(() {
                                  selectedTimePeriod = 'medium';
                                });
                              },
                            ),
                          ),
                          UIHelper.horizontalSpace(16.w),
                          Expanded(
                            child: ShortTime(
                              text: 'Long\nTerm',
                              isSelected: selectedTimePeriod == 'long',
                              onTap: () {
                                setState(() {
                                  selectedTimePeriod = 'long';
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      UIHelper.verticalSpace(16.h),
                      Text(
                        'Set Recovery Goal',
                        style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),

                      /// Recovery Goal Options
                      Row(
                        children: [
                          RecoveryGoal(
                            title: 'Return to work',
                            isSelected: selectedRecoveryGoal == 'Return to work',
                            onTap: () {
                              setState(() {
                                selectedRecoveryGoal = 'Return to work';
                              });
                            },
                          ),
                          RecoveryGoal(
                            title: 'Physical Activity',
                            isSelected: selectedRecoveryGoal == 'Physical Activity',
                            onTap: () {
                              setState(() {
                                selectedRecoveryGoal = 'Physical Activity';
                              });
                            },
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(12.h),
                      Row(
                        children: [
                          RecoveryGoal(
                            title: 'Social Life',
                            isSelected: selectedRecoveryGoal == 'Social Life',
                            onTap: () {
                              setState(() {
                                selectedRecoveryGoal = 'Social Life';
                              });
                            },
                          ),
                          RecoveryGoal(
                            title: 'Mental Wellbeing',
                            isSelected: selectedRecoveryGoal == 'Mental Wellbeing',
                            onTap: () {
                              setState(() {
                                selectedRecoveryGoal = 'Mental Wellbeing';
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(24.h),

              /// ===================== Progress Timeline =====================
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: AppColors.c181818,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress Timeline',
                        style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                      UIHelper.verticalSpace(12.h),
                      ProgressTimeline(
                        sliderValue: sliderValue,
                        onChanged: (value) {
                          setState(() {
                            sliderValue = value;
                            if (value < 0.33) {
                              progressLabel = 'start';
                            } else if (value < 0.66) {
                              progressLabel = 'middle';
                            } else {
                              progressLabel = 'end';
                            }
                          });
                        },
                        labels: const ['start', 'middle', 'end'],
                      ),
                      UIHelper.verticalSpace(16.h),
                      Text(
                        'Target Date',
                        style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                      UIHelper.verticalSpace(12.h),
                      WeeksDropdwon(
                        items: durationList,
                        initialValue: selectedDuration,
                        onChanged: (value) {
                          setState(() {
                            selectedDuration = value!;
                          });
                        },
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        iconPath: AppIcons.bottomdrodwonicon,
                        iconHeight: 18,
                      ),
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(32.h),

              /// ===================== Next Button =====================
              CustomButtonWidget(
                onTap: _isLoading
                    ? null
                    : () async {
                  setState(() {
                    _isLoading = true;
                  });

                  // Log all selected values
                  appData.write(kKRecoveryTimePeriod, selectedTimePeriod);
                  appData.write(kKRecoveryGoal, selectedRecoveryGoal);
                  appData.write(ProgressTimelines, progressLabel);
                  appData.write(TargetDuration, selectedDuration);

                  // Read data
                  final userName = appData.read(kKeyuserFullName);
                  final userEmail = appData.read(kKeyuserEmail) ;
                  final userPassword = appData.read(kKeyuserPassword) ;
                  final userAge = appData.read(kKeyuserAge)?.toString() ; // Convert to String
                  final userGender = appData.read(kKeyuserGender);
                  final reminderFrom = formatTime(appData.read(kKeyuserReminderStartTime));
                  final reminderTo = formatTime(appData.read(kKeyuserReminderEndTime) );
                  final injuryName = appData.read(kKeyInjuryName) ;
                  final injuryLevel = appData.read(kKeyInjuryLevel) ;
                  final injuryDate = appData.read(kKeyInjuryDate) ;
                  final recoveryStage = appData.read(kKeyRecoveryStage);
                  final physicalSymptom = appData.read(kKeyPhysicalSymptom);
                  final symptomLevelRaw = appData.read(kKeySymptomLevel) ;
                  final symptomLevel = symptomLevelRaw is double ? symptomLevelRaw.toString() : symptomLevelRaw.toString();
                  final frequency = appData.read(kKeyFrequency) ;
                  final duration = appData.read(kKeyDuration) ;
                  final emotionalSymptom = appData.read(kKeyEmotionalSymptom) ;

                  // Print all data to console
                  log('==============================');
                  log('=======👤 USER INFO:===========');
                  log('name: $userName');
                  log('email: $userEmail');
                  log('password: $userPassword');
                  log('------------------------------');
                  log('=====📅 TELL US ABOUT INFO:======');
                  log('age: $userAge');
                  log('gender: $userGender');
                  log('reminder_from: $reminderFrom');
                  log('reminder_to: $reminderTo');
                  log('------------------------------');
                  log('=======💪 RECOVERY STEP ONE:============');
                  log('injury_name: $injuryName');
                  log('injury_level: $injuryLevel');
                  log('injury_date: $injuryDate');
                  log('current_recovery_stage: $recoveryStage');
                  log('------------------------------');
                  log('======⚕️ RECOVERY STEP TWO:=============');
                  log('physical_symptom: $physicalSymptom');
                  log('physical_symptom_details: $symptomLevel');
                  log('physical_symptom_frequency: $frequency');
                  log('physical_symptom_duration: $duration');
                  log('emotional_symptoms: $emotionalSymptom');
                  log('------------------------------');
                  log('🕐 FINAL RECOVERY DATA:');
                  log('🕐 Set Recovery Goal Time: ${getFormattedTimePeriod(selectedTimePeriod)}');
                  log('🎯 Recovery Goal: $selectedRecoveryGoal');
                  log('📈 Progress Timeline: $progressLabel');
                  log('📅 recovery_target_date: ${getFormattedDuration(selectedDuration)}');
                  log('==============================');

                  try {
                    bool success = await recoveryRegistrationApiRxObj.registerRecoveryUserApi(
                      name: userName,
                      email: userEmail,
                      password: userPassword,
                      password_confirmation: userPassword,
                      terms_accepted: true,
                      age: appData.read(kKeyuserAge),// String
                      gender: appData.read(kKeyuserGender),
                      reminder_from: reminderFrom,
                      reminder_to: reminderTo,
                      user_mode: 'recovery',
                      injury_name: injuryName,
                      injury_level: injuryLevel,
                      injury_date: injuryDate,
                      current_recovery_stage: recoveryStage,
                      physical_symptom: physicalSymptom,
                      physical_symptom_details: symptomLevel, // String
                      physical_symptom_duration_hour: duration,
                      physical_symptom_frequency: frequency,
                      emotional_symptoms: emotionalSymptom,
                      recovery_goal: selectedRecoveryGoal,
                      recovery_goal_time: getFormattedTimePeriod(selectedTimePeriod),
                      progress_timeline: progressLabel,
                      recovery_target_date: getFormattedDuration(selectedDuration),
                    );

                    if (success) {
                      NavigationService.navigateTo(Routes.allSetScreen);
                    } else {
                      log("================Failed. Try again.");
                    }
                  } catch (e) {
                    log("====================API Error: $e");
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
                text: '',
                child: _isLoading
                    ? SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

