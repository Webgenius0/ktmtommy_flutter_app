
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';



class StepBarSelectGoal extends StatelessWidget {
  final VoidCallback onTap;
  final int currentStep;
  final Function(int) onStepTap;

  const StepBarSelectGoal({
    super.key,
    required this.currentStep,
    required this.onStepTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (index) {
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
