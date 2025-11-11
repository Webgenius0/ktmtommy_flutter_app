import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_lottie.dart';
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
import 'package:lottie/lottie.dart';

class RecoveryStepThreeScreen extends StatefulWidget {
  const RecoveryStepThreeScreen({super.key});

  @override
  State<RecoveryStepThreeScreen> createState() =>
      _RecoveryStepThreeScreenState();
}

class _RecoveryStepThreeScreenState extends State<RecoveryStepThreeScreen> {
  bool _isLoading = false;
  double sliderValue = 0.5;
  String selectedRecoveryGoal = 'Return to Work';
  String selectedDuration = '4 Weeks';
  List<String> durationList = ['4 Weeks', '1 Weeks', '3 Weeks', '5 Weeks'];
  String selectedTimePeriod = 'short';
  String progressLabel = 'Middle';



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
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Set Recovery Goal Time',
                        style: TextFontStyle.textStyle14w400cA3A3A3poppins
                            .copyWith(
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
                        style: TextFontStyle.textStyle14w400cA3A3A3poppins
                            .copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),

                      /// Recovery Goal Options
                      Row(
                        children: [
                          RecoveryGoal(
                            title: 'Return to Work',
                            isSelected:
                                selectedRecoveryGoal == 'Return to Work',
                            onTap: () {
                              setState(() {
                                selectedRecoveryGoal = 'Return to Work';
                              });
                            },
                          ),
                          RecoveryGoal(
                            title: 'Physical Activity',
                            isSelected:
                                selectedRecoveryGoal == 'Physical Activity',
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
                            isSelected:
                                selectedRecoveryGoal == 'Mental Wellbeing',
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress Timeline',
                        style: TextFontStyle.textStyle14w400cA3A3A3poppins
                            .copyWith(
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
                              progressLabel = 'Start';
                            } else if (value < 0.66) {
                              progressLabel = 'Middle';
                            } else {
                              progressLabel = 'End';
                            }
                          });
                        },
                        labels: const ['Start', 'Middle', 'End'],
                      ),
                      UIHelper.verticalSpace(16.h),
                      Text(
                        'Target Date',
                        style: TextFontStyle.textStyle14w400cA3A3A3poppins
                            .copyWith(
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

                   // ✅ Log all selected values
                      appData.write(kKRecoveryTimePeriod, selectedTimePeriod);
                      appData.write(kKRecoveryGoal, selectedRecoveryGoal);
                      appData.write(ProgressTimelines, sliderValue);
                      appData.write(TargetDuration, selectedDuration);


                      //===========sign_up_screen_data================//

                      appData.read(kKeyuserFullName);
                      appData.read(kKeyuserEmail);
                      appData.read(kKeyuserPassword);


                      //==============tell_us_about_screen_data==================//

                      appData.read(kKeyuserAge);
                      appData.read(kKeyuserGender);
                      appData.read(kKeyuserReminderStartTime);
                      appData.read(kKeyuserReminderEndTime);

                      //===================recovery_step_one_screen=============//

                      appData.read(kKeyInjuryName);
                      appData.read(kKeyInjuryLevel);
                      appData.read(kKeyInjuryDate);
                      appData.read(kKeyRecoveryStage);

                      //===================recoveryStepTwoScreen=================//
                      appData.read(kKeyPhysicalSymptom);
                      appData.read(kKeySymptomLevel);
                      appData.read(kKeyFrequency);
                      appData.read(kKeyDuration);
                      appData.read(kKeyEmotionalSymptom);

                     // ✅ Print all data to console


                      log('==============================');
                      log('=======👤 USER INFO:===========');
                      log('name: ${appData.read(kKeyuserFullName)}');
                      log('email: ${appData.read(kKeyuserEmail)}');
                      log('password: ${appData.read(kKeyuserPassword)}');


                      log('------------------------------');
                      log('=====📅 TELL US ABOUT INFO:======');
                      log('age: ${appData.read(kKeyuserAge)}');
                      log('gender: ${appData.read(kKeyuserGender)}');
                      log('reminder_from: ${appData.read(kKeyuserReminderStartTime)}');
                      log('reminder_to: ${appData.read(kKeyuserReminderEndTime)}');


                      log('------------------------------');
                      log('=======💪 RECOVERY STEP ONE:============');
                      log('injury_name: ${appData.read(kKeyInjuryName)}');
                      log('injury_level: ${appData.read(kKeyInjuryLevel)}');
                      log('injury_date: ${appData.read(kKeyInjuryDate)}');
                      log('current_recovery_stage: ${appData.read(kKeyRecoveryStage)}');

                      log('------------------------------');
                      log('======⚕️ RECOVERY STEP TWO:=============');
                      log('physical_symptom: ${appData.read(kKeyPhysicalSymptom)}');
                      log('physical_symptom_details: ${appData.read(kKeySymptomLevel)}');
                      log('physical_symptom_frequency: ${appData.read(kKeyFrequency)}');
                      log('physical_symptom_duration: ${appData.read(kKeyDuration)}');
                      log('emotional_symptoms: ${appData.read(kKeyEmotionalSymptom)}');


                      log('------------------------------');
                      log('🕐 FINAL RECOVERY DATA:');
                      log('🕐Recovery Time Period: $selectedTimePeriod');
                      log('🎯Recovery Goal: $selectedRecoveryGoal');
                      log('📈Progress Timeline: ${sliderValue.toStringAsFixed(2)}');
                      log('📅Target Duration: $selectedDuration');
                      log('==============================');


                  try {
                          bool success = await recoveryRegistrationApiRxObj.registerRecoveryUserApi(
                            name: kKeyuserFullName,
                            email: kKeyuserEmail,
                            phone: "1234567890",
                            password: kKeyuserPassword,
                            password_confirmation: kKeyuserPassword,
                            age: kKeyuserAge,
                            gender: kKeyuserGender,
                            user_mode: "recovery",
                            terms_accepted: true,
                            injury_name: kKeyInjuryName,
                            injury_level: kKeyInjuryLevel,
                            injury_date: kKeyInjuryDate,
                            current_recovery_stage: kKeyRecoveryStage,
                            physical_symptom: kKeyPhysicalSymptom,
                            physical_symptom_details: kKeySymptomLevel,
                            physical_symptom_duration: kKeyDuration,
                            physical_symptom_frequency: kKeyFrequency,
                            emotional_symptoms: kKeyEmotionalSymptom,
                            recovery_goal: selectedRecoveryGoal,
                            recovery_goal_time: selectedDuration,
                            progress_timeline: progressLabel,
                            recovery_target_date: "2025-11-24",
                            reminder_from: kKeyuserReminderStartTime,
                            reminder_to: kKeyuserReminderEndTime,
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


// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
// import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
// import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
// import 'package:ktmtommy_apps/constants/app_constants.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/custom_stepbar.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/recovery_goal.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/short_time.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/slider_custom.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/weeks_dropdwon.dart';
// import 'package:ktmtommy_apps/helpers/all_routes.dart';
// import 'package:ktmtommy_apps/helpers/di.dart';
// import 'package:ktmtommy_apps/helpers/navigation_service.dart';
// import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
// import 'package:ktmtommy_apps/networks/api_acess.dart';
//
// class RecoveryStepThreeScreen extends StatefulWidget {
//   const RecoveryStepThreeScreen({super.key});
//
//   @override
//   State<RecoveryStepThreeScreen> createState() =>
//       _RecoveryStepThreeScreenState();
// }
//
// class _RecoveryStepThreeScreenState extends State<RecoveryStepThreeScreen> {
//   double sliderValue = 0.5;
//   String selectedRecoveryGoal = 'Return to Work';
//   String selectedDuration = '4 Weeks';
//   List<String> durationList = ['4 Weeks', '1 Weeks', '3 Weeks', '5 Weeks'];
//   String selectedTimePeriod = 'short';
//   String progressLabel = 'Middle';
//   bool isLoading = false;
//
//   // Symptom string to ID mapping
//   static const Map<String, int> symptomToId = {
//     'Dizziness': 1,
//     'Pain': 2,
//     'Fatigue': 3,
//     'Nausea': 4,
//     // Add more symptoms as per your app's requirements
//   };
//
//   // Helper function to safely parse integers
//   int parseInt(String? value, {int fallback = 0}) {
//     try {
//       return int.parse(value ?? '$fallback');
//     } catch (e) {
//       log("Error parsing value: $value, Error: $e");
//       return fallback;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bacroundColorBlack,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 24.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomAppbarWidget(
//                 onTap: () {
//                   NavigationService.goBack();
//                 },
//                 text: 'Your Recovery Journey',
//               ),
//               UIHelper.verticalSpace(24.h),
//               CustomStepBar(
//                 currentStep: 2,
//                 onTap: () {
//                   NavigationService.navigateTo(Routes.recoveryStepTwoScreen);
//                 },
//                 onStepTap: (int index) {},
//               ),
//               UIHelper.verticalSpace(24.h),
//
//               // ===================== Goal Time Selection =====================
//               Container(
//                 width: double.infinity,
//                 decoration: ShapeDecoration(
//                   color: AppColors.c181818,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                 ),
//                 child: Padding(
//                   padding:
//                   EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Set Recovery Goal Time',
//                         style: TextFontStyle.textStyle14w400cA3A3A3poppins
//                             .copyWith(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 18.sp,
//                         ),
//                       ),
//                       UIHelper.verticalSpace(16.h),
//
//                       // Time Period Buttons
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: ShortTime(
//                               text: 'Short\nTime',
//                               isSelected: selectedTimePeriod == 'short',
//                               onTap: () => setState(() {
//                                 selectedTimePeriod = 'short';
//                               }),
//                             ),
//                           ),
//                           UIHelper.horizontalSpace(16.w),
//                           Expanded(
//                             child: ShortTime(
//                               text: 'Medium\nTerm',
//                               isSelected: selectedTimePeriod == 'medium',
//                               onTap: () => setState(() {
//                                 selectedTimePeriod = 'medium';
//                               }),
//                             ),
//                           ),
//                           UIHelper.horizontalSpace(16.w),
//                           Expanded(
//                             child: ShortTime(
//                               text: 'Long\nTerm',
//                               isSelected: selectedTimePeriod == 'long',
//                               onTap: () => setState(() {
//                                 selectedTimePeriod = 'long';
//                               }),
//                             ),
//                           ),
//                         ],
//                       ),
//                       UIHelper.verticalSpace(16.h),
//
//                       Text(
//                         'Set Recovery Goal',
//                         style: TextFontStyle.textStyle14w400cA3A3A3poppins
//                             .copyWith(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 18.sp,
//                         ),
//                       ),
//                       UIHelper.verticalSpace(16.h),
//
//                       // Recovery Goals
//                       Row(
//                         children: [
//                           RecoveryGoal(
//                             title: 'Return to Work',
//                             isSelected:
//                             selectedRecoveryGoal == 'Return to Work',
//                             onTap: () =>
//                                 setState(() => selectedRecoveryGoal = 'Return to Work'),
//                           ),
//                           RecoveryGoal(
//                             title: 'Physical Activity',
//                             isSelected:
//                             selectedRecoveryGoal == 'Physical Activity',
//                             onTap: () => setState(
//                                     () => selectedRecoveryGoal = 'Physical Activity'),
//                           ),
//                         ],
//                       ),
//                       UIHelper.verticalSpace(12.h),
//                       Row(
//                         children: [
//                           RecoveryGoal(
//                             title: 'Social Life',
//                             isSelected: selectedRecoveryGoal == 'Social Life',
//                             onTap: () =>
//                                 setState(() => selectedRecoveryGoal = 'Social Life'),
//                           ),
//                           RecoveryGoal(
//                             title: 'Mental Wellbeing',
//                             isSelected:
//                             selectedRecoveryGoal == 'Mental Wellbeing',
//                             onTap: () => setState(
//                                     () => selectedRecoveryGoal = 'Mental Wellbeing'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               UIHelper.verticalSpace(24.h),
//
//               // ===================== Progress Timeline =====================
//               Container(
//                 width: double.infinity,
//                 decoration: ShapeDecoration(
//                   color: AppColors.c181818,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                 ),
//                 child: Padding(
//                   padding:
//                   EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Progress Timeline',
//                         style: TextFontStyle.textStyle14w400cA3A3A3poppins
//                             .copyWith(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 18.sp,
//                         ),
//                       ),
//                       UIHelper.verticalSpace(12.h),
//                       ProgressTimeline(
//                         sliderValue: sliderValue,
//                         onChanged: (value) {
//                           setState(() {
//                             sliderValue = value;
//                             if (value < 0.33) {
//                               progressLabel = 'Start';
//                             } else if (value < 0.66) {
//                               progressLabel = 'Middle';
//                             } else {
//                               progressLabel = 'End';
//                             }
//                           });
//                         },
//                         labels: const ['Start', 'Middle', 'End'],
//                       ),
//                       UIHelper.verticalSpace(16.h),
//                       Text(
//                         'Target Date',
//                         style: TextFontStyle.textStyle14w400cA3A3A3poppins
//                             .copyWith(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 18.sp,
//                         ),
//                       ),
//                       UIHelper.verticalSpace(12.h),
//                       WeeksDropdwon(
//                         items: durationList,
//                         initialValue: selectedDuration,
//                         onChanged: (value) =>
//                             setState(() => selectedDuration = value!),
//                         padding: EdgeInsets.symmetric(horizontal: 16.w),
//                         iconPath: AppIcons.bottomdrodwonicon,
//                         iconHeight: 18,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               UIHelper.verticalSpace(32.h),
//
//               // ===================== Next Button =====================
//               CustomButtonWidget(
//                 onTap: () async {
//                   setState(() => isLoading = true);
//
//                   try {
//                     bool success = await recoveryRegistrationApiRxObj.registerRecoveryUserApi(
//                       name: "RH Robin",
//                       email: "zobayer.dev@gmail.com",
//                       phone: "1234567890",
//                       password: "12345678",
//                       password_confirmation: "12345678",
//                       age: 30,
//                       gender: "male",
//                       user_mode: "recovery",
//                       terms_accepted: true,
//                       injury_name: "Ankle Sprain",
//                       injury_level: "Moderate",
//                       injury_date: "2025-10-01",
//                       current_recovery_stage: "Early",
//                       physical_symptom: 4,
//                       physical_symptom_details: "Pain",
//                       physical_symptom_duration: 30,
//                       physical_symptom_frequency: 2,
//                       emotional_symptoms: "Anxiety",
//                       recovery_goal: "Full mobility",
//                       recovery_goal_time: "6 weeks",
//                       progress_timeline: "2 weeks",
//                       recovery_target_date: "2025-11-24",
//                       reminder_from: "08:00:00",
//                       reminder_to: "20:00:00",
//                     );
//
//                     if (success) {
//                       NavigationService.navigateTo(Routes.allSetScreen);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Registration failed. Please try again.'),
//                         ),
//                       );
//                     }
//                   } catch (e) {
//                     log("Registration API Error: $e");
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Failed to register. Please check your input.'),
//                       ),
//                     );
//                   } finally {
//                     setState(() => isLoading = false);
//                   }
//                 },
//                 text: isLoading ? 'Loading...' : 'Next',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
