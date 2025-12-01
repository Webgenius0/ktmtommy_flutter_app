import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class CustomBreakdown extends StatefulWidget {
  const CustomBreakdown(
      {super.key, required List<Map<String, dynamic>> traleadingTitle});

  @override
  State<CustomBreakdown> createState() => _CustomBreakdownState();
}

class _CustomBreakdownState extends State<CustomBreakdown> {
  @override
  Widget build(BuildContext context) {
    ///================Map List ================///
    final Map<String, dynamic> rawData = appData.read(kKeyIngredients) ?? {};

    if (rawData.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Map<String, String>> ingredientList = rawData.entries
        .map((e) => {'title': e.key, 'value': e.value.toString()})
        .toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredient Breakdown',
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          UIHelper.verticalSpace(12.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ingredientList.length,
            separatorBuilder: (_, __) => UIHelper.verticalSpace(12.h),
            itemBuilder: (context, index) {
              final item = ingredientList[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['title']!,
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                            .copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        item['value']!,
                        style: TextFontStyle.textStyle14w400c8C8C8Cpoppins
                            .copyWith(
                          fontSize: 14.sp,
                          color: const Color(0xFF8C8C8C),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(8.h),
                  const Divider(
                    color: AppColors.c2F2F2F,
                    thickness: 1,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
