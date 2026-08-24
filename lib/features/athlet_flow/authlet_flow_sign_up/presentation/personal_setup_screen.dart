import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_athlete_app_bar.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/personal_setup_endurance_energy_sections.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/personal_setup_muscle_section.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/personal_setup_widgets.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class PersonalSetupScreen extends StatefulWidget {
  const PersonalSetupScreen({super.key});

  @override
  State<PersonalSetupScreen> createState() => _PersonalSetupScreenState();
}

class _PersonalSetupScreenState extends State<PersonalSetupScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String selectedGender = 'male';
  String heightUnit = 'cm';
  bool isLbs = false;

  // Triathlon
  String swimLevel = 'Beginner';
  String bikeLevel = 'Beginner';
  String runLevel = 'Beginner';
  double weeklyAvailability = 11.0;
  String previousRaceExperience = 'Yes';

  // 5K Pace
  String runningExperience = 'Beginner';
  int current5kTime = 28;
  String selectedFrequency5k = '3x';
  String hasInjury = 'No';

  // Muscle Mass
  String liftingExperience = 'Beginner';
  bool hasGymAccess = true;
  int weeklyTrainingDays = 3;

  // Endurance
  String activityLevel = 'Low';
  int longestCardio = 30;
  String selectedFrequencyEndurance = '3x';
  String primarySport = 'Running';

  // Energy & Performance
  int averageSleep = 6;
  String dailyActivity = 'Sedentary';
  String stressLevel = 'Low';
  String workIntensity = 'Desk Job';

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void _onNext() {
    String selectedGoal = appData.read(kKeyAthleteSelectGoal) ?? 'COMPLETE_TRIATHLON';
    bool isTriathlon = selectedGoal == 'COMPLETE_TRIATHLON' || selectedGoal.toUpperCase().contains('TRIATHLON');
    bool is5kPace = selectedGoal == 'IMPROVE_5K_PACE' || selectedGoal.toUpperCase().contains('5K');
    bool isMuscle = selectedGoal == 'BUILD_MUSCLE_MASS' || selectedGoal.toUpperCase().contains('MUSCLE');
    bool isEndurance = selectedGoal == 'IMPROVE_ENDURANCE' || selectedGoal.toUpperCase().contains('ENDURANCE');

    Map<String, dynamic> setupData = {};

    if (isTriathlon) {
      setupData = {
        "swimming_level": swimLevel,
        "cycling_level": bikeLevel,
        "running_level": runLevel,
        "weekly_training_availability_hours": weeklyAvailability.toInt(),
        "previous_race_experience": previousRaceExperience == 'Yes',
      };
    } else if (is5kPace) {
      int freq = int.tryParse(selectedFrequency5k.replaceAll(RegExp(r'[^0-9]'), '')) ?? 3;
      setupData = {
        "running_experience": runningExperience,
        "current_5k_time_minutes": current5kTime,
        "weekly_running_frequency": freq,
        "current_injury": hasInjury == 'Yes',
      };
    } else if (isMuscle) {
      setupData = {
        "training_experience": liftingExperience,
        "gym_access": hasGymAccess,
        "weekly_training_days": weeklyTrainingDays,
      };
    } else if (isEndurance) {
      int freq = int.tryParse(selectedFrequencyEndurance.replaceAll(RegExp(r'[^0-9]'), '')) ?? 3;
      setupData = {
        "current_activity_level": activityLevel,
        "longest_cardio_duration_minutes": longestCardio,
        "weekly_running_frequency": freq,
        "primary_sport": primarySport,
      };
    } else {
      setupData = {
        "average_sleep_hours": averageSleep,
        "daily_activity": dailyActivity,
        "stress_level": stressLevel,
        "work_training_intensity": workIntensity,
      };
    }

    appData.write('athleteSetupData', setupData);
    log("Personal Setup submitted for Goal: $selectedGoal with setup_data: $setupData");
    NavigationService.navigateTo(Routes.defineTargetScreen);
  }

  @override
  Widget build(BuildContext context) {
    String selectedGoal = appData.read(kKeyAthleteSelectGoal) ?? 'COMPLETE_TRIATHLON';
    bool isTriathlon = selectedGoal == 'COMPLETE_TRIATHLON' || selectedGoal.toUpperCase().contains('TRIATHLON');
    bool is5kPace = selectedGoal == 'IMPROVE_5K_PACE' || selectedGoal.toUpperCase().contains('5K');
    bool isMuscle = selectedGoal == 'BUILD_MUSCLE_MASS' || selectedGoal.toUpperCase().contains('MUSCLE');
    bool isEndurance = selectedGoal == 'IMPROVE_ENDURANCE' || selectedGoal.toUpperCase().contains('ENDURANCE');

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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(12.h),
                const CustomAthleteAppBar(
                  title: 'Personal Setup',
                  subtitle: 'Tell us about yourself so we can personalise your plan',
                  currentStep: 1,
                  totalSteps: 4,
                ),
                UIHelper.verticalSpace(24.h),
                if (isTriathlon) ...[
                  PersonalSetupTriathlonSection(
                    swimLevel: swimLevel,
                    bikeLevel: bikeLevel,
                    runLevel: runLevel,
                    weeklyAvailability: weeklyAvailability,
                    previousRaceExperience: previousRaceExperience,
                    onSwimChange: (val) => setState(() => swimLevel = val),
                    onBikeChange: (val) => setState(() => bikeLevel = val),
                    onRunChange: (val) => setState(() => runLevel = val),
                    onAvailabilityChange: (val) => setState(() => weeklyAvailability = val),
                    onRaceChange: (val) => setState(() => previousRaceExperience = val),
                  ),
                ] else if (is5kPace) ...[
                  PersonalSetup5kSection(
                    runningExperience: runningExperience,
                    current5kTime: current5kTime,
                    selectedFrequency: selectedFrequency5k,
                    hasInjury: hasInjury,
                    onExpChange: (val) => setState(() => runningExperience = val),
                    onTimeChange: (val) => setState(() => current5kTime = val),
                    onFreqChange: (val) => setState(() => selectedFrequency5k = val),
                    onInjuryChange: (val) => setState(() => hasInjury = val),
                  ),
                ] else if (isMuscle) ...[
                  PersonalSetupMuscleSection(
                    liftingExperience: liftingExperience,
                    hasGymAccess: hasGymAccess,
                    weeklyDays: weeklyTrainingDays,
                    onExpChange: (val) => setState(() => liftingExperience = val),
                    onGymChange: (val) => setState(() => hasGymAccess = val),
                    onDaysChange: (val) => setState(() => weeklyTrainingDays = val),
                  ),
                ] else if (isEndurance) ...[
                  PersonalSetupEnduranceSection(
                    activityLevel: activityLevel,
                    longestCardio: longestCardio,
                    selectedFrequency: selectedFrequencyEndurance,
                    primarySport: primarySport,
                    onActivityChange: (val) => setState(() => activityLevel = val),
                    onCardioChange: (val) => setState(() => longestCardio = val),
                    onFreqChange: (val) => setState(() => selectedFrequencyEndurance = val),
                    onSportChange: (val) => setState(() => primarySport = val),
                  ),
                ] else ...[
                  PersonalSetupEnergySection(
                    averageSleep: averageSleep,
                    dailyActivity: dailyActivity,
                    stressLevel: stressLevel,
                    workIntensity: workIntensity,
                    onSleepChange: (val) => setState(() => averageSleep = val),
                    onActivityChange: (val) => setState(() => dailyActivity = val),
                    onStressChange: (val) => setState(() => stressLevel = val),
                    onIntensityChange: (val) => setState(() => workIntensity = val),
                  ),
                ],
                UIHelper.verticalSpace(36.h),
                CustomButtonWidget(
                  onTap: _onNext,
                  textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                  image: DecorationImage(
                    image: AssetImage(AppImages.orangebutton),
                  ),
                  text: 'Set My Target →',
                ),
                UIHelper.verticalSpace(24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
