import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class PersonalSetupLevelSelector extends StatelessWidget {
  final String title;
  final IconData icon;
  final String selectedLevel;
  final Function(String) onSelect;
  final List<String> levels;

  const PersonalSetupLevelSelector({
    super.key,
    required this.title,
    required this.icon,
    required this.selectedLevel,
    required this.onSelect,
    this.levels = const ['Beginner', 'Intermediate', 'Advanced'],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.orangeColor, size: 18.sp),
            UIHelper.horizontalSpace(8.w),
            Text(
              title,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        UIHelper.verticalSpace(10.h),
        Row(
          children: levels.map((level) {
            bool isSelected = selectedLevel == level;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(level),
                child: Container(
                  margin: EdgeInsets.only(right: level == levels.last ? 0 : 8.w),
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
                      level,
                      style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                        fontSize: 12.sp,
                        color: isSelected ? AppColors.cFFFFFF : AppColors.cA3A3A3,
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

class PersonalSetupChoiceSelector extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final Function(String) onSelect;

  const PersonalSetupChoiceSelector({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(10.h),
        Row(
          children: options.map((opt) {
            bool isSelected = selectedOption == opt;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(opt),
                child: Container(
                  margin: EdgeInsets.only(right: opt == options.last ? 0 : 12.w),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected ? AppColors.orangeColor : AppColors.c2F2F2F,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      opt,
                      style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                        fontSize: 14.sp,
                        color: isSelected ? AppColors.cFFFFFF : AppColors.cA3A3A3,
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

class PersonalSetupCounterWidget extends StatelessWidget {
  final String title;
  final int value;
  final String unit;
  final bool formatTwoDigits;
  final Function(int) onChange;

  const PersonalSetupCounterWidget({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    this.formatTwoDigits = false,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    String displayValue = formatTwoDigits ? value.toString().padLeft(2, '0') : '$value';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.c181818,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.c2F2F2F),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => onChange(value > 1 ? value - 1 : 1),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: AppColors.c2F2F2F,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.remove, color: AppColors.cFFFFFF, size: 18.sp),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$displayValue ',
                      style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                        fontSize: 28.sp,
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                    TextSpan(
                      text: unit,
                      style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onChange(value + 1),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: AppColors.c2F2F2F,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.add, color: AppColors.cFFFFFF, size: 18.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
