
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class ProgressWidget extends StatefulWidget {
  final List<Map<String, dynamic>> nutrients;

  const ProgressWidget({
    super.key,
    required this.nutrients,
  });

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {


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
            style: TextFontStyle.textStylePoppins.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          UIHelper.verticalSpace(12.h),

          for (var nutrient in widget.nutrients) ...[
            _buildMacroItem(
              title: nutrient['title'],
              percentage: nutrient['percentage'],
              grams: nutrient['grams'],
              progress: nutrient['progress'],
              progressColor: nutrient['color'],
            ),
            if (nutrient != widget.nutrients.last) UIHelper.verticalSpace(12.h),
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
              style: TextFontStyle.textStylePoppins.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Text(
                  '$percentage ',
                  style: TextFontStyle.textStylePoppins.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  grams,
                  style: TextFontStyle.textStylePoppins.copyWith(
                    color: AppColors.c8C8C8C,
                    fontSize: 16.sp,
                  ),
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
              width: 295.w * progress.clamp(0.0, 1.0),
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