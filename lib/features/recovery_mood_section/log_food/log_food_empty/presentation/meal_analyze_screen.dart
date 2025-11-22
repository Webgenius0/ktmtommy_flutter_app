import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_breakdown.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_meal_.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/nutrition_facts.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/progress_custom.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class MealAnalyzeScreen extends StatefulWidget {
  final String imagePath;

  const MealAnalyzeScreen({super.key, required this.imagePath});
  @override
  State<MealAnalyzeScreen> createState() => _MealAnalyzeScreenState();
}

class _MealAnalyzeScreenState extends State<MealAnalyzeScreen> {
  final List<Map<String, dynamic>> nutrients = [];
  final List<Map<String, dynamic>> traleadingTitle = [];

  @override
  Widget build(BuildContext context) {

    final nutritionalInsights = appData.read(kKeyNutritionalInsights);

    log('========>>>>>>>>>nutritionalInsights: ${appData.read(kKeyNutritionalInsights)}');

    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              CustomAppbarWidget(
                onTap: () {
                  NavigationService.goBack;
                },
                text: 'Meal Analyze',
                subtitle: 'Snap your meal, get calorie estimates',
              ),
              UIHelper.verticalSpace(24.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomMeal(imagePath: widget.imagePath),
                      UIHelper.verticalSpace(24.h),
                      ProgressCustom(nutrients: nutrients),
                      UIHelper.verticalSpace(24.h),
                      NutritionFacts(text: 'Nutrition Facts'),
                      UIHelper.verticalSpace(24.h),
                      CustomBreakdown(traleadingTitle: traleadingTitle),
                      UIHelper.verticalSpace(24.h),
                      Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                            color: const Color(0xFF181818),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.whaticon,
                                      height: 20.h),
                                  UIHelper.horizontalSpace(8.w),
                                  Text(
                                    'Nutritional Insights',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1.50,
                                    ),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpace(16.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 2.w,
                                    height: 55.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.c87B842,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.r),
                                        bottomLeft: Radius.circular(12.r),
                                      ),
                                    ),
                                  ),
                                  UIHelper.horizontalSpace(7.w),
                                  Text(
                                      'Good protein source - helps with muscle\nrecovery',
                                      style: TextFontStyle
                                          .textStyle14w400cBABABApoppins),
                                ],
                              ),
                              UIHelper.verticalSpace(16.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 2.w,
                                    height: 55.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.c87B842,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.r),
                                        bottomLeft: Radius.circular(12.r),
                                      ),
                                    ),
                                  ),
                                  UIHelper.horizontalSpace(7.w),
                                  Text(
                                      'Consider adding more vegetables for\nadditional fiber',
                                      style: TextFontStyle
                                          .textStyle14w400cBABABApoppins),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(24.h),
                      CustomButtonWidget(
                        text: 'Save Log',
                        onTap: () {
                          NavigationService.navigateTo(
                              Routes.logFoodEmptyScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



