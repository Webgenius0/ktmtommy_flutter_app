import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_height.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_with.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/personal_setup_helpers.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/personalized_gender_reminder_widgets.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class PersonalSetupMuscleSection extends StatelessWidget {
  final String liftingExperience;
  final bool hasGymAccess;
  final int weeklyDays;
  final Function(String) onExpChange;
  final Function(bool) onGymChange;
  final Function(int) onDaysChange;

  const PersonalSetupMuscleSection({
    super.key,
    required this.liftingExperience,
    required this.hasGymAccess,
    required this.weeklyDays,
    required this.onExpChange,
    required this.onGymChange,
    required this.onDaysChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
