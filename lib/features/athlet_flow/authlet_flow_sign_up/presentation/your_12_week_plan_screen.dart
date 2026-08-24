import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/model/generate_macro_plan_model.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/plan_summary_widgets.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class Your12WeekPlanScreen extends StatefulWidget {
  final bool isFromProgress;

  const Your12WeekPlanScreen({
    super.key,
    this.isFromProgress = false,
  });

  @override
  State<Your12WeekPlanScreen> createState() => _Your12WeekPlanScreenState();
}

class _Your12WeekPlanScreenState extends State<Your12WeekPlanScreen> {
  @override
  void initState() {
    super.initState();
    generateMacroPlanRxObj.fetchGenerateMacroPlan();
  }

  @override
  Widget build(BuildContext context) {
    String selectedGoal = appData.read(kKeyAthleteSelectGoal) ?? 'COMPLETE_TRIATHLON';
    String reminderTime = appData.read(kKeyAthleteDailyReminder) ?? '6-10 AM';
    Map<String, dynamic> setupData = Map<String, dynamic>.from(appData.read('athleteSetupData') ?? {});
    Map<String, dynamic> targetData = Map<String, dynamic>.from(appData.read('athleteTargetData') ?? {});

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
          child: StreamBuilder<GenerateMacroPlanModel>(
            stream: generateMacroPlanRxObj.getMacroPlanStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.orangeColor),
                );
              }

              GenerateMacroPlanModel? planModel = snapshot.data;
              int totalWeeks = planModel?.data?.totalWeeks ?? 12;

              String goalTitle = 'Complete Triathlon';
              if (is5kPace) {
                goalTitle = 'Improve 5K Pace';
              } else if (isMuscle) {
                goalTitle = 'Build Muscle Mass';
              } else if (isEndurance) {
                goalTitle = 'Improve Endurance';
              } else if (!isTriathlon) {
                goalTitle = 'Monitor Energy';
              }

              String screenTitle = 'Your $totalWeeks-Week $goalTitle Plan';

              List<Map<String, String>> stats = _getStats(
                isTriathlon,
                is5kPace,
                isMuscle,
                isEndurance,
                reminderTime,
                setupData,
                targetData,
                totalWeeks,
              );

              List<Map<String, String>> phases = [];
              if (planModel?.data?.phases != null && planModel!.data!.phases!.isNotEmpty) {
                phases = planModel.data!.phases!.map((p) {
                  String w = p.weeks ?? '';
                  if (!w.toLowerCase().contains('wk') && !w.toLowerCase().contains('wks')) {
                    w = 'Wks $w';
                  }
                  return {
                    'title': p.name ?? '',
                    'weeks': w,
                    'sub': p.description ?? '',
                  };
                }).toList();
              } else {
                phases = _getFallbackPhases(isTriathlon, is5kPace, isMuscle, isEndurance);
              }

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ArrowButtonAtheleteFlow(
                      onTap: () => NavigationService.goBack,
                    ),
                    UIHelper.verticalSpace(12.h),
                    Text(
                      screenTitle,
                      style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                        fontSize: 28.sp,
                        height: 1.1,
                      ),
                    ),
                    UIHelper.verticalSpace(12.h),
                    const PlanAiBadgeWidget(),
                    UIHelper.verticalSpace(20.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.c181818,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.c2F2F2F),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: PlanMetricTileWidget(
                                  label: stats[0]['label']!,
                                  val: stats[0]['val']!,
                                  isHighlight: stats[0]['highlight'] == 'true',
                                ),
                              ),
                              UIHelper.horizontalSpace(12.w),
                              Expanded(
                                child: PlanMetricTileWidget(
                                  label: stats[1]['label']!,
                                  val: stats[1]['val']!,
                                  isHighlight: stats[1]['highlight'] == 'true',
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(12.h),
                          Row(
                            children: [
                              Expanded(
                                child: PlanMetricTileWidget(
                                  label: stats[2]['label']!,
                                  val: stats[2]['val']!,
                                  isHighlight: stats[2]['highlight'] == 'true',
                                ),
                              ),
                              UIHelper.horizontalSpace(12.w),
                              Expanded(
                                child: PlanMetricTileWidget(
                                  label: stats[3]['label']!,
                                  val: stats[3]['val']!,
                                  isHighlight: stats[3]['highlight'] == 'true',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(24.h),
                    PlanTrainingPhasesWidget(phases: phases),
                    UIHelper.verticalSpace(20.h),
                    const PlanWhatsIncludedWidget(),
                    UIHelper.verticalSpace(28.h),
                    CustomButtonWidget(
                      onTap: () {
                        if (widget.isFromProgress) {
                          _showResetGoalDialog(context);
                        } else {
                          _showYourPlanAwaitsDialog(context);
                        }
                      },
                      textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                      image: DecorationImage(
                        image: AssetImage(AppImages.orangebutton),
                      ),
                      text: widget.isFromProgress ? 'Reset My Goal' : 'Start My Plan',
                    ),
                    UIHelper.verticalSpace(24.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showYourPlanAwaitsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFF2B2B2B), width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white38, width: 1),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                const BotIconWidget(),
                UIHelper.verticalSpace(16.h),
                Text(
                  'Your Plan Awaits',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                UIHelper.verticalSpace(14.h),
                Text(
                  "Before we generate today's recommendations, we'd like to understand your current energy, recovery, and readiness.",
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                    fontSize: 13.sp,
                    color: const Color(0xFFA0A0A0),
                    height: 1.4,
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                Text(
                  "This helps us create a smarter plan tailored to today's needs.",
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                    fontSize: 13.sp,
                    color: const Color(0xFFA0A0A0),
                    height: 1.4,
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                CustomButtonWidget(
                  onTap: () {
                    Navigator.of(context).pop();
                    NavigationService.navigateTo(Routes.athletDailyCheckInScreen);
                  },
                  textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                  image: DecorationImage(
                    image: AssetImage(AppImages.orangebutton),
                  ),
                  text: "Complete today's check-in",
                ),
                UIHelper.verticalSpace(12.h),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    NavigationService.navigateToReplacement(
                        Routes.athletBottomNavigationBar);
                  },
                  borderRadius: BorderRadius.circular(24.r),
                  child: Container(
                    width: double.infinity,
                    height: 48.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
                    ),
                    child: Text(
                      'Skip for Now',
                      style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showResetGoalDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFF2B2B2B), width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white38, width: 1),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  'Reset Goal',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                UIHelper.verticalSpace(14.h),
                Text(
                  'Are you sure want to reset your goal? All of your current progress and will be lost and you will have to begin again.',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                    fontSize: 13.sp,
                    color: const Color(0xFFA0A0A0),
                    height: 1.4,
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(24.r),
                        child: Container(
                          height: 48.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: const Color(0xFF2F2F2F),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    UIHelper.horizontalSpace(12.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          NavigationService.navigateToReplacement(
                              Routes.selectGoalScreen);
                        },
                        borderRadius: BorderRadius.circular(24.r),
                        child: Container(
                          height: 48.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.orangeColor,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Text(
                            'Confirm',
                            style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Map<String, String>> _getStats(
    bool isTriathlon,
    bool is5kPace,
    bool isMuscle,
    bool isEndurance,
    String reminderTime,
    Map<String, dynamic> setupData,
    Map<String, dynamic> targetData,
    int totalWeeks,
  ) {
    if (isTriathlon) {
      String format = targetData['target_type'] ?? 'Sprint';
      return [
        {'label': 'Goal', 'val': 'Complete Triathlon', 'highlight': 'true'},
        {'label': 'Race format', 'val': format, 'highlight': 'false'},
        {'label': 'Reminder Time', 'val': reminderTime.contains('Morning') ? '6-10 AM' : reminderTime, 'highlight': 'false'},
        {'label': 'Duration', 'val': '$totalWeeks Weeks', 'highlight': 'false'},
      ];
    } else if (is5kPace) {
      String curr5k = setupData['current_5k_time_minutes'] != null ? '${setupData['current_5k_time_minutes']} min' : '28 min';
      String target5k = targetData['target_time_minutes'] != null ? '${targetData['target_time_minutes']} min' : '25 min';
      return [
        {'label': 'Goal', 'val': 'Improve 5K Pace', 'highlight': 'true'},
        {'label': 'Current 5K', 'val': curr5k, 'highlight': 'false'},
        {'label': 'Target 5K', 'val': target5k, 'highlight': 'false'},
        {'label': 'Duration', 'val': '$totalWeeks Weeks', 'highlight': 'false'},
      ];
    } else if (isMuscle) {
      String days = setupData['weekly_training_days'] != null ? '${setupData['weekly_training_days']} days/wk' : '3 days/wk';
      String targetW = targetData['target_weight'] != null ? '${targetData['target_weight']} kg' : '80 kg';
      return [
        {'label': 'Goal', 'val': 'Build Muscle Mass', 'highlight': 'true'},
        {'label': 'Training Days', 'val': days, 'highlight': 'false'},
        {'label': 'Target Weight', 'val': targetW, 'highlight': 'false'},
        {'label': 'Duration', 'val': '$totalWeeks Weeks', 'highlight': 'false'},
      ];
    } else if (isEndurance) {
      String currCardio = setupData['longest_cardio_duration_minutes'] != null ? '${setupData['longest_cardio_duration_minutes']} min' : '30 min';
      String targetSession = targetData['target_longest_session_minutes'] != null ? '${targetData['target_longest_session_minutes']} min' : '45 min';
      return [
        {'label': 'Goal', 'val': 'Improve Endurance', 'highlight': 'true'},
        {'label': 'Longest Session', 'val': currCardio, 'highlight': 'false'},
        {'label': 'Target Duration', 'val': targetSession, 'highlight': 'false'},
        {'label': 'Duration', 'val': '$totalWeeks Weeks', 'highlight': 'false'},
      ];
    } else {
      String sleep = setupData['average_sleep_hours'] != null ? '${setupData['average_sleep_hours']} hrs' : '6 hrs';
      String targetScore = targetData['daily_energy_score_target'] != null ? '${targetData['daily_energy_score_target']} pts' : '80 pts';
      return [
        {'label': 'Goal', 'val': 'Monitor Energy', 'highlight': 'true'},
        {'label': 'Sleep', 'val': sleep, 'highlight': 'false'},
        {'label': 'Target Score', 'val': targetScore, 'highlight': 'false'},
        {'label': 'Duration', 'val': '$totalWeeks Weeks', 'highlight': 'false'},
      ];
    }
  }

  List<Map<String, String>> _getFallbackPhases(bool isTriathlon, bool is5kPace, bool isMuscle, bool isEndurance) {
    if (isTriathlon) {
      return [
        {'title': 'Individual Discipline', 'weeks': 'Wks 1-4', 'sub': 'Swim, bike, and run base separately'},
        {'title': 'Brick Sessions', 'weeks': 'Wks 5-8', 'sub': 'Combined discipline training'},
        {'title': 'Race Simulation', 'weeks': 'Wks 9-11', 'sub': 'Full race-pace rehearsals'},
        {'title': 'Taper & Race Prep', 'weeks': 'Wk 12', 'sub': 'Reduce load, sharpen fitness'},
      ];
    } else if (is5kPace) {
      return [
        {'title': 'Base Building', 'weeks': 'Wks 1-4', 'sub': 'Easy runs, form drills, aerobic base'},
        {'title': 'Speed Development', 'weeks': 'Wks 5-8', 'sub': 'Interval training & tempo runs'},
        {'title': 'Race Preparation', 'weeks': 'Wks 9-11', 'sub': 'Race-pace sessions, threshold work'},
        {'title': 'Taper & Peak', 'weeks': 'Wk 12', 'sub': 'Reduce volume, peak performance'},
      ];
    } else if (isMuscle) {
      return [
        {'title': 'Foundational Strength', 'weeks': 'Wks 1-3', 'sub': 'Movement patterns, form, activation'},
        {'title': 'Hypertrophy Phase', 'weeks': 'Wks 5-8', 'sub': 'High volume, compound + Isolation'},
        {'title': 'Progressive Overload', 'weeks': 'Wks 9-11', 'sub': 'Increase intensity, strength peaks'},
        {'title': 'Deload & Assess', 'weeks': 'Wk 12', 'sub': 'Recovery + progress measurement'},
      ];
    } else if (isEndurance) {
      return [
        {'title': 'Aerobic Foundation', 'weeks': 'Wks 1-3', 'sub': 'Low-Intensity base, zone 2 cardio'},
        {'title': 'Volume Build', 'weeks': 'Wks 5-8', 'sub': 'Longer sessions, progressive load'},
        {'title': 'Threshold Training', 'weeks': 'Wks 9-11', 'sub': 'Tempo, lactate threshold sessions'},
        {'title': 'Peak & Test', 'weeks': 'Wk 12', 'sub': 'Target duration attempt + recovery'},
      ];
    } else {
      return [
        {'title': 'Habit Foundation', 'weeks': 'Wks 1-3', 'sub': 'Sleep hygiene, stress awareness, baseline'},
        {'title': 'Lifestyle Optimise', 'weeks': 'Wks 5-8', 'sub': 'Nutrition timing, movement habits'},
        {'title': 'Recovery Mastery', 'weeks': 'Wks 9-11', 'sub': 'HRV tracking, recovery protocols'},
        {'title': 'Performance Mode', 'weeks': 'Wk 12', 'sub': 'Full system audit & benchmarking'},
      ];
    }
  }
}

class BotIconWidget extends StatelessWidget {
  const BotIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70.w,
      height: 70.w,
      child: CustomPaint(
        painter: BotIconPainter(),
      ),
    );
  }
}

class BotIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final orangePaint = Paint()
      ..color = const Color(0xFFF55216)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillOrangePaint = Paint()
      ..color = const Color(0xFFF55216)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(Offset(center.dx, 10), 4.0, fillOrangePaint);
    canvas.drawLine(Offset(center.dx, 14), Offset(center.dx, 22), orangePaint);

    final headRect = Rect.fromLTWH(center.dx - 22, 22, 44, 34);
    final headRRect =
        RRect.fromRectAndRadius(headRect, const Radius.circular(10));
    canvas.drawRRect(headRRect, orangePaint);

    final leftEar = RRect.fromRectAndRadius(
      Rect.fromLTWH(center.dx - 27, 32, 5, 14),
      const Radius.circular(2),
    );
    final rightEar = RRect.fromRectAndRadius(
      Rect.fromLTWH(center.dx + 22, 32, 5, 14),
      const Radius.circular(2),
    );
    canvas.drawRRect(leftEar, orangePaint);
    canvas.drawRRect(rightEar, orangePaint);

    final leftEye = RRect.fromRectAndRadius(
      Rect.fromLTWH(center.dx - 12, 32, 7, 7),
      const Radius.circular(2),
    );
    final rightEye = RRect.fromRectAndRadius(
      Rect.fromLTWH(center.dx + 5, 32, 7, 7),
      const Radius.circular(2),
    );
    canvas.drawRRect(leftEye, fillOrangePaint);
    canvas.drawRRect(rightEye, fillOrangePaint);

    final mouthPath = Path();
    mouthPath.addArc(
      Rect.fromLTWH(center.dx - 10, 38, 20, 10),
      0.2,
      2.74,
    );
    canvas.drawPath(mouthPath, orangePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
