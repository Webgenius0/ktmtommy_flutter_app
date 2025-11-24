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
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/presentation/meal_analyze_screen.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_camera.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_chiken.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_edit.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_hold_steady.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class LogFoodScanTwoScreen extends StatefulWidget {
  final String imagePath;
  const LogFoodScanTwoScreen({super.key, required this.imagePath});

  @override
  State<LogFoodScanTwoScreen> createState() => _LogFoodScanTwoScreenState();
}

class _LogFoodScanTwoScreenState extends State<LogFoodScanTwoScreen> {
  final TextEditingController _noteController = TextEditingController();
  bool _isSaving = false;
  late String _currentImagePath;
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.imagePath;
    _selectedDateTime = DateTime.now();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void updateDateTime(DateTime newDateTime) {
    setState(() {
      _selectedDateTime = newDateTime;
    });
  }

  ///==============Retake Photo Function========================================
  Future<void> _retakePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 90,
    );

    if (photo == null || !mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppColors.c87B842,
                strokeWidth: 5,
              ),
              SizedBox(height: 24),
              Text(
                "Analyzing your meal...",
                style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      setState(() {
        _currentImagePath = photo.path;
      });

      final response = await foodScanPostRxObj.postFoodScanApi(
        image: File(photo.path),
      );
      setState(() {});
    } catch (e) {
      log("API Error (silent): $e");
    } finally {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  ///============ Analyze Now Button=============================================
  Future<void> _onAnalyzeNow() async {
    if (_currentImagePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please take a photo first')),
      );
      return;
    }

    try {
      log("================Analyze Now Clicked → Going to MealAnalyzeScreen");
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MealAnalyzeScreen(imagePath: _currentImagePath),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Analysis failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final foodName = appData.read(kKeyFoodName);
    final totalCalories = appData.read(kKeyTotalCalories);
    log('========>>>>>>>>>Food Name: ${appData.read(kKeyFoodName)}');
    log('========>>>>>>>>>TotalCalories: ${appData.read(kKeyTotalCalories)}');
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///===================AppBar Section==============================
              CustomAppbarWidget(
                onTap: () {
                  Navigator.pop(context);
                },
                text: 'Log Food',
                subtitle: 'Snap your meal, get calorie estimates',
              ),

              UIHelper.verticalSpace(24.h),

              ///===================== Pro Tip Box==============================
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: AppColors.c181818,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.tipholdicon, height: 20.w),
                    UIHelper.horizontalSpace(8.w),
                    Text(
                      'Pro Tip: Hold steady for clearer images',
                      style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                    ),
                  ],
                ),
              ),

              UIHelper.verticalSpace(24.h),

              ///================= Scrollable Content===========================
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///============== Retake Button===========================
                      CustomCamera(
                        imagePath: _currentImagePath,
                        onRetake: _retakePhoto,
                      ),

                      UIHelper.verticalSpace(24.h),

                      ///============Retake + Analyze Now ======================
                      CustomHoldSteady(
                        imagePath: _currentImagePath,
                        onRetake: _retakePhoto,
                        onAnalyze: _onAnalyzeNow,
                      ),

                      UIHelper.verticalSpace(18.h),

                      ///=========== Detected Food Example======================
                      CustomChiken(
                        text: foodName,
                        imagePath: _currentImagePath,
                      ),

                      UIHelper.verticalSpace(18.h),
                      const CustomEditPic(),

                      UIHelper.verticalSpace(24.h),

                      ///================ Notes Section=========================
                      Text(
                        'Notes',
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                            .copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      UIHelper.verticalSpace(12.h),
                      CustomTextfield(
                        controller: _noteController,
                        textAlign: TextAlign.start,
                        fillColor: AppColors.c181818,
                        maxline: 4,
                        hintText: 'Add notes',
                        hintTextSyle: TextFontStyle
                            .textStyle16w400c757575poppins
                            .copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        style: const TextStyle(color: Colors.white),
                        borderRadius: 12.r,
                      ),

                      UIHelper.verticalSpace(40.h),
                      _isSaving
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.c87B842,
                                strokeWidth: 5,
                              ),
                            )
                          : CustomButtonWidget(
                              text: 'Save Log',
                              onTap: () async {
                                if (_isSaving) return;

                                setState(() {
                                  _isSaving = true;
                                });

                                try {
                                  log("Original Image Path: ${widget.imagePath}");
                                  final String takenAtFormatted =
                                      DateFormat('yyyy-MM-dd HH:mm:ss').format(
                                          _selectedDateTime ?? DateTime.now());
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

                                  final Map<String, dynamic>
                                      ingredientBreakdown = {
                                    "bun": appData.read(kKeyBun) ?? '0',
                                    "beef patties":
                                        appData.read(kKeyBeefPatties) ?? '0',
                                    "cheese": appData.read(kKeyCheese) ?? '0',
                                    "lettuce": appData.read(kKeyLettuce) ?? '0',
                                    "tomato": appData.read(kKeyTomato) ?? '0',
                                    "pickles": appData.read(kKeyPickles) ?? '0',
                                    "onion": appData.read(kKeyOnion) ?? '0',
                                    "sauce": appData.read(kKeySauce) ?? '0',
                                  };

                                  final List<dynamic> nutritionalInsightsList =
                                      appData.read(kKeyNutritionalInsights) ??
                                          [];

                                  final String ingredientBreakdownJson =
                                      jsonEncode(ingredientBreakdown);
                                  final String nutritionalInsightsJson =
                                      jsonEncode(nutritionalInsightsList);

                                  log("ingredient_breakdown: $ingredientBreakdownJson");
                                  log("nutritional_insights: $nutritionalInsightsJson");

                                  ///================= API Call=======================
                                  await foodStoreRxObj.saveFoodRecord(
                                    image: imageFile,
                                    food_name: appData.read(kKeyFoodName) ??
                                        "Unknown Food",
                                    total_estimated_calories: appData
                                            .read(kKeyTotalCalories)
                                            ?.toString() ??
                                        "0",
                                    carbs_percentage:
                                        appData.read(kKeyCarbsPercentage) ??
                                            "0%",
                                    carbs_in_gm:
                                        appData.read(kKeyCarbsInGm) ?? "0g",
                                    protein_percentage:
                                        appData.read(kKeyProteinPercentage) ??
                                            "0%",
                                    protein_in_gm:
                                        appData.read(kKeyProteinInGm) ?? "0g",
                                    fat_percentage:
                                        appData.read(kKeyFatPercentage) ?? "0%",
                                    fat_in_gm:
                                        appData.read(kKeyFatInGm) ?? "0g",
                                    protein: appData.read(kKeyProtein) ?? "0g",
                                    total_carbs:
                                        appData.read(kKeyTotalCarbs) ?? "0g",
                                    fiber: appData.read(kKeyFiber) ?? "0g",
                                    sugar: appData.read(kKeySugar) ?? "0g",
                                    total_fat:
                                        appData.read(kKeyTotalFat) ?? "0g",
                                    saturated:
                                        appData.read(kKeySaturated) ?? "0g",
                                    sodium: appData.read(kKeySodium) ?? "0mg",
                                    potassium:
                                        appData.read(kKeyPotassium) ?? "0mg",
                                    ingredient_breakdown:
                                        ingredientBreakdownJson,
                                    nutritional_insights:
                                        nutritionalInsightsJson,
                                    taken_at: takenAtFormatted,
                                    notes: _noteController.text.trim(),
                                  );

                                  if (!mounted) return;

                                  log("========>>>>Save Food Record Success! go to logFoodEmptyScreen");

                                  NavigationService.navigateTo(
                                      Routes.logFoodEmptyScreen);
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

                      UIHelper.verticalSpace(30.h),
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
