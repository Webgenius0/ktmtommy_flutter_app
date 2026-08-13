import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/age_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_athlete_app_bar.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_height.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_with.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/personalized_gender_reminder_widgets.dart';
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

      Map<String, Map<String, String>> reminderTimes = {
        'Morning': {'reminder_from': '06:00:00', 'reminder_to': '10:00:00'},
        'Afternoon': {'reminder_from': '11:00:00', 'reminder_to': '17:00:00'},
        'Evening': {'reminder_from': '18:00:00', 'reminder_to': '22:00:00'},
      };

      Map<String, String> timeDisplay = {
        'Morning': 'Morning 6 AM-10 AM',
        'Afternoon': 'Afternoon 11 AM-5 PM',
        'Evening': 'Evening 6 PM-10 PM',
      };

      String reminderFrom = reminderTimes[selectedTime]!['reminder_from']!;
      String reminderTo = reminderTimes[selectedTime]!['reminder_to']!;

      int? age = int.tryParse(ageController.text);
      double? height = double.tryParse(heightController.text);
      double? weight = double.tryParse(weightController.text);

      if (age == null || height == null || weight == null) {
        ToastUtil.showShortToast("Please enter valid age, height, and weight");
        return;
      }

      String heightUnitDefault = 'cm';
      String weightUnitDefault = isSelectedWeight ? 'lbs' : 'kg';

      appData.write(kKeyAthleteDailyReminder, timeDisplay[selectedTime!]);

      try {
        bool success = await onboardingAthleteSignUpRx.onboardingAthleteSignUpApiInfo(
          age: age.toString(),
          gender: selectedGender,
          goal: appData.read(kKeyAthleteSelectGoal) ?? 'COMPLETE TRIATHLON',
          sport: appData.read(kKeyAthleteSelectSport) ?? 'GYM',
          experienceLevel: appData.read(kKeyAthleteExperiencelevel) ?? 'ADVANCED',
          height: height,
          heightUnit: heightUnitDefault,
          weight: weight,
          weightUnit: weightUnitDefault,
          reminderFrom: reminderFrom,
          reminderTo: reminderTo,
          userMode: "athlete",
        );

        if (success) {
          NavigationService.navigateTo(Routes.planGeneratingScreen);
        } else {
          NavigationService.navigateTo(Routes.planGeneratingScreen);
        }
      } catch (e) {
        log("Error during registration: $e");
        NavigationService.navigateTo(Routes.planGeneratingScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  UIHelper.verticalSpace(12.h),
                  const CustomAthleteAppBar(
                    title: 'Tell us about you',
                    subtitle: 'Please give the information',
                    currentStep: 3,
                    totalSteps: 4,
                  ),
                  UIHelper.verticalSpace(18.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAge(controller: ageController),
                          UIHelper.verticalSpace(12.h),
                          PersonalizedGenderSelector(
                            selectedGender: selectedGender,
                            onSelectGender: (gen) => setState(() => selectedGender = gen),
                          ),
                          UIHelper.verticalSpace(24.h),
                          CustomHeight(
                            controller: heightController,
                            heightUnit: heightUnit,
                            onUnitChange: (val) => setState(() => heightUnit = val),
                          ),
                          UIHelper.verticalSpace(24.h),
                          CustomWith(
                            controller: weightController,
                            isLbs: isSelectedWeight,
                            onUnitChange: (val) => setState(() => isSelectedWeight = val),
                          ),
                          UIHelper.verticalSpace(24.h),
                          PersonalizedReminderSelector(
                            selectedTime: selectedTime,
                            timeError: timeError,
                            onSelectTime: (t) => setState(() => selectedTime = t),
                          ),
                          UIHelper.verticalSpace(38.h),
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