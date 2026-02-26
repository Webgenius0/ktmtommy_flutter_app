// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
// import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
// import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
// import 'package:ktmtommy_apps/constants/app_constants.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/presentation/meal_analyze_screen.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_camera.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_chiken.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_edit.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_hold_steady.dart';
// import 'package:ktmtommy_apps/helpers/all_routes.dart';
// import 'package:ktmtommy_apps/helpers/di.dart';
// import 'package:ktmtommy_apps/helpers/navigation_service.dart';
// import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
// import 'package:ktmtommy_apps/networks/api_acess.dart';
//
// class LogFoodScanTwoScreen extends StatefulWidget {
//   final String imagePath;
//   const LogFoodScanTwoScreen({super.key, required this.imagePath});
//
//   @override
//   State<LogFoodScanTwoScreen> createState() => _LogFoodScanTwoScreenState();
// }
//
// class _LogFoodScanTwoScreenState extends State<LogFoodScanTwoScreen> {
//   final TextEditingController _noteController = TextEditingController();
//   bool _isSaving = false;
//   String _currentImagePath = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _currentImagePath = widget.imagePath;
//   }
//
//   @override
//   void dispose() {
//     _noteController.dispose();
//     super.dispose();
//   }
//
//   ///=============Clears all food scan related data from appData=================
//   void _clearAllFoodScanData() {
//     final keys = [
//       kKeyFoodName,
//       kKeyTotalCalories,
//       kKeyCarbsPercentage,
//       kKeyCarbsInGm,
//       kKeyProteinPercentage,
//       kKeyProteinInGm,
//       kKeyFatPercentage,
//       kKeyFatInGm,
//       kKeyProtein,
//       kKeyTotalCarbs,
//       kKeyFiber,
//       kKeySugar,
//       kKeyTotalFat,
//       kKeySaturated,
//       kKeySodium,
//       kKeyPotassium,
//       kKeyIngredients,
//       kKeyNutritionalInsights,
//       kKeyIsFood,
//     ];
//
//     for (var key in keys) {
//       if (appData.hasData(key)) {
//         appData.remove(key);
//       }
//     }
//   }
//
//   ///================== Retake =================================================
//   Future<void> _retakePhoto(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source, imageQuality: 90);
//
//     if (pickedFile == null || !mounted) return;
//
//     ///================== loading dialog ==============================
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => const Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CircularProgressIndicator(color: AppColors.c87B842, strokeWidth: 5),
//             SizedBox(height: 24),
//             Text("Analyzing your meal...",
//                 style: TextStyle(color: AppColors.c87B842, fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//
//     try {
//       // old data remove
//       _clearAllFoodScanData();
//
//       // new data
//       setState(() {
//         _currentImagePath = pickedFile.path;
//       });
//
//       // API
//       await foodScanPostRxObj.postFoodScanApi(image: File(pickedFile.path));
//
//       //  UI Update
//       setState(() {});
//     } catch (e) {
//       log("API Error (silent): $e");
//     } finally {
//       if (mounted) Navigator.pop(context);
//     }
//   }
//
//   Future<void> _saveLog() async {
//     if (_isSaving) return;
//     setState(() => _isSaving = true);
//
//     try {
//       final imageFile = File(_currentImagePath);
//       if (!await imageFile.exists()) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Image not found!")),
//         );
//         return;
//       }
//
//       final takenAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
//
//       ///============= kKeyIngredients Map jsonEncode===========================
//       final Map<String, dynamic> ingredientMap =
//           Map<String, dynamic>.from(appData.read(kKeyIngredients) ?? {});
//
//       final List<dynamic> insights =
//           appData.read(kKeyNutritionalInsights) ?? [];
//
//       log("Sending ingredient_breakdown: ${jsonEncode(ingredientMap)}");
//
//       await foodStoreRxObj.saveFoodRecord(
//         image: imageFile,
//         food_name: appData.read(kKeyFoodName) ?? "Unknown Food",
//         total_estimated_calories:
//             (appData.read(kKeyTotalCalories) ?? 0).toString(),
//         carbs_percentage: appData.read(kKeyCarbsPercentage) ?? "0%",
//         carbs_in_gm: appData.read(kKeyCarbsInGm) ?? "0g",
//         protein_percentage: appData.read(kKeyProteinPercentage) ?? "0%",
//         protein_in_gm: appData.read(kKeyProteinInGm) ?? "0g",
//         fat_percentage: appData.read(kKeyFatPercentage) ?? "0%",
//         fat_in_gm: appData.read(kKeyFatInGm) ?? "0g",
//         protein: appData.read(kKeyProtein) ?? "0g",
//         total_carbs: appData.read(kKeyTotalCarbs) ?? "0g",
//         fiber: appData.read(kKeyFiber) ?? "0g",
//         sugar: appData.read(kKeySugar) ?? "0g",
//         total_fat: appData.read(kKeyTotalFat) ?? "0g",
//         saturated: appData.read(kKeySaturated) ?? "0g",
//         sodium: appData.read(kKeySodium) ?? "0mg",
//         potassium: appData.read(kKeyPotassium) ?? "0mg",
//         ingredient_breakdown: jsonEncode(ingredientMap),
//         nutritional_insights: jsonEncode(insights),
//         taken_at: takenAt,
//         notes: _noteController.text.trim(),
//       );
//
//       if (!mounted) return;
//
//       NavigationService.navigateTo(Routes.logFoodEmptyScreen);
//     } catch (e, s) {
//       log("Save failed: $e\n$s");
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Save failed: $e")),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isSaving = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ///==== null-safe values ==========
//     final String foodName = appData.read(kKeyFoodName) ?? "No food detected";
//
//     final ingredientList = appData.read(kKeyIngredients);
//     log("=========>>>>>>>>,,,,,,ingredientList: $ingredientList");
//     return Scaffold(
//       backgroundColor: AppColors.bacroundColorBlack,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ///===================== AppBar========================
//               CustomAppbarWidget(
//                 onTap: () => Navigator.pop(context),
//                 text: 'Log Food',
//                 subtitle: 'ap your meal, get calorie estimates',
//               ),
//
//               UIHelper.verticalSpace(24.h),
//
//               ///========================== Pro Tip===========================
//               Container(
//                 padding: EdgeInsets.all(12.sp),
//                 decoration: BoxDecoration(
//                     color: AppColors.c181818,
//                     borderRadius: BorderRadius.circular(12.r)),
//                 child: Row(children: [
//                   SvgPicture.asset(AppIcons.tipholdicon, height: 20.w),
//                   UIHelper.horizontalSpace(8.w),
//                   Text('Pro Tip: Hold steady for clearer images',
//                       style: TextFontStyle.textStyle14w400cA3A3A3poppins),
//                 ]),
//               ),
//
//               UIHelper.verticalSpace(24.h),
//
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomCamera(
//                           imagePath: _currentImagePath, onRetake: _retakePhoto),
//
//                       UIHelper.verticalSpace(24.h),
//
//                       CustomHoldSteady(
//                         imagePath: _currentImagePath,
//                         onRetake: _retakePhoto,
//                         onAnalyze: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => MealAnalyzeScreen(
//                                   imagePath: _currentImagePath),
//                             ),
//                           );
//                         },
//                       ),
//
//                       UIHelper.verticalSpace(18.h),
//
//                       ///===================== Chicken Widget ========================
//                       CustomChiken(
//                           text: foodName, imagePath: _currentImagePath),
//
//                       UIHelper.verticalSpace(18.h),
//                       const CustomEditPic(),
//
//                       UIHelper.verticalSpace(24.h),
//
//                       Text('Notes',
//                           style: TextFontStyle.textStyle24w600cFFFFFFpoppins
//                               .copyWith(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w500)),
//
//                       UIHelper.verticalSpace(12.h),
//
//                       CustomTextfield(
//                         controller: _noteController,
//                         maxline: 4,
//                         fillColor: AppColors.c181818,
//                         hintText: 'Add notes',
//                         borderRadius: 12.r,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//
//                       UIHelper.verticalSpace(40.h),
//
//                       _isSaving
//                           ? const Center(
//                               child: CircularProgressIndicator(color: AppColors.c87B842))
//                           : CustomButtonWidget(text: 'Save Log', onTap: _saveLog),
//
//                       UIHelper.verticalSpace(30.h),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




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
  String _currentImagePath = "";

  // Add selected meal type
  int _selectedMealIndex = 0; // 0 = Breakfast, 1 = Lunch, 2 = Dinner, 3 = Snack

  // Meal type options with icons
  final List<Map<String, dynamic>> _mealTypes = [
    {
      "icon": Icons.free_breakfast,
      "title": "Breakfast",
    },
    {
      "icon": Icons.lunch_dining,
      "title": "Lunch",
    },
    {
      "icon": Icons.dinner_dining,
      "title": "Dinner",
    },
    {
      "icon": Icons.fastfood,
      "title": "Snack",
    },
  ];

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

      NavigationService.navigateTo(Routes.logFoodEmptyScreen);
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
              CustomAppbarWidget(
                onTap: () => Navigator.pop(context),
                text: 'Log Food',
                subtitle: 'ap your meal, get calorie estimates',
              ),

              UIHelper.verticalSpace(24.h),

              ///========================== Pro Tip===========================
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Row(children: [
                  SvgPicture.asset(AppIcons.tipholdicon, height: 20.w),
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
                      CustomCamera(
                          imagePath: _currentImagePath, onRetake: _retakePhoto),

                      UIHelper.verticalSpace(24.h),

                      CustomHoldSteady(
                        imagePath: _currentImagePath,
                        onRetake: _retakePhoto,
                        onAnalyze: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MealAnalyzeScreen(
                                  imagePath: _currentImagePath),
                            ),
                          );
                        },
                      ),

                      UIHelper.verticalSpace(18.h),

                      ///===================== Meal Type Selection =====================
                      Text('Meal Type',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                              .copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500)),

                      UIHelper.verticalSpace(12.h),

                      /// Meal Type Filter Buttons - GridView
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 3.5, // Adjusted for better button height
                        ),
                        itemCount: _mealTypes.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected = _selectedMealIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedMealIndex = index;
                              });
                              // Here you can save the selected meal type
                              log("Selected meal type: ${_mealTypes[index]["title"]}");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.c87B842
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(30.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.c87B842
                                      : AppColors.c757575,
                                  width: 1.w,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _mealTypes[index]["icon"],
                                      size: 18.sp,
                                      color: isSelected
                                          ? AppColors.c181818
                                          : AppColors.c87B842,
                                    ),
                                    UIHelper.horizontalSpace(8.w),
                                    Text(
                                      _mealTypes[index]["title"],
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected
                                            ? AppColors.c181818
                                            : AppColors.cFFFFFF,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      UIHelper.verticalSpace(18.h),

                      ///===================== Chicken Widget ========================
                      CustomChiken(
                          text: foodName, imagePath: _currentImagePath),

                      UIHelper.verticalSpace(18.h),
                      const CustomEditPic(),

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
                          child: CircularProgressIndicator(color: AppColors.c87B842))
                          : CustomButtonWidget(text: 'Save Log', onTap: _saveLog),

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