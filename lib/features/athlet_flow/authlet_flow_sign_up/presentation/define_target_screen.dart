import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_athlete_app_bar.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/define_target_widgets.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class DefineTargetScreen extends StatefulWidget {
  const DefineTargetScreen({super.key});

  @override
  State<DefineTargetScreen> createState() => _DefineTargetScreenState();
}

class _DefineTargetScreenState extends State<DefineTargetScreen> {
  int selectedFormatIndex = 0;
  final List<Map<String, String>> triathlonFormats = const [
    {
      'title': '⚡ SPRINT',
      'hours': '~1-2 hrs/day',
      'desc': '750m swim • 20km bike • 5km run',
      'name': 'Sprint',
    },
    {
      'title': '🥇 OLYMPIC',
      'hours': '~2-3 hrs/day',
      'desc': '1.5km swim • 40km bike • 10km run',
      'name': 'Olympic',
    },
    {
      'title': '💪 HALF IRONMAN',
      'hours': '~4-7 hrs/day',
      'desc': '1.9km swim • 90km bike • 21km run',
      'name': 'Half Ironman',
    },
    {
      'title': '🔥 FULL IRONMAN',
      'hours': '~8-17 hrs/day',
      'desc': '3.8km swim • 180km bike • 42km run',
      'name': 'Full Ironman',
    },
  ];

  int target5kTime = 25;
  int targetWeight = 80;
  int targetLongestSession = 45;
  int targetEnergyScore = 80;

  void _onNext() {
    String selectedGoal = appData.read(kKeyAthleteSelectGoal) ?? 'COMPLETE_TRIATHLON';
    bool isTriathlon = selectedGoal == 'COMPLETE_TRIATHLON' || selectedGoal.toUpperCase().contains('TRIATHLON');
    bool is5kPace = selectedGoal == 'IMPROVE_5K_PACE' || selectedGoal.toUpperCase().contains('5K');
    bool isMuscle = selectedGoal == 'BUILD_MUSCLE_MASS' || selectedGoal.toUpperCase().contains('MUSCLE');
    bool isEndurance = selectedGoal == 'IMPROVE_ENDURANCE' || selectedGoal.toUpperCase().contains('ENDURANCE');

    Map<String, dynamic> targetData = {};

    if (isTriathlon) {
      String formatName = triathlonFormats[selectedFormatIndex]['name'] ?? 'Sprint';
      String targetType = 'SPRINT';
      if (formatName.toUpperCase().contains('OLYMPIC')) {
        targetType = 'OLYMPIC';
      } else if (formatName.toUpperCase().contains('HALF')) {
        targetType = 'HALF_IRONMAN';
      } else if (formatName.toUpperCase().contains('FULL')) {
        targetType = 'FULL_IRONMAN';
      }
      targetData = {
        "target_type": targetType,
      };
    } else if (is5kPace) {
      targetData = {
        "target_time_minutes": target5kTime,
      };
    } else if (isMuscle) {
      targetData = {
        "target_weight": targetWeight,
      };
    } else if (isEndurance) {
      targetData = {
        "target_longest_session_minutes": targetLongestSession,
      };
    } else {
      targetData = {
        "daily_energy_score_target": targetEnergyScore,
      };
    }

    appData.write('athleteTargetData', targetData);
    log("Define Target submitted for Goal: $selectedGoal with target_data: $targetData");
    NavigationService.navigateTo(Routes.personalizedScreen);
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
                  title: 'Define Your Target',
                  subtitle: 'Set a measurable outcome for your 12-week plan',
                  currentStep: 2,
                  totalSteps: 4,
                ),
                UIHelper.verticalSpace(24.h),
                if (isTriathlon) ...[
                  DefineTargetTriathlonWidget(
                    selectedFormatIndex: selectedFormatIndex,
                    onSelectFormat: (idx) => setState(() => selectedFormatIndex = idx),
                    formats: triathlonFormats,
                  ),
                ] else if (is5kPace) ...[
                  DefineTargetCounterWidget(
                    title: 'Target time',
                    value: target5kTime,
                    unit: 'min',
                    onChange: (val) => setState(() => target5kTime = val),
                  ),
                ] else if (isMuscle) ...[
                  DefineTargetCounterWidget(
                    title: 'Target Weight',
                    value: targetWeight,
                    unit: 'kg',
                    subtitle: 'Target Weight: ${targetWeight} kg (current: 75 kg)',
                    onChange: (val) => setState(() => targetWeight = val),
                  ),
                ] else if (isEndurance) ...[
                  DefineTargetCounterWidget(
                    title: 'Target longest session',
                    value: targetLongestSession,
                    unit: 'min',
                    subtitle: 'Target longest session: ${targetLongestSession}min (current: 30 min)',
                    onChange: (val) => setState(() => targetLongestSession = val),
                  ),
                ] else ...[
                  DefineTargetCounterWidget(
                    title: 'Daily Energy Score Target',
                    value: targetEnergyScore,
                    unit: 'pts',
                    subtitle: 'Target Score: ${targetEnergyScore} pts(current: 50 pts)',
                    onChange: (val) => setState(() => targetEnergyScore = val),
                  ),
                ],
                UIHelper.verticalSpace(36.h),
                CustomButtonWidget(
                  onTap: _onNext,
                  textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                  image: DecorationImage(
                    image: AssetImage(AppImages.orangebutton),
                  ),
                  text: 'Next',
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
