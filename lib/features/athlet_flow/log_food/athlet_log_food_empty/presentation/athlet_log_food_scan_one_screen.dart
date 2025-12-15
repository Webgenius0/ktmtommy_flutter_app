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
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/presentation/athlet_meal_analyze_screen.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/widget/athlet_custom_chiken.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/widget/athlet_custom_edit.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/widget/athlet_custom_hold_steady.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/widget/custom_camera_athlet.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class AthletLogFoodScanOneScreen extends StatefulWidget {
  final String imagePath;
  const AthletLogFoodScanOneScreen({super.key, required this.imagePath});

  @override
  State<AthletLogFoodScanOneScreen> createState() =>
      _AthletLogFoodScanOneScreenState();
}

class _AthletLogFoodScanOneScreenState
    extends State<AthletLogFoodScanOneScreen> {
  final TextEditingController _noteController = TextEditingController();
  bool _isSaving = false;
  String _currentImagePath = "";

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.imagePath;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  ///=============Clears all food scan related data from appData=================
  void _clearAllFoodScanData() {
    final keys = [
      kKeyFoodName,
      kKeyTotalCalories,
      kKeyCarbsPercentage,
      kKeyCarbsInGm,
      kKeyProteinPercentage,
      kKeyProteinInGm,
      kKeyFatPercentage,
      kKeyFatInGm,
      kKeyProtein,
      kKeyTotalCarbs,
      kKeyFiber,
      kKeySugar,
      kKeyTotalFat,
      kKeySaturated,
      kKeySodium,
      kKeyPotassium,
      kKeyIngredients,
      kKeyNutritionalInsights,
      kKeyIsFood,
    ];

    for (var key in keys) {
      if (appData.hasData(key)) {
        appData.remove(key);
      }
    }
  }

  ///================== Retake =================================================
  Future<void> _retakePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 90);

    if (pickedFile == null || !mounted) return;

    ///================== loading dialog ==============================
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: AppColors.c87B842, strokeWidth: 5),
            SizedBox(height: 24),
            Text("Analyzing your meal...",
                style: TextStyle(color: AppColors.c87B842, fontSize: 16)),
          ],
        ),
      ),
    );

    try {
      // old data remove
      _clearAllFoodScanData();

      // new data
      setState(() {
        _currentImagePath = pickedFile.path;
      });

      // API
      await foodScanPostRxObj.postFoodScanApi(image: File(pickedFile.path));

      //  UI Update
      setState(() {});
    } catch (e) {
      log("API Error (silent): $e");
    } finally {
      if (mounted) Navigator.pop(context);
    }
  }

  Future<void> _saveLog() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      final imageFile = File(_currentImagePath);
      if (!await imageFile.exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image not found!")),
        );
        return;
      }

      final takenAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      ///============= kKeyIngredients Map jsonEncode===========================
      final Map<String, dynamic> ingredientMap =
          Map<String, dynamic>.from(appData.read(kKeyIngredients) ?? {});

      final List<dynamic> insights =
          appData.read(kKeyNutritionalInsights) ?? [];

      log("Sending ingredient_breakdown: ${jsonEncode(ingredientMap)}");

      await foodStoreRxObj.saveFoodRecord(
        image: imageFile,
        food_name: appData.read(kKeyFoodName) ?? "Unknown Food",
        total_estimated_calories:
            (appData.read(kKeyTotalCalories) ?? 0).toString(),
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
        ingredient_breakdown: jsonEncode(ingredientMap),
        nutritional_insights: jsonEncode(insights),
        taken_at: takenAt,
        notes: _noteController.text.trim(),
      );

      if (!mounted) return;

      NavigationService.navigateTo(Routes.athletLogFoodEmptyScreen);
    } catch (e, s) {
      log("Save failed: $e\n$s");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Save failed: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ///==== null-safe values ==========
    final String foodName = appData.read(kKeyFoodName) ?? "No food detected";

    final ingredientList = appData.read(kKeyIngredients);
    log("=========>>>>>>>>,,,,,,ingredientList: $ingredientList");
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///===================== AppBar========================
              ArrowButtonAtheleteFlow(
                onTap: () => NavigationService.goBack,
                text: 'Log Food',
                subtitle: 'Snap your meal, get calorie estimates',
              ),

              UIHelper.verticalSpace(24.h),

              ///========================== Pro Tip===========================
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Row(children: [
                  SvgPicture.asset(
                    AppIcons.tipholdicon,
                    height: 20.w,
                    color: AppColors.orangeColor,
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text('Pro Tip: Hold steady for clearer images',
                      style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                ]),
              ),

              UIHelper.verticalSpace(24.h),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCameraAthlet(
                          imagePath: _currentImagePath, onRetake: _retakePhoto),

                      UIHelper.verticalSpace(24.h),

                      AthletCustomHoldSteady(
                        imagePath: _currentImagePath,
                        onRetake: _retakePhoto,
                        onAnalyze: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AthletMealAnalyzeScreen(
                                  imagePath: _currentImagePath),
                            ),
                          );
                        },
                      ),

                      UIHelper.verticalSpace(18.h),

                      ///===================== Chicken Widget ========================
                      AthletCustomChiken(
                          text: foodName, imagePath: _currentImagePath),

                      UIHelper.verticalSpace(18.h),
                      const AthletCustomEdit(),

                      UIHelper.verticalSpace(24.h),

                      Text('Notes',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                              .copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500)),

                      UIHelper.verticalSpace(12.h),

                      CustomTextfield(
                        controller: _noteController,
                        maxline: 4,
                        fillColor: AppColors.c181818,
                        hintText: 'Add notes',
                        borderRadius: 12.r,
                        style: const TextStyle(color: Colors.white),
                      ),

                      UIHelper.verticalSpace(40.h),

                      _isSaving
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.orangeColor))
                          : CustomButtonWidget(
                              text: 'Save Log',
                              onTap: _saveLog,
                              image: DecorationImage(
                                  image: AssetImage(AppImages.orangebutton)),
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
