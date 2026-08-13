import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/stepbar_select_goal.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class CustomAthleteAppBar extends StatelessWidget {
  final VoidCallback? onBackTap;
  final String title;
  final String? subtitle;
  final int currentStep;
  final int totalSteps;
  final bool showStepBar;

  const CustomAthleteAppBar({
    super.key,
    this.onBackTap,
    required this.title,
    this.subtitle,
    required this.currentStep,
    this.totalSteps = 4,
    this.showStepBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onBackTap ?? () => NavigationService.goBack(),
          child: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: SvgPicture.asset(
              AppIcons.arrwButton,
            ),
          ),
        ),
        UIHelper.horizontalSpace(14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                  fontSize: 32.sp,
                  height: 1.0,
                ),
              ),
              if (subtitle != null) ...[
                UIHelper.verticalSpace(4.h),
                Text(
                  subtitle!,
                  style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                    fontSize: 14.sp,
                    height: 1.3,
                  ),
                ),
              ],
              if (showStepBar) ...[
                UIHelper.verticalSpace(14.h),
                StepBarSelectGoal(
                  currentStep: currentStep,
                  totalSteps: totalSteps,
                  onTap: () {},
                  onStepTap: (int index) {},
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
