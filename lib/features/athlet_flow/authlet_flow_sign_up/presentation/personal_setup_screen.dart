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
    String? goal = appData.read(kKeyAthleteSelectGoal);
    log("Personal Setup submitted for Goal: $goal");
    NavigationService.navigateTo(Routes.defineTargetScreen);
  }

  @override
  Widget build(BuildContext context) {
    String selectedGoal = appData.read(kKeyAthleteSelectGoal) ?? 'COMPLETE TRIATHLON';
    bool isTriathlon = selectedGoal.toUpperCase().contains('TRIATHLON');
    bool is5kPace = selectedGoal.toUpperCase().contains('5K');
    bool isMuscle = selectedGoal.toUpperCase().contains('MUSCLE');
    bool isEndurance = selectedGoal.toUpperCase().contains('ENDURANCE');

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
                    selectedGender: selectedGender,
                    heightController: heightController,
                    weightController: weightController,
                    heightUnit: heightUnit,
                    isLbs: isLbs,
                    liftingExperience: liftingExperience,
                    hasGymAccess: hasGymAccess,
                    weeklyDays: weeklyTrainingDays,
                    onGenderChange: (val) => setState(() => selectedGender = val),
                    onHeightUnitChange: (val) => setState(() => heightUnit = val),
                    onWeightUnitChange: (val) => setState(() => isLbs = val),
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
