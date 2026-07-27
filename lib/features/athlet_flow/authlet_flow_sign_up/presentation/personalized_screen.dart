import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/age_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_height.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_time.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_with.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/select_unselect_gender.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/stepbar_select_goal.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class PersonalizedScreen extends StatefulWidget {
  const PersonalizedScreen({super.key});

  @override
  State<PersonalizedScreen> createState() => _PersonalizedScreenState();
}

class _PersonalizedScreenState extends State<PersonalizedScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String selectedDuration = '4 Weeks';
  List<String> durationList = ['4 Weeks', '1 Week', '3 Weeks', '5 Weeks'];

  String heightUnit = 'cm';
  bool isSelectedWeight = false;

  String selectedGender = 'male';
  String? selectedTime;
  String? timeError;

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }


  // String getFormattedDuration(String duration) {
  //   switch (duration) {
  //     case '1 Week':
  //       return '1_week';
  //     case '3 Weeks':
  //       return '3_week';
  //     case '4 Weeks':
  //       return '4_week';
  //     case '5 Weeks':
  //       return '5_week';
  //     default:
  //       return '4_week';
  //   }
  // }


  void _submit() async {
    setState(() {
      timeError = null;
    });

    if (_formKey.currentState!.validate()) {
      if (selectedTime == null) {
        setState(() {
          timeError = "⚠️ Please select a reminder time";
        });
        return;
      }

      // Map reminder time to specific ranges
      Map<String, Map<String, String>> reminderTimes = {
        'Morning': {'reminder_from': '06:00:00', 'reminder_to': '10:00:00'},
        'Afternoon': {'reminder_from': '11:00:00', 'reminder_to': '17:00:00'},
        'Evening': {'reminder_from': '18:00:00', 'reminder_to': '22:00:00'},
      };

      // Map selected time to display format
      Map<String, String> timeDisplay = {
        'Morning': 'Morning 6 AM-10 AM',
        'Afternoon': 'Afternoon 11 AM-5 PM',
        'Evening': 'Evening 6 PM-10 PM',
      };

      // Get reminder time range
      String reminderFrom = reminderTimes[selectedTime]!['reminder_from']!;
      String reminderTo = reminderTimes[selectedTime]!['reminder_to']!;

      // Parse age, height, and weight
      int? age = int.tryParse(ageController.text);
      double? height = double.tryParse(heightController.text);
      double? weight = double.tryParse(weightController.text);

      // Validate inputs
      if (age == null || height == null || weight == null) {
        ToastUtil.showShortToast("Please enter valid age, height, and weight");
        return;
      }

      // Set default units
      String heightUnitDefault = 'cm'; // Default to cm
      String weightUnitDefault = isSelectedWeight ? 'lbs' : 'kg'; // Respect user selection, default to kg if not selected

      // Format height and weight strings
      String heightString = '$height $heightUnitDefault';
      String weightString = '$weight $weightUnitDefault';


      // Prepare the output map
      Map<String, dynamic> output = {
        'age': age,
        'gender': selectedGender,
        'height': height,
        'height_unit': heightUnitDefault,
        'height_string': heightString,
        'weight': weight,
        'weight_unit': weightUnitDefault,
        'weight_string': weightString,
        'reminder_from': reminderFrom,
        'reminder_to': reminderTo,
      };

      // Save reminder time locally
      appData.write(kKeyAthleteDailyReminder, timeDisplay[selectedTime!]);

      // Logging for debug
      log('age: ${output['age']}');
      log('gender: ${output['gender']}');
      log('height: ${output['height']}');
      log('height_unit: ${output['height_unit']}');
      log('weight: ${output['weight']}');
      log('weight_unit: ${output['weight_unit']}');
      log('reminder_from: ${output['reminder_from']}');
      log('reminder_to: ${output['reminder_to']}');
      log('AthleteDailyReminder: ${appData.read(kKeyAthleteDailyReminder)}');
      log("Preferred Reminder time: ${timeDisplay[selectedTime]}");
      log("Next Button clicked: go to allSetPersonalInformationScreen");
      // log('📅 recovery_target_date: ${getFormattedDuration(selectedDuration)}');

      try {
        bool success = await onboardingAthleteSignUpRx.onboardingAthleteSignUpApiInfo(

          age: age.toString(),
          gender: selectedGender,
          goal: appData.read(kKeyAthleteSelectGoal) ?? 'COMPLETE TRIATHLON',
          sport: appData.read(kKeyAthleteSelectSport) ?? 'GYM',
          experienceLevel: appData.read(kKeyAthleteExperiencelevel) ?? 'ADVANCED',
          height: height,
          heightUnit: heightUnitDefault, // Use default cm
          weight: weight,
          weightUnit: weightUnitDefault, // Use default kg or lbs based on selection
          reminderFrom: reminderFrom,
          reminderTo: reminderTo,
          userMode: "athlete",
          // recoveryTargetDate: getFormattedDuration(selectedDuration)
        );

        if (success) {
          NavigationService.navigateTo(Routes.planGeneratingScreen);
        } else {
          log("================ Registration Failed. Try again.");
        }
      } catch (e) {
        log("Error during registration: $e");
        // Fallback navigation in case offline / testing
        NavigationService.navigateTo(Routes.planGeneratingScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String? goals = appData.read(kKeyAthleteSelectGoal);
    String? sport = appData.read(kKeyAthleteSelectSport);
    String? experienceLevel = appData.read(kKeyAthleteExperiencelevel);

    // Log the data

    log('++++++++++++====AthleteSelectGoal: $goals');
    log('++++++++++++====AthleteSelectSport: $sport');
    log('++++++++++++====AthleteExperiencelevel: $experienceLevel');



    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ArrowButtonAtheleteFlow(
                    onTap: () {
                      NavigationService.goBack;
                    },
                  ),
                  UIHelper.verticalSpace(12.h),
                  Text(
                    'Tell us about you',
                    style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                      fontSize: 32.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    'Please give the information',
                    style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                  ),
                  UIHelper.verticalSpace(18.h),
                  StepBarSelectGoal(
                    currentStep: 3,
                    totalSteps: 5,
                    onTap: () {
                      NavigationService.navigateTo(Routes.recoveryStepTwoScreen);
                    },
                    onStepTap: (int index) {},
                  ),
                  UIHelper.verticalSpace(18.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAge(
                            controller: ageController,
                          ),
                          UIHelper.verticalSpace(12.h),
                          // Gender Select
                          Text(
                            'Select Gender',
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),
                          Row(
                            children: [
                              Expanded(
                                child: SelectUnselectGender(
                                  text: 'Male',
                                  isSelected: selectedGender == 'male',
                                  onTap: () {
                                    setState(() {
                                      selectedGender = 'male';
                                    });
                                  },
                                ),
                              ),
                              UIHelper.horizontalSpace(15.w),
                              Expanded(
                                child: SelectUnselectGender(
                                  text: 'Female',
                                  isSelected: selectedGender == 'female',
                                  onTap: () {
                                    setState(() {
                                      selectedGender = 'female';
                                    });
                                  },
                                ),
                              ),
                              UIHelper.horizontalSpace(15.w),
                              Expanded(
                                child: SelectUnselectGender(
                                  text: 'Other',
                                  isSelected: selectedGender == 'other',
                                  onTap: () {
                                    setState(() {
                                      selectedGender = 'other';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(24.h),
                          // Height
                          CustomHeight(
                            controller: heightController,
                            heightUnit: heightUnit,
                            onUnitChange: (val) {
                              setState(() {
                                heightUnit = val;
                              });
                            },
                          ),
                          UIHelper.verticalSpace(24.h),
                          // Weight
                          CustomWith(
                            controller: weightController,
                            isLbs: isSelectedWeight,
                            onUnitChange: (val) {
                              setState(() {
                                isSelectedWeight = val;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your weight';
                              }
                              double? weight = double.tryParse(value);
                              if (weight == null || weight <= 0) {
                                return 'Please enter a valid weight';
                              }
                              return null;
                            },
                          ),
                          UIHelper.verticalSpace(24.h),
                          // Reminder
                          Text(
                            'Preferred reminder time',
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTime(
                                  title: 'Morning',
                                  subtitle: '6-10 AM',
                                  isSelected: selectedTime == 'Morning',
                                  onTap: () {
                                    setState(() {
                                      selectedTime = 'Morning';
                                    });
                                  },
                                ),
                              ),
                              UIHelper.horizontalSpace(15.w),
                              Expanded(
                                child: CustomTime(
                                  title: 'Afternoon',
                                  subtitle: '11 AM - 5 PM',
                                  isSelected: selectedTime == 'Afternoon',
                                  onTap: () {
                                    setState(() {
                                      selectedTime = 'Afternoon';
                                    });
                                  },
                                ),
                              ),
                              UIHelper.horizontalSpace(15.w),
                              Expanded(
                                child: CustomTime(
                                  title: 'Evening',
                                  subtitle: '6 - 10 PM',
                                  isSelected: selectedTime == 'Evening',
                                  onTap: () {
                                    setState(() {
                                      selectedTime = 'Evening';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          if (timeError != null) ...[
                            UIHelper.verticalSpace(8.h),
                            Text(
                              timeError!,
                              style: TextStyle(color: Colors.red, fontSize: 14.sp),
                            ),
                          ],
                          // UIHelper.verticalSpace(24.h),
                          // WeeksDropdwon(
                          //   items: durationList,
                          //   initialValue: selectedDuration,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedDuration = value;
                          //     });
                          //   },
                          //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                          //   iconPath: AppIcons.bottomdrodwonicon,
                          //   iconHeight: 18,
                          // ),
                          UIHelper.verticalSpace(38.h),
                          // Submit Button
                          CustomButtonWidget(
                            onTap: _submit,
                            textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                            image: DecorationImage(
                              image: AssetImage(AppImages.orangebutton),
                            ),
                            text: 'Generate My Plan ✨',
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
      ),
    );
  }
}