import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
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
  bool isLoading = false;

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (isLoading) return;

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

      Map<String, String> timeDisplay = {
        'Morning': 'Morning 6-10 AM',
        'Afternoon': 'Afternoon 11 AM - 5 PM',
        'Evening': 'Evening 5-10 PM',
      };

      int? age = int.tryParse(ageController.text);
      double? rawHeight = double.tryParse(heightController.text);
      double? rawWeight = double.tryParse(weightController.text);

      if (age == null || rawHeight == null || rawWeight == null) {
        ToastUtil.showShortToast("Please enter valid age, height, and weight");
        return;
      }

      String formattedHeightUnit = heightUnit.toLowerCase();
      if (formattedHeightUnit == 'in') {
        formattedHeightUnit = 'inch';
      }
      if (formattedHeightUnit.isEmpty) {
        formattedHeightUnit = 'cm';
      }

      if (formattedHeightUnit == 'cm' && rawHeight < 40) {
        ToastUtil.showShortToast("Height must be at least 40 cm");
        return;
      }

      dynamic heightVal = (rawHeight % 1 == 0) ? rawHeight.toInt() : rawHeight;
      dynamic weightVal = (rawWeight % 1 == 0) ? rawWeight.toInt() : rawWeight;

      String formattedGender = selectedGender.toLowerCase() == 'male'
          ? 'Male'
          : selectedGender.toLowerCase() == 'female'
              ? 'Female'
              : 'Other';

      String weightUnitDefault = isSelectedWeight ? 'lbs' : 'kg';
      String reminderTimeStr = timeDisplay[selectedTime!] ?? 'Morning 6-10 AM';

      appData.write(kKeyAthleteDailyReminder, reminderTimeStr);

      Map<String, dynamic> setupData = Map<String, dynamic>.from(appData.read('athleteSetupData') ?? {});
      Map<String, dynamic> targetData = Map<String, dynamic>.from(appData.read('athleteTargetData') ?? {});
      String goal = appData.read(kKeyAthleteSelectGoal) ?? 'COMPLETE_TRIATHLON';

      Map<String, dynamic> payload = {
        "user_mode": "athlete",
        "goal": goal,
        "age": age,
        "gender": formattedGender,
        "height": heightVal,
        "height_unit": formattedHeightUnit,
        "weight": weightVal,
        "weight_unit": weightUnitDefault,
        "reminder_time": reminderTimeStr,
        "setup_data": setupData,
        "target_data": targetData,
      };

      log("Submitting Athlete Onboarding Payload to /onboarding/athlete: $payload");

      setState(() {
        isLoading = true;
      });

      try {
        bool success = await onboardingAthleteSignUpRx.onboardingAthleteSignUpApiInfo(payload);

        setState(() {
          isLoading = false;
        });

        if (success) {
          log("Athlete onboarding successful! Navigating to planGeneratingScreen...");
          NavigationService.navigateTo(Routes.planGeneratingScreen);
        } else {
          log("Athlete onboarding failed! Staying on personalizedScreen to show error toast.");
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        log("Error during athlete onboarding: $e");
        ToastUtil.showShortToast("Failed to submit onboarding. Please try again.");
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
          child: Stack(
            children: [
              Form(
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
                                onTap: isLoading ? () {} : _submit,
                                textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                                image: DecorationImage(
                                  image: AssetImage(AppImages.orangebutton),
                                ),
                                text: isLoading ? 'Generating Plan...' : 'Generate My Plan ✨',
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
              if (isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.orangeColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}