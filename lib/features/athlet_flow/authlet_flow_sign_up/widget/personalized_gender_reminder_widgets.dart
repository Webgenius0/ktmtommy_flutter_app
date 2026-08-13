import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_time.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/select_unselect_gender.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class PersonalizedGenderSelector extends StatelessWidget {
  final String selectedGender;
  final Function(String) onSelectGender;

  const PersonalizedGenderSelector({
    super.key,
    required this.selectedGender,
    required this.onSelectGender,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Gender',
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(12.h),
        Row(
          children: [
            Expanded(
              child: SelectUnselectGender(
                text: 'Male',
                isSelected: selectedGender == 'male',
                onTap: () => onSelectGender('male'),
              ),
            ),
            UIHelper.horizontalSpace(15.w),
            Expanded(
              child: SelectUnselectGender(
                text: 'Female',
                isSelected: selectedGender == 'female',
                onTap: () => onSelectGender('female'),
              ),
            ),
            UIHelper.horizontalSpace(15.w),
            Expanded(
              child: SelectUnselectGender(
                text: 'Other',
                isSelected: selectedGender == 'other',
                onTap: () => onSelectGender('other'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PersonalizedReminderSelector extends StatelessWidget {
  final String? selectedTime;
  final String? timeError;
  final Function(String) onSelectTime;

  const PersonalizedReminderSelector({
    super.key,
    required this.selectedTime,
    required this.timeError,
    required this.onSelectTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred reminder time',
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(12.h),
        Row(
          children: [
            Expanded(
              child: CustomTime(
                title: 'Morning',
                subtitle: '6-10 AM',
                isSelected: selectedTime == 'Morning',
                onTap: () => onSelectTime('Morning'),
              ),
            ),
            UIHelper.horizontalSpace(15.w),
            Expanded(
              child: CustomTime(
                title: 'Afternoon',
                subtitle: '11 AM - 5 PM',
                isSelected: selectedTime == 'Afternoon',
                onTap: () => onSelectTime('Afternoon'),
              ),
            ),
            UIHelper.horizontalSpace(15.w),
            Expanded(
              child: CustomTime(
                title: 'Evening',
                subtitle: '6 - 10 PM',
                isSelected: selectedTime == 'Evening',
                onTap: () => onSelectTime('Evening'),
              ),
            ),
          ],
        ),
        if (timeError != null) ...[
          UIHelper.verticalSpace(8.h),
          Text(
            timeError!,
            style: TextStyle(color: Colors.red, fontSize: 14.sp),
          ),
        ],
      ],
    );
  }
}
