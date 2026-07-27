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

class DefineTargetScreen extends StatefulWidget {
  const DefineTargetScreen({super.key});

  @override
  State<DefineTargetScreen> createState() => _DefineTargetScreenState();
}

class _DefineTargetScreenState extends State<DefineTargetScreen> {
  // Triathlon target state
  int selectedFormatIndex = 0;
  final List<Map<String, String>> triathlonFormats = [
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

  // 5K Pace state
  int targetTime = 25;

  // Muscle Mass state
  String targetGain = '+4 kg';
  final List<String> gainOptions = ['+2 kg', '+4 kg', '+6 kg', '+8 kg'];

  // Endurance state
  String targetDistance = 'Half Marathon';
  final List<String> distanceOptions = ['10K', 'Half Marathon', 'Full Marathon', 'Ultra'];

  // Energy & Performance state
  String targetFocus = 'Energy Optimization';
  final List<String> focusOptions = ['Energy Optimization', 'Recovery Tracking', 'Peak Performance', 'Stress Management'];

  void _onNext() {
    String? goal = appData.read(kKeyAthleteSelectGoal);
    log("Define Target submitted for Goal: $goal");
    NavigationService.navigateTo(Routes.personalizedScreen);
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
                  'Define Your Target',
                  style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                    fontSize: 32.sp,
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  'Set a measurable outcome for your 12-week plan',
                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                ),
                UIHelper.verticalSpace(18.h),
                StepBarSelectGoal(
                  currentStep: 2,
                  totalSteps: 5,
                  onTap: () {},
                  onStepTap: (int index) {},
                ),
                UIHelper.verticalSpace(24.h),

                // DYNAMIC GOAL CONTENT
                if (isTriathlon) ...[
                  Column(
                    children: List.generate(triathlonFormats.length, (index) {
                      bool isSelected = selectedFormatIndex == index;
                      var format = triathlonFormats[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFormatIndex = index;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                          decoration: BoxDecoration(
                            color: AppColors.c181818,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isSelected ? AppColors.orangeColor : AppColors.c2F2F2F,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    format['title']!,
                                    style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                                      fontSize: 20.sp,
                                      color: isSelected ? AppColors.orangeColor : AppColors.cFFFFFF,
                                    ),
                                  ),
                                  Text(
                                    format['hours']!,
                                    style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpace(4.h),
                              Text(
                                format['desc']!,
                                style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                                  fontSize: 13.sp,
                                  color: AppColors.cA3A3A3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  UIHelper.verticalSpace(16.h),
                  // Note box for Triathlon
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: AppColors.c181818.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.c2F2F2F),
                    ),
                    child: Text(
                      'Your AI coach will structure swim, bike, and run sessions with brick workouts to prepare you for ${triathlonFormats[selectedFormatIndex]['name']}.',
                      style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.cA3A3A3,
                        height: 1.4,
                      ),
                    ),
                  ),
                ] else if (is5kPace) ...[
                  Text(
                    'Target time',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 16.sp),
                  ),
                  UIHelper.verticalSpace(16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
                            if (targetTime > 5) setState(() => targetTime--);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: AppColors.c2F2F2F,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(Icons.remove, color: AppColors.cFFFFFF, size: 20.sp),
                          ),
                        ),
                        Text(
                          '$targetTime min',
                          style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(fontSize: 32.sp),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => targetTime++),
                          child: Container(
                            padding: EdgeInsets.all(10.w),
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
                  UIHelper.verticalSpace(30.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: AppColors.c181818,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.c2F2F2F),
                    ),
                    child: Text(
                      'Your AI coach will structure interval training, tempo runs, and threshold sessions to reach your target time of $targetTime min.',
                      style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(fontSize: 13.sp),
                    ),
                  ),
                ] else if (isMuscle) ...[
                  Text('Target Weight Gain', style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 16.sp)),
                  UIHelper.verticalSpace(16.h),
                  Row(
                    children: gainOptions.map((opt) {
                      bool isSelected = targetGain == opt;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => targetGain = opt),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
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
                                style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                                  fontSize: 20.sp,
                                  color: isSelected ? AppColors.orangeColor : AppColors.cFFFFFF,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ] else if (isEndurance) ...[
                  Text('Target Event / Distance', style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 16.sp)),
                  UIHelper.verticalSpace(16.h),
                  Column(
                    children: distanceOptions.map((opt) {
                      bool isSelected = targetDistance == opt;
                      return GestureDetector(
                        onTap: () => setState(() => targetDistance = opt),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                          decoration: BoxDecoration(
                            color: AppColors.c181818,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isSelected ? AppColors.orangeColor : AppColors.c2F2F2F,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            opt,
                            style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                              fontSize: 20.sp,
                              color: isSelected ? AppColors.orangeColor : AppColors.cFFFFFF,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ] else ...[
                  Text('Primary Optimization Focus', style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 16.sp)),
                  UIHelper.verticalSpace(16.h),
                  Column(
                    children: focusOptions.map((opt) {
                      bool isSelected = targetFocus == opt;
                      return GestureDetector(
                        onTap: () => setState(() => targetFocus = opt),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                          decoration: BoxDecoration(
                            color: AppColors.c181818,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isSelected ? AppColors.orangeColor : AppColors.c2F2F2F,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            opt,
                            style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                              fontSize: 18.sp,
                              color: isSelected ? AppColors.orangeColor : AppColors.cFFFFFF,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],

                UIHelper.verticalSpace(40.h),
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
