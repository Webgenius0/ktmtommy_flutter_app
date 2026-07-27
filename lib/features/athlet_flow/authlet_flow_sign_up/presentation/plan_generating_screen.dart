import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/stepbar_select_goal.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class PlanGeneratingScreen extends StatefulWidget {
  const PlanGeneratingScreen({super.key});

  @override
  State<PlanGeneratingScreen> createState() => _PlanGeneratingScreenState();
}

class _PlanGeneratingScreenState extends State<PlanGeneratingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<String> _processSteps = [
    'Analysing your fitness profile',
    'Calculating optimal training load',
    'Structuring 12-week periodisation',
    'Personalising daily tasks',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            NavigationService.navigateTo(Routes.your12WeekPlanScreen);
          }
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int percentage = (_animation.value * 100).toInt();

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
                  'Plan Generating',
                  style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                    fontSize: 32.sp,
                  ),
                ),
                UIHelper.verticalSpace(18.h),
                StepBarSelectGoal(
                  currentStep: 4,
                  totalSteps: 5,
                  onTap: () {},
                  onStepTap: (int index) {},
                ),
                UIHelper.verticalSpace(50.h),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 140.w,
                        height: 140.w,
                        child: CircularProgressIndicator(
                          value: _animation.value,
                          strokeWidth: 10.w,
                          backgroundColor: AppColors.c2F2F2F,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.orangeColor,
                          ),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Text(
                        '$percentage%',
                        style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(40.h),
                Center(
                  child: Text(
                    'AI is building your plan...',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(28.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: List.generate(_processSteps.length, (index) {
                      double stepThreshold = (index + 1) / _processSteps.length;
                      bool isCompleted = _animation.value >= stepThreshold;

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? AppColors.c87B842
                                    : AppColors.c757575,
                                shape: BoxShape.circle,
                              ),
                            ),
                            UIHelper.horizontalSpace(12.w),
                            Expanded(
                              child: Text(
                                _processSteps[index],
                                style: TextFontStyle.textStyle14w400cE8E8E8poppins
                                    .copyWith(
                                  fontSize: 15.sp,
                                  color: isCompleted
                                      ? AppColors.cFFFFFF
                                      : AppColors.cA3A3A3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
