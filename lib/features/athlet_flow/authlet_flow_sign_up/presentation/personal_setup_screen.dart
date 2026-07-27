import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/stepbar_select_goal.dart';
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
  // Common levels
  final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

  // Triathlon state
  String swimLevel = 'Beginner';
  String bikeLevel = 'Beginner';
  String runLevel = 'Beginner';
  double weeklyAvailability = 11.0;
  String previousRaceExperience = 'Yes';

  // 5K Pace state
  String runningExperience = 'Beginner';
  int current5kTime = 28;
  String selectedFrequency = '3x';
  String hasInjury = 'No';

  // Muscle Mass state
  String liftingExperience = 'Beginner';
  int currentWeight = 70;
  String gymFrequency = '4x';
  String equipmentAccess = 'Full Gym';

  // Endurance state
  String enduranceLevel = 'Beginner';
  String primaryActivity = 'Running';
  double enduranceHours = 8.0;

  // Energy & Performance state
  String energyLevel = 'Moderate';
  String sleepQuality = 'Average';
  String stressLevel = 'Moderate';

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
                ArrowButtonAtheleteFlow(
                  onTap: () {
                    NavigationService.goBack();
                  },
                ),
                UIHelper.verticalSpace(12.h),
                Text(
                  'Personal Setup',
                  style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                    fontSize: 32.sp,
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  'Tell us about yourself so we can personalise your plan',
                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                ),
                UIHelper.verticalSpace(18.h),
                StepBarSelectGoal(
                  currentStep: 1,
                  totalSteps: 5,
                  onTap: () {},
                  onStepTap: (int index) {},
                ),
                UIHelper.verticalSpace(24.h),

                // DYNAMIC GOAL UI CONTENT
                if (isTriathlon) ...[
                  _buildLevelSelector('Swimming Level', Icons.pool, swimLevel, (val) {
                    setState(() => swimLevel = val);
                  }),
                  UIHelper.verticalSpace(20.h),
                  _buildLevelSelector('Cycling Level', Icons.directions_bike, bikeLevel, (val) {
                    setState(() => bikeLevel = val);
                  }),
                  UIHelper.verticalSpace(20.h),
                  _buildLevelSelector('Running Level', Icons.directions_run, runLevel, (val) {
                    setState(() => runLevel = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  // Weekly Training Availability Slider
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
                      onChanged: (val) {
                        setState(() {
                          weeklyAvailability = val;
                        });
                      },
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
                  _buildChoiceSelector('Previous Race Experience?', ['Yes', 'No'], previousRaceExperience, (val) {
                    setState(() => previousRaceExperience = val);
                  }),
                ] else if (is5kPace) ...[
                  _buildLevelSelector('Running Experience', Icons.directions_run, runningExperience, (val) {
                    setState(() => runningExperience = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  _buildCounterWidget('Current 5K Time', current5kTime, 'min', (val) {
                    setState(() => current5kTime = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  _buildOptionBoxes('Weekly Running Frequency', ['1x', '2x', '3x', '4x', '5x+'], selectedFrequency, (val) {
                    setState(() => selectedFrequency = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  _buildChoiceSelector('Current Injury or Limitation?', ['Yes', 'No'], hasInjury, (val) {
                    setState(() => hasInjury = val);
                  }),
                ] else if (isMuscle) ...[
                  _buildLevelSelector('Lifting Experience', Icons.fitness_center, liftingExperience, (val) {
                    setState(() => liftingExperience = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  _buildCounterWidget('Current Body Weight', currentWeight, 'kg', (val) {
                    setState(() => currentWeight = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  _buildOptionBoxes('Weekly Gym Frequency', ['2x', '3x', '4x', '5x', '6x'], gymFrequency, (val) {
                    setState(() => gymFrequency = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  _buildOptionBoxes('Equipment Access?', ['Full Gym', 'Home Gym', 'Bodyweight'], equipmentAccess, (val) {
                    setState(() => equipmentAccess = val);
                  }),
                ] else if (isEndurance) ...[
                  _buildLevelSelector('Endurance Level', Icons.directions_run, enduranceLevel, (val) {
                    setState(() => enduranceLevel = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  _buildOptionBoxes('Primary Activity', ['Running', 'Cycling', 'Swimming', 'Multi-Sport'], primaryActivity, (val) {
                    setState(() => primaryActivity = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  Text(
                    'Weekly Training Hours: ${enduranceHours.toInt()}h',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 16.sp),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Slider(
                    value: enduranceHours,
                    min: 3,
                    max: 15,
                    activeColor: AppColors.orangeColor,
                    inactiveColor: AppColors.c2F2F2F,
                    onChanged: (val) => setState(() => enduranceHours = val),
                  ),
                ] else ...[
                  _buildOptionBoxes('Current Energy Level', ['Low', 'Moderate', 'High'], energyLevel, (val) {
                    setState(() => energyLevel = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  _buildOptionBoxes('Sleep Quality', ['Poor', 'Average', 'Great'], sleepQuality, (val) {
                    setState(() => sleepQuality = val);
                  }),
                  UIHelper.verticalSpace(24.h),
                  _buildOptionBoxes('Daily Stress Level', ['Low', 'Moderate', 'High'], stressLevel, (val) {
                    setState(() => stressLevel = val);
                  }),
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

  Widget _buildLevelSelector(String title, IconData icon, String selectedVal, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.orangeColor, size: 18.sp),
            UIHelper.horizontalSpace(6.w),
            Text(
              title,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        UIHelper.verticalSpace(10.h),
        Row(
          children: levels.map((lvl) {
            bool isSelected = selectedVal == lvl;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(lvl),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? AppColors.orangeColor : AppColors.c2F2F2F,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      lvl,
                      style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                        fontSize: 13.sp,
                        color: isSelected ? AppColors.orangeColor : AppColors.cFFFFFF,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCounterWidget(String title, int value, String unit, Function(int) onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 16.sp),
        ),
        UIHelper.verticalSpace(10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.c181818,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.c2F2F2F),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (value > 1) onChange(value - 1);
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.c2F2F2F,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.remove, color: AppColors.cFFFFFF, size: 20.sp),
                ),
              ),
              Text(
                '$value $unit',
                style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(fontSize: 28.sp),
              ),
              GestureDetector(
                onTap: () => onChange(value + 1),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.c2F2F2F,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.add, color: AppColors.cFFFFFF, size: 20.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionBoxes(String title, List<String> options, String selectedVal, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 16.sp),
        ),
        UIHelper.verticalSpace(10.h),
        Row(
          children: options.map((opt) {
            bool isSelected = selectedVal == opt;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(opt),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected ? AppColors.orangeColor : AppColors.c2F2F2F,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      opt,
                      textAlign: TextAlign.center,
                      style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                        fontSize: 12.sp,
                        color: isSelected ? AppColors.orangeColor : AppColors.cFFFFFF,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildChoiceSelector(String title, List<String> choices, String selectedVal, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 16.sp),
        ),
        UIHelper.verticalSpace(10.h),
        Row(
          children: choices.map((c) {
            bool isSelected = selectedVal == c;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(c),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected ? AppColors.orangeColor : AppColors.c2F2F2F,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      c,
                      style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                        fontSize: 14.sp,
                        color: isSelected ? AppColors.orangeColor : AppColors.cFFFFFF,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
