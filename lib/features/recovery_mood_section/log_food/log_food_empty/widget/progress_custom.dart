import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class ProgressCustom extends StatelessWidget {
  final List<Map<String, dynamic>> nutrients;

  const ProgressCustom({
    super.key,
    required this.nutrients,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.c181818,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Macronutrient Distribution',
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 18.sp,fontWeight: FontWeight.w500
            )
          ),
          UIHelper.verticalSpace(12.h),

          // Nutrition Items
          for (var nutrient in nutrients) ...[
            _buildMacroItem(
              title: nutrient['title'],
              percentage: nutrient['percentage'],
              grams: nutrient['grams'],
              progress: nutrient['progress'],
              progressColor: nutrient['color'],
            ),
            if (nutrient != nutrients.last) UIHelper.verticalSpace(12.h),
          ],
        ],
      ),
    );
  }

  Widget _buildMacroItem({
    required String title,
    required String percentage,
    required String grams,
    required double progress,
    required Color progressColor,
  }) {
    return Column(
      children: [
        // Text Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 16.sp,fontWeight: FontWeight.w400
                )
            ),
            Row(
              children: [
                Text(
                  '$percentage ',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),
                Text(
                  grams,
                  style: TextFontStyle.textStyle14w400c8C8C8Cpoppins.copyWith(
                      fontSize: 16.sp
                  )
                ),
              ],
            ),
          ],
        ),
        UIHelper.verticalSpace(12.h),


        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColors.c454545,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            Container(
              width: 295.w * progress,
              height: 8.h,
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ],
        ),
      ],
    );
  }
}