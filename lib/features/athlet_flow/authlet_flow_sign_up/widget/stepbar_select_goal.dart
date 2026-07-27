
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';



class StepBarSelectGoal extends StatelessWidget {
  final VoidCallback onTap;
  final int currentStep;
  final int totalSteps;
  final Function(int) onStepTap;

  const StepBarSelectGoal({
    super.key,
    required this.currentStep,
    required this.onStepTap,
    required this.onTap,
    this.totalSteps = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () => onStepTap(index),
            child: Container(
              height: 8.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: ShapeDecoration(

                color: index <= currentStep ? AppColors.orangeColor : AppColors.c2F2F2F,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
