// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
// import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
// import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/presentation/meal_analyze_screen.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_camera.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_chiken.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_edit.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_hold_steady.dart';
// import 'package:ktmtommy_apps/helpers/all_routes.dart';
// import 'package:ktmtommy_apps/helpers/navigation_service.dart';
// import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
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
//   late String _currentImagePath;
//   final TextEditingController _noteController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
//   Future<void> _updateImagePath(ImageSource source) async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? photo = await picker.pickImage(source: source);
//       if (photo != null && mounted) {
//         setState(() {
//           _currentImagePath = photo.path;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error picking photo: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bacroundColorBlack,
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomAppbarWidget(
//                   onTap: () => NavigationService.goBack,
//                   text: 'Log Food',
//                   subtitle: 'Snap your meal, get calorie estimates',
//                 ),
//                 UIHelper.verticalSpace(24.h),
//                 Container(
//                   padding: EdgeInsets.all(12.sp),
//                   decoration: BoxDecoration(
//                     color: AppColors.c181818,
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: Row(
//                     children: [
//                       SvgPicture.asset(AppIcons.tipholdicon, height: 20.w),
//                       UIHelper.horizontalSpace(8.w),
//                       Text(
//                         'Pro Tip: Hold steady for clearer images',
//                         style: TextFontStyle.textStyle14w400cA3A3A3poppins,
//                       ),
//                     ],
//                   ),
//                 ),
//                 UIHelper.verticalSpace(24.h),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ///=============Retake Button===========================
//                         CustomCamera(
//                           imagePath: _currentImagePath,
//                           onRetake: _updateImagePath,
//                         ),
//                         UIHelper.verticalSpace(24.h),
//                         ///=================Analyze Now=========================
//                         CustomHoldSteady(
//                           imagePath: _currentImagePath,
//                           onRetake: (source) async {
//
//                             final pickedFile = await ImagePicker().pickImage(source: source);
//                             if (pickedFile != null) {
//                               setState(() {
//                                 _currentImagePath = pickedFile.path;
//                               });
//                             }
//                           },
//                           onAnalyze: () {
//                             log("=======>><<<<<<<<>>Analyze Now Button is Clicked");
//
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => MealAnalyzeScreen(imagePath: _currentImagePath),
//                               ),
//                             );
//                           },
//                         ),
//                         UIHelper.verticalSpace(18.h),
//                         CustomChiken(
//                           text: 'Chicken Rice Bowl',
//                           imagePath: _currentImagePath,
//                         ),
//                         UIHelper.verticalSpace(18.h),
//                         CustomEditPic(),
//                         UIHelper.verticalSpace(24.h),
//                         Text(
//                           'Notes',
//                           style: TextFontStyle.textStyle24w600cFFFFFFpoppins
//                               .copyWith(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         UIHelper.verticalSpace(12.h),
//                         CustomTextfield(
//                           controller: _noteController,
//                           textAlign: TextAlign.start,
//                           fillColor: AppColors.c181818,
//                           maxline: 4,
//                           hintTextSyle: TextFontStyle
//                               .textStyle16w400c757575poppins
//                               .copyWith(
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           hintText: 'Add notes',
//                           style: const TextStyle(color: Colors.white),
//                           borderRadius: 12.r,
//                         ),
//                         UIHelper.verticalSpace(24.h),
//                         CustomButtonWidget(
//                           text: 'Save Log',
//                           onTap: () {
//                             NavigationService.navigateTo(
//                                 Routes.logFoodEmptyScreen);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
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
  late String _currentImagePath;
  final TextEditingController _noteController = TextEditingController();

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


  Future<void> _retakePhoto(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: source,
        imageQuality: 90,
      );

      if (photo != null && mounted) {
        setState(() {
          _currentImagePath = photo.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  // Analyze Now বাটনের কাজ (এখানে API কল + Navigation)
  Future<void> _onAnalyzeNow() async {
    if (_currentImagePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please take a photo first')),
      );
      return;
    }

    try {
      // তোমার API কল এখানে দিবে (যদি থাকে)
      // await foodScanPostRxObj.postFoodScanApi(image: File(_currentImagePath));

      log("Analyze Now Clicked → Going to MealAnalyzeScreen");

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
              // AppBar
              CustomAppbarWidget(
                onTap: () => NavigationService.goBack(),
                text: 'Log Food',
                subtitle: 'Snap your meal, get calorie estimates',
              ),

              UIHelper.verticalSpace(24.h),

              // Pro Tip Box
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

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ১. বড় প্রিভিউ + Retake বাটন (তোমার আগের UI)
                      CustomCamera(
                        imagePath: _currentImagePath,
                        onRetake: _retakePhoto,
                      ),

                      UIHelper.verticalSpace(24.h),

                      // ২. ছোট প্রিভিউ + Retake + Analyze Now (তোমার আগের UI)
                      CustomHoldSteady(
                        imagePath: _currentImagePath,
                        onRetake: _retakePhoto,
                        onAnalyze: _onAnalyzeNow,
                      ),

                      UIHelper.verticalSpace(18.h),

                      // Detected Food Example
                      CustomChiken(
                        text: foodName,
                        imagePath: _currentImagePath,
                      ),

                      UIHelper.verticalSpace(18.h),
                      const CustomEditPic(),

                      UIHelper.verticalSpace(24.h),

                      // Notes Section
                      Text(
                        'Notes',
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
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
                        hintTextSyle: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        style: const TextStyle(color: Colors.white),
                        borderRadius: 12.r,
                      ),

                      UIHelper.verticalSpace(40.h),

                      // Save Log Button
                      CustomButtonWidget(
                        text: 'Save Log',
                        onTap: () {
                          NavigationService.navigateTo(Routes.logFoodEmptyScreen);
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