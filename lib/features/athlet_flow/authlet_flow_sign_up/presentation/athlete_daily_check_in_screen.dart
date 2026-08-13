import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AthleteDailyCheckInScreen extends StatefulWidget {
  const AthleteDailyCheckInScreen({super.key});

  @override
  State<AthleteDailyCheckInScreen> createState() =>
      _AthleteDailyCheckInScreenState();
}

class _AthleteDailyCheckInScreenState
    extends State<AthleteDailyCheckInScreen> {
  String selectedSleep = 'Excellent';
  String selectedEnergy = 'High';
  String selectedRecovery = 'Fully Recovered';
  String selectedFeeling = 'Fully Recovered';

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArrowButtonAtheleteFlow(
                  onTap: () => NavigationService.goBack(),
                ),
                UIHelper.verticalSpace(16.h),
                Text(
                  'How are your feeling today?',
                  style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                    fontSize: 28.sp,
                    height: 1.1,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                Text(
                  "Please Complete today's check in to generate today's plan",
                  style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                    fontSize: 13.sp,
                    color: const Color(0xFFA0A0A0),
                  ),
                ),
                UIHelper.verticalSpace(24.h),

                // Question 1: Sleep
                _buildQuestionSection(
                  title: '🥱 How was your sleep last night?',
                  options: ['Excellent', 'Good', 'Average'],
                  selectedValue: selectedSleep,
                  onSelect: (val) => setState(() => selectedSleep = val),
                ),
                UIHelper.verticalSpace(20.h),

                // Question 2: Energy
                _buildQuestionSection(
                  title: '⚡ How is your energy today?',
                  options: ['High', 'Medium', 'Low'],
                  selectedValue: selectedEnergy,
                  onSelect: (val) => setState(() => selectedEnergy = val),
                ),
                UIHelper.verticalSpace(20.h),

                // Question 3: Recovery
                _buildQuestionSection(
                  title: '💪 How recovered do you feel?',
                  options: ['Fully Recovered', 'Slightly Sore', 'Sore'],
                  selectedValue: selectedRecovery,
                  onSelect: (val) => setState(() => selectedRecovery = val),
                ),
                UIHelper.verticalSpace(20.h),

                // Question 4: Feeling
                _buildQuestionSection(
                  title: 'How are you feeling today?',
                  options: ['Fully Recovered', 'Slightly Sore', 'Sore'],
                  selectedValue: selectedFeeling,
                  onSelect: (val) => setState(() => selectedFeeling = val),
                ),
                UIHelper.verticalSpace(36.h),

                // Generate Plan button
                CustomButtonWidget(
                  onTap: () {
                    NavigationService.navigateTo(Routes.athletBuildingPlanScreen);
                  },
                  textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                  image: DecorationImage(
                    image: AssetImage(AppImages.orangebutton),
                  ),
                  text: "Generate today's Plan ✨",
                ),
                UIHelper.verticalSpace(24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionSection({
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        UIHelper.verticalSpace(12.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: options.map((option) {
            final isSelected = selectedValue == option;
            return GestureDetector(
              onTap: () => onSelect(option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.c181818,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.orangeColor
                        : const Color(0xFF2F2F2F),
                    width: isSelected ? 1.5 : 1.0,
                  ),
                ),
                child: Text(
                  option,
                  style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                    fontSize: 14.sp,
                    color: isSelected ? Colors.white : const Color(0xFFB0B0B0),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
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
