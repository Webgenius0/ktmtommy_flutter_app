import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/widget/athlet_custom_meal_.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/widget/athlet_progress_custom.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_breakdown.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_meal_.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/nutrition_facts.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/progress_custom.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class AthletMealAnalyzeScreen extends StatefulWidget {
  final String imagePath;

  const AthletMealAnalyzeScreen({super.key, required this.imagePath});
  @override
  State<AthletMealAnalyzeScreen> createState() => _AthletMealAnalyzeScreenState();
}

class _AthletMealAnalyzeScreenState extends State<AthletMealAnalyzeScreen> {
  bool _isSaving = false;
  List<Map<String, dynamic>> nutrients = [];
  List<Map<String, dynamic>> traleadingTitle = [];

  @override
  void initState() {
    super.initState();
    _prepareData();
  }

  ///=========kKeyNutritionalInsights Data convert list=========================
  void _prepareData() {
    final rawData = appData.read(kKeyNutritionalInsights);

    log('========>>>>>>>>>nutritionalInsights: $rawData');

    List<String> insights = [];

    if (rawData is List && rawData.isNotEmpty) {
      insights = rawData.cast<String>();
    }

    if (insights.isEmpty) {
      insights = [
        'No data available',
        'No data available',
      ];
    }

    insights = insights.take(2).toList();

    ///============== CustomBreakdown=======================================
    traleadingTitle = insights.map((text) => {'title': text}).toList();

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ingredientList = appData.read(kKeyIngredients);
    log("=========>>>>>>>>ingredientList: $ingredientList");

    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              ///=======================Appbar Section==========================
               ArrowButtonAtheleteFlow(
                              onTap: () => NavigationService.goBack,
                              text: 'Meal Analyze',
                              subtitle: 'Snap your meal, get calorie estimates',
                            ),

              UIHelper.verticalSpace(24.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///=============Image Path Section =======================
                      AthletCustomMeal(imagePath: widget.imagePath),
                      UIHelper.verticalSpace(24.h),

                      ///=================Macronutrient Distribution============
                      AthletProgressCustom(nutrients: nutrients),
                      UIHelper.verticalSpace(24.h),

                      ///==================Nutrition Facts======================
                      NutritionFacts(text: 'Nutrition Facts'),
                      UIHelper.verticalSpace(24.h),

                      ///=================Ingredient Breakdown==================
                      CustomBreakdown(traleadingTitle: traleadingTitle),
                      UIHelper.verticalSpace(24.h),

                      ///=============Nutritional Insights======================
                      Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF181818),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.whaticon,
                                      height: 20.h,color: AppColors.orangeColor,),
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

                              ///=====Dynamic 2 line Show=======================
                              ...traleadingTitle.asMap().entries.map((entry) {
                                final text = entry.value['title'] as String;
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: entry.key ==
                                              traleadingTitle.length - 1
                                          ? 0
                                          : 16.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 2.w,
                                        height: 55.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.orangeColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12.r),
                                            bottomLeft: Radius.circular(12.r),
                                          ),
                                        ),
                                      ),
                                      UIHelper.horizontalSpace(7.w),
                                      Expanded(
                                        child: Text(
                                          text,
                                          style: TextFontStyle
                                              .textStyle14w400cBABABApoppins,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),

                      UIHelper.verticalSpace(24.h),
                      _isSaving
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.orangeColor,
                                strokeWidth: 5,
                              ),
                            )
                          : CustomButtonWidget(
                        image: DecorationImage(
                            image: AssetImage(AppImages.orangebutton)),
                              text: 'Save Log',
                              onTap: () async {
                                if (_isSaving) return;

                                setState(() {
                                  _isSaving = true;
                                });

                                try {
                                  log("Original Image Path: ${widget.imagePath}");

                                  final XFile xFile = XFile(widget.imagePath);
                                  final File imageFile = File(xFile.path);

                                  if (!await imageFile.exists()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Image not found!")),
                                    );
                                    setState(() => _isSaving = false);
                                    return;
                                  }

                                  log("File Path (for API): ${imageFile.path}");
                                  log("File Size: ${(await imageFile.length()) / 1024} KB");

                                  final Map<String, dynamic> ingredientMap = Map<String, dynamic>.from(appData.read(kKeyIngredients) ?? {});

                                  final List<dynamic> nutritionalInsightsList = appData.read(kKeyNutritionalInsights) ?? [];

                                  final String ingredientBreakdownJson = jsonEncode(ingredientMap);
                                  final String nutritionalInsightsJson = jsonEncode(nutritionalInsightsList);

                                  log("=====>>>ingredient_breakdown: $ingredientBreakdownJson");
                                  log("=====>>nutritional_insights: $nutritionalInsightsJson");
                                  final String currentDateTime =
                                      DateFormat('yyyy-MM-dd HH:mm:ss')
                                          .format(DateTime.now());

                                  log("====>>>>taken_at: $currentDateTime");

                                  ///============= API Call=====================
                                  await foodStoreRxObj.saveFoodRecord(
                                    image: imageFile,
                                    food_name: appData.read(kKeyFoodName) ?? "Unknown Food",
                                    total_estimated_calories: appData.read(kKeyTotalCalories)?.toString() ?? 0,
                                    carbs_percentage: appData.read(kKeyCarbsPercentage) ?? "0%",
                                    carbs_in_gm: appData.read(kKeyCarbsInGm) ?? "0g",
                                    protein_percentage: appData.read(kKeyProteinPercentage) ?? "0%",
                                    protein_in_gm: appData.read(kKeyProteinInGm) ?? "0g",
                                    fat_percentage: appData.read(kKeyFatPercentage) ?? "0%",
                                    fat_in_gm: appData.read(kKeyFatInGm) ?? "0g",
                                    protein: appData.read(kKeyProtein) ?? "0g",
                                    total_carbs: appData.read(kKeyTotalCarbs) ?? "0g",
                                    fiber: appData.read(kKeyFiber) ?? "0g",
                                    sugar: appData.read(kKeySugar) ?? "0g",
                                    total_fat: appData.read(kKeyTotalFat) ?? "0g",
                                    saturated: appData.read(kKeySaturated) ?? "0g",
                                    sodium: appData.read(kKeySodium) ?? "0mg",
                                    potassium: appData.read(kKeyPotassium) ?? "0mg",
                                    ingredient_breakdown: ingredientBreakdownJson,
                                    nutritional_insights: nutritionalInsightsJson,
                                    taken_at: currentDateTime, notes: '',
                                  );

                                  if (!mounted) return;

                                  log("========>>>>Save Food Record Success! go to athletLogFoodEmptyScreen");

                                  NavigationService.navigateTo(
                                      Routes.athletLogFoodEmptyScreen);
                                } catch (e, stack) {
                                  log("========>>>>Save Failed: $e");
                                  log(stack.toString());
                                  if (mounted) {
                                    return;
                                  }
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isSaving = false;
                                    });
                                  }
                                }
                              },
                            ),
                      UIHelper.verticalSpace(25.h),
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
