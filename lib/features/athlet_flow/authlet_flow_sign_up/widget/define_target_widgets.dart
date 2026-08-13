import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class DefineTargetTriathlonWidget extends StatelessWidget {
  final int selectedFormatIndex;
  final Function(int) onSelectFormat;
  final List<Map<String, String>> formats;

  const DefineTargetTriathlonWidget({
    super.key,
    required this.selectedFormatIndex,
    required this.onSelectFormat,
    required this.formats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: List.generate(formats.length, (index) {
            bool isSelected = selectedFormatIndex == index;
            var format = formats[index];

            return GestureDetector(
              onTap: () => onSelectFormat(index),
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
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.c181818.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.c2F2F2F),
          ),
          child: Text(
            'Your AI coach will structure swim, bike, and run sessions with brick workouts to prepare you for ${formats[selectedFormatIndex]['name']!.toLowerCase()}.',
            style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
              fontSize: 13.sp,
              color: AppColors.cA3A3A3,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class DefineTargetCounterWidget extends StatelessWidget {
  final String title;
  final int value;
  final String unit;
  final String? subtitle;
  final Function(int) onChange;

  const DefineTargetCounterWidget({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    this.subtitle,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.c181818,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.c2F2F2F),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => onChange(value > 1 ? value - 1 : 1),
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColors.c2F2F2F,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.remove, color: AppColors.cFFFFFF, size: 20.sp),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$value ',
                      style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                        fontSize: 36.sp,
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
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColors.c2F2F2F,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.add, color: AppColors.cFFFFFF, size: 20.sp),
                ),
              ),
            ],
          ),
        ),
        if (subtitle != null) ...[
          UIHelper.verticalSpace(12.h),
          Text(
            subtitle!,
            style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
              fontSize: 13.sp,
              color: AppColors.cA3A3A3,
            ),
          ),
        ],
      ],
    );
  }
}
