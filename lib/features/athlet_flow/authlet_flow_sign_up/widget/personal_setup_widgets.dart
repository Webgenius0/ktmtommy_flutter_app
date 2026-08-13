import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/personal_setup_helpers.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class PersonalSetupTriathlonSection extends StatelessWidget {
  final String swimLevel;
  final String bikeLevel;
  final String runLevel;
  final double weeklyAvailability;
  final String previousRaceExperience;
  final Function(String) onSwimChange;
  final Function(String) onBikeChange;
  final Function(String) onRunChange;
  final Function(double) onAvailabilityChange;
  final Function(String) onRaceChange;

  const PersonalSetupTriathlonSection({
    super.key,
    required this.swimLevel,
    required this.bikeLevel,
    required this.runLevel,
    required this.weeklyAvailability,
    required this.previousRaceExperience,
    required this.onSwimChange,
    required this.onBikeChange,
    required this.onRunChange,
    required this.onAvailabilityChange,
    required this.onRaceChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonalSetupLevelSelector(
          title: 'Swimming Level',
          icon: Icons.pool,
          selectedLevel: swimLevel,
          onSelect: onSwimChange,
        ),
        UIHelper.verticalSpace(20.h),
        PersonalSetupLevelSelector(
          title: 'Cycling Level',
          icon: Icons.directions_bike,
          selectedLevel: bikeLevel,
          onSelect: onBikeChange,
        ),
        UIHelper.verticalSpace(20.h),
        PersonalSetupLevelSelector(
          title: 'Running Level',
          icon: Icons.directions_run,
          selectedLevel: runLevel,
          onSelect: onRunChange,
        ),
        UIHelper.verticalSpace(24.h),
        Text(
          'Weekly Training Availability: ${weeklyAvailability.toInt()}h',
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(8.h),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.orangeColor,
            inactiveTrackColor: AppColors.c2F2F2F,
            thumbColor: AppColors.orangeColor,
            overlayColor: AppColors.orangeColor.withOpacity(0.2),
            trackHeight: 6.h,
          ),
          child: Slider(
            value: weeklyAvailability,
            min: 2,
            max: 20,
            divisions: 18,
            onChanged: onAvailabilityChange,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('2h/wk', style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(fontSize: 12.sp)),
            Text('${weeklyAvailability.toInt()}h', style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(fontSize: 12.sp, color: AppColors.orangeColor)),
            Text('20h/wk', style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(fontSize: 12.sp)),
          ],
        ),
        UIHelper.verticalSpace(24.h),
        PersonalSetupChoiceSelector(
          title: 'Previous Race Experience?',
          options: const ['Yes', 'No'],
          selectedOption: previousRaceExperience,
          onSelect: onRaceChange,
        ),
      ],
    );
  }
}

class PersonalSetup5kSection extends StatelessWidget {
  final String runningExperience;
  final int current5kTime;
  final String selectedFrequency;
  final String hasInjury;
  final Function(String) onExpChange;
  final Function(int) onTimeChange;
  final Function(String) onFreqChange;
  final Function(String) onInjuryChange;

  const PersonalSetup5kSection({
    super.key,
    required this.runningExperience,
    required this.current5kTime,
    required this.selectedFrequency,
    required this.hasInjury,
    required this.onExpChange,
    required this.onTimeChange,
    required this.onFreqChange,
    required this.onInjuryChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonalSetupLevelSelector(
          title: 'Running Experience',
          icon: Icons.directions_run,
          selectedLevel: runningExperience,
          onSelect: onExpChange,
        ),
        UIHelper.verticalSpace(24.h),
        PersonalSetupCounterWidget(
          title: 'Current 5K Time',
          value: current5kTime,
          unit: 'min',
          onChange: onTimeChange,
        ),
        UIHelper.verticalSpace(24.h),
        PersonalSetupChoiceSelector(
          title: 'Weekly Running Frequency',
          options: const ['1x', '2x', '3x', '4x', '5x+'],
          selectedOption: selectedFrequency,
          onSelect: onFreqChange,
        ),
        UIHelper.verticalSpace(24.h),
        PersonalSetupChoiceSelector(
          title: 'Current Injury or Limitation?',
          options: const ['Yes', 'No'],
          selectedOption: hasInjury,
          onSelect: onInjuryChange,
        ),
      ],
    );
  }
}
