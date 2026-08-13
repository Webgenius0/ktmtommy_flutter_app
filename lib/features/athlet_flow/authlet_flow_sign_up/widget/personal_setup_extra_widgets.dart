import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_height.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_with.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/personal_setup_helpers.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/personalized_gender_reminder_widgets.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class PersonalSetupMuscleSection extends StatelessWidget {
  final String selectedGender;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final String heightUnit;
  final bool isLbs;
  final String liftingExperience;
  final bool hasGymAccess;
  final int weeklyDays;
  final Function(String) onGenderChange;
  final Function(String) onHeightUnitChange;
  final Function(bool) onWeightUnitChange;
  final Function(String) onExpChange;
  final Function(bool) onGymChange;
  final Function(int) onDaysChange;

  const PersonalSetupMuscleSection({
    super.key,
    required this.selectedGender,
    required this.heightController,
    required this.weightController,
    required this.heightUnit,
    required this.isLbs,
    required this.liftingExperience,
    required this.hasGymAccess,
    required this.weeklyDays,
    required this.onGenderChange,
    required this.onHeightUnitChange,
    required this.onWeightUnitChange,
    required this.onExpChange,
    required this.onGymChange,
    required this.onDaysChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonalizedGenderSelector(
          selectedGender: selectedGender,
          onSelectGender: onGenderChange,
        ),
        UIHelper.verticalSpace(20.h),
        CustomHeight(
          controller: heightController,
          heightUnit: heightUnit,
          onUnitChange: onHeightUnitChange,
        ),
        UIHelper.verticalSpace(20.h),
        CustomWith(
          controller: weightController,
          isLbs: isLbs,
          onUnitChange: onWeightUnitChange,
        ),
        UIHelper.verticalSpace(20.h),
        PersonalSetupLevelSelector(
          title: 'Training Experience',
          icon: Icons.fitness_center,
          selectedLevel: liftingExperience,
          onSelect: onExpChange,
        ),
        UIHelper.verticalSpace(20.h),
        PersonalSetupChoiceSelector(
          title: 'Do you have gym access?',
          options: const ['Yes', 'No'],
          selectedOption: hasGymAccess ? 'Yes' : 'No',
          onSelect: (val) => onGymChange(val == 'Yes'),
        ),
        UIHelper.verticalSpace(20.h),
        PersonalSetupChoiceSelector(
          title: 'Weekly Training Days',
          options: const ['2', '3', '4', '5', '6'],
          selectedOption: weeklyDays.toString(),
          onSelect: (val) => onDaysChange(int.tryParse(val) ?? 3),
        ),
      ],
    );
  }
}

class PersonalSetupEnduranceSection extends StatelessWidget {
  final String activityLevel;
  final int longestCardio;
  final String selectedFrequency;
  final String primarySport;
  final Function(String) onActivityChange;
  final Function(int) onCardioChange;
  final Function(String) onFreqChange;
  final Function(String) onSportChange;

  const PersonalSetupEnduranceSection({
    super.key,
    required this.activityLevel,
    required this.longestCardio,
    required this.selectedFrequency,
    required this.primarySport,
    required this.onActivityChange,
    required this.onCardioChange,
    required this.onFreqChange,
    required this.onSportChange,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> sports = const [
      {'name': 'Running', 'icon': '🏃'},
      {'name': 'Cycling', 'icon': '🚴'},
      {'name': 'Swimming', 'icon': '🏊'},
      {'name': 'Mixed', 'icon': '🎛️'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonalSetupChoiceSelector(
          title: 'Current Activity Level',
          options: const ['Low', 'Moderate', 'High'],
          selectedOption: activityLevel,
          onSelect: onActivityChange,
        ),
        UIHelper.verticalSpace(20.h),
        PersonalSetupCounterWidget(
          title: 'Longest Cardio Duration',
          value: longestCardio,
          unit: 'min',
          onChange: onCardioChange,
        ),
        UIHelper.verticalSpace(20.h),
        PersonalSetupChoiceSelector(
          title: 'Weekly Running Frequency',
          options: const ['1x', '2x', '3x', '4x', '5x+'],
          selectedOption: selectedFrequency,
          onSelect: onFreqChange,
        ),
        UIHelper.verticalSpace(20.h),
        Text(
          'Primary Sport',
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(10.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 10.h,
          ),
          itemCount: sports.length,
          itemBuilder: (context, index) {
            String sName = sports[index]['name']!;
            String sIcon = sports[index]['icon']!;
            bool isSelected = primarySport == sName;

            return GestureDetector(
              onTap: () => onSportChange(sName),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.c181818,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected ? AppColors.orangeColor : AppColors.c2F2F2F,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(sIcon, style: TextStyle(fontSize: 16.sp)),
                    UIHelper.horizontalSpace(8.w),
                    Text(
                      sName,
                      style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                        fontSize: 13.sp,
                        color: isSelected ? AppColors.cFFFFFF : AppColors.cA3A3A3,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class PersonalSetupEnergySection extends StatelessWidget {
  final int averageSleep;
  final String dailyActivity;
  final String stressLevel;
  final String workIntensity;
  final Function(int) onSleepChange;
  final Function(String) onActivityChange;
  final Function(String) onStressChange;
  final Function(String) onIntensityChange;

  const PersonalSetupEnergySection({
    super.key,
    required this.averageSleep,
    required this.dailyActivity,
    required this.stressLevel,
    required this.workIntensity,
    required this.onSleepChange,
    required this.onActivityChange,
    required this.onStressChange,
    required this.onIntensityChange,
  });

  @override
  Widget build(BuildContext context) {
    List<String> activityOptions = const ['Sedentary', 'Light', 'Active', 'Very Active'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonalSetupCounterWidget(
          title: 'Average Sleep',
          value: averageSleep,
          unit: 'hour',
          formatTwoDigits: true,
          onChange: onSleepChange,
        ),
        UIHelper.verticalSpace(20.h),
        Text(
          'Daily Activity Level',
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(10.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 10.h,
          ),
          itemCount: activityOptions.length,
          itemBuilder: (context, index) {
            String opt = activityOptions[index];
            bool isSelected = dailyActivity == opt;

            return GestureDetector(
              onTap: () => onActivityChange(opt),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.c181818,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected ? AppColors.orangeColor : AppColors.c2F2F2F,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    opt,
                    style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                      fontSize: 13.sp,
                      color: isSelected ? AppColors.cFFFFFF : AppColors.cA3A3A3,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        UIHelper.verticalSpace(20.h),
        PersonalSetupChoiceSelector(
          title: 'Stress Level',
          options: const ['Low', 'Medium', 'High'],
          selectedOption: stressLevel,
          onSelect: onStressChange,
        ),
        UIHelper.verticalSpace(20.h),
        PersonalSetupChoiceSelector(
          title: 'Work / Training Intensity',
          options: const ['Desk Job', 'Mixed', 'Physical'],
          selectedOption: workIntensity,
          onSelect: onIntensityChange,
        ),
      ],
    );
  }
}
