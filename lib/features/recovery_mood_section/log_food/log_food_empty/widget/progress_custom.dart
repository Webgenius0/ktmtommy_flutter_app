import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class ProgressCustom extends StatelessWidget {
  const ProgressCustom({super.key, required List<Map<String, dynamic>> nutrients});


  double _parsePercentage(dynamic value) {
    if (value == null) return 0.0;

    String str = value.toString().trim();


    if (str.endsWith('%')) {
      str = str.substring(0, str.length - 1);
    }

    return double.tryParse(str) ?? 0.0;
  }

  double _parseGrams(dynamic value) {
    if (value == null) return 0.0;
    String str = value.toString().trim();

    if (str.endsWith('g')) {
      str = str.substring(0, str.length - 1);
    }
    return double.tryParse(str) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {

    final dynamic rawProtein = appData.read(kKeyProteinPercentage);
    final dynamic rawCarbs = appData.read(kKeyCarbsPercentage);
    final dynamic rawFat = appData.read(kKeyFatPercentage);

    final dynamic rawProteinGrams = appData.read(kKeyProteinInGm);
    final dynamic rawCarbsGrams = appData.read(kKeyCarbsInGm);
    final dynamic rawFatGrams = appData.read(kKeyFatInGm);


    final double proteinPercentage = _parsePercentage(rawProtein);
    final double carbsPercentage = _parsePercentage(rawCarbs);
    final double fatPercentage = _parsePercentage(rawFat);

    final double proteinGrams = _parseGrams(rawProteinGrams);
    final double carbsGrams = _parseGrams(rawCarbsGrams);
    final double fatGrams = _parseGrams(rawFatGrams);


    developer.log('''
    Parsed Macros:
    Protein: $proteinPercentage% → ${proteinGrams.toInt()}g
    Carbs: $carbsPercentage% → ${carbsGrams.toInt()}g
    Fat: $fatPercentage% → ${fatGrams.toInt()}g
    ''');

    final List<Map<String, dynamic>> nutrients3 = [
      {
        'title': 'Protein',
        'percentage': '${proteinPercentage.toInt()}%',
        'grams': '${proteinGrams.toInt()}g',
        'progress': (proteinPercentage / 100).clamp(0.0, 1.0),
        'color': const Color(0xFF6C63FF),
      },
      {
        'title': 'Carbs',
        'percentage': '${carbsPercentage.toInt()}%',
        'grams': '${carbsGrams.toInt()}g',
        'progress': (carbsPercentage / 100).clamp(0.0, 1.0),
        'color': const Color(0xFFFF9F43),
      },
      {
        'title': 'Fat',
        'percentage': '${fatPercentage.toInt()}%',
        'grams': '${fatGrams.toInt()}g',
        'progress': (fatPercentage / 100).clamp(0.0, 1.0),
        'color': const Color(0xFF4CAF50),
      },
    ];

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
          Text(
            'Macronutrient Distribution',
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          UIHelper.verticalSpace(16.h),

          for (int i = 0; i < nutrients3.length; i++) ...[
            _buildMacroItem(
              title: nutrients3[i]['title'] as String,
              percentage: nutrients3[i]['percentage'] as String,
              grams: nutrients3[i]['grams'] as String,
              progress: nutrients3[i]['progress'] as double,
              progressColor: nutrients3[i]['color'] as Color,
            ),
            if (i < nutrients3.length - 1) UIHelper.verticalSpace(16.h),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Text(
                  percentage,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  grams,
                  style: TextFontStyle.textStyle14w400c8C8C8Cpoppins.copyWith(
                    fontSize: 14.sp,
                    color: const Color(0xFF8C8C8C),
                  ),
                ),
              ],
            ),
          ],
        ),
        UIHelper.verticalSpace(10.h),

        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: SizedBox(
            height: 8.h,
            child: Stack(
              children: [
                Container(color: AppColors.c454545),
                FractionallySizedBox(
                  widthFactor: progress,
                  alignment: Alignment.centerLeft,
                  child: Container(color: progressColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}