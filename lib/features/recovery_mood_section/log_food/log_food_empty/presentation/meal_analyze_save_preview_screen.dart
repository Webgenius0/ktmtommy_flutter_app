import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_breakdown.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_meal_.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/nutrition_facts.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/progress_custom.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class MealAnalyzeSavePreviewScreen extends StatefulWidget {
  final String imagePath;

  const MealAnalyzeSavePreviewScreen({super.key, required this.imagePath});
  @override
  State<MealAnalyzeSavePreviewScreen> createState() =>
      _MealAnalyzeSavePreviewScreenState();
}

class _MealAnalyzeSavePreviewScreenState
    extends State<MealAnalyzeSavePreviewScreen> {
  final List<Map<String, dynamic>> nutrients1 = [
    {
      "title": "Carbs",
      "percentage": "45%",
      "grams": "69g",
      "progress": 0.4,
      "color": Color(0xFFEEE6DA),
    },
    {
      "title": "Protein",
      "percentage": "30%",
      "grams": "46g",
      "progress": 0.30,
      "color": Color(0xFF87B842),
    },
    {
      "title": "Fat",
      "percentage": "25%",
      "grams": "17g",
      "progress": 0.25,
      "color": Color(0xFFCC1F28),
    },
  ];

  final List<Map<String, dynamic>> traleadingTitle = [
    {"title": 'Brown rice', "value": '1 cup (185g)'},
    {
      "title": 'Grilled chicken',
      "value": '4 oz (115g)',
    },
    {
      "title": 'Avocado',
      "value": '½ (75g)',
    },
    {
      "title": 'Broccoli',
      "value": '½ cup (45g)',
    },
    {"title": 'Grilled carrots', "value": '¼ cup (30g)'}
  ];

  @override
  Widget build(BuildContext context) {
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
                      ProgressCustom(nutrients: nutrients1),
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
