import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class CustomBreakdown extends StatelessWidget {
  const CustomBreakdown({super.key, required List<Map<String, dynamic>> traleadingTitle});

  List<Map<String, String>> _getIngredientList() {
    final List<Map<String, String>> ingredients = [];

    final bun = appData.read(kKeyBun);
    final beefPatties = appData.read(kKeyBeefPatties);
    final cheese = appData.read(kKeyCheese);
    final lettuce = appData.read(kKeyLettuce);
    final tomato = appData.read(kKeyTomato);
    final pickles = appData.read(kKeyPickles);
    final onion = appData.read(kKeyOnion);
    final sauce = appData.read(kKeySauce);



    if (bun != null && bun.toString().trim().isNotEmpty) {
      ingredients.add({'title': 'Bun', 'value': bun.toString()});
    }
    if (beefPatties != null && beefPatties.toString().trim().isNotEmpty) {
      ingredients.add({'title': 'Beef Patties', 'value': beefPatties.toString()});
    }
    if (cheese != null && cheese.toString().trim().isNotEmpty) {
      ingredients.add({'title': 'Cheese', 'value': cheese.toString()});
    }
    if (lettuce != null && lettuce.toString().trim().isNotEmpty) {
      ingredients.add({'title': 'Lettuce', 'value': lettuce.toString()});
    }
    if (tomato != null && tomato.toString().trim().isNotEmpty) {
      ingredients.add({'title': 'Tomato', 'value': tomato.toString()});
    }
    if (pickles != null && pickles.toString().trim().isNotEmpty) {
      ingredients.add({'title': 'Pickles', 'value': pickles.toString()});
    }
    if (onion != null && onion.toString().trim().isNotEmpty) {
      ingredients.add({'title': 'Onion', 'value': onion.toString()});
    }
    if (sauce != null && sauce.toString().trim().isNotEmpty) {
      ingredients.add({'title': 'Sauce', 'value': sauce.toString()});
    }

    developer.log('Ingredient list: $ingredients');

    return ingredients;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> ingredientList = _getIngredientList();

    if (ingredientList.isEmpty) {
      return const SizedBox.shrink();
    }

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
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        item['value']!,
                        style: TextFontStyle.textStyle14w400c8C8C8Cpoppins.copyWith(
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