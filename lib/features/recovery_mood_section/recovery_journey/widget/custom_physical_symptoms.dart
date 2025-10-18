
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/tbi_custom.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class CustomPhysicalSymptoms extends StatelessWidget {
  final String title;
  final String selectedSymptom;
  final Function(String) onSelected;

  const CustomPhysicalSymptoms({
    super.key,
    required this.title,
    required this.selectedSymptom,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
            UIHelper.verticalSpace(12.h),

            Row(
              children: [
                TbiCustom(
                  title: 'Headaches',
                  isSelected: selectedSymptom == 'Headaches',
                  onTap: () => onSelected('Headaches'),
                ),
                UIHelper.horizontalSpace(10.w),
                TbiCustom(
                  title: 'Dizziness',
                  isSelected: selectedSymptom == 'Dizziness',
                  onTap: () => onSelected('Dizziness'),
                ),
              ],
            ),
            UIHelper.verticalSpace(12.h),
            Row(
              children: [
                TbiCustom(
                  title: 'Vision Problems',
                  isSelected: selectedSymptom == 'Vision Problems',
                  onTap: () => onSelected('Vision Problems'),
                ),
                UIHelper.horizontalSpace(10.w),
                Expanded(
                  child: TbiCustom(
                    title: 'Balance Issues',
                    isSelected: selectedSymptom == 'Balance Issues',
                    onTap: () => onSelected('Balance Issues'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}