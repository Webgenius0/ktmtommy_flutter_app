

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
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/presentation/athlet_log_food_scan_one_screen.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/model/get_all_food_model.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import '../../../../../helpers/navigation_service.dart' show NavigationService;
import '../widget/custom_dotted.dart';

class AthletLogFoodEmptyScreen extends StatefulWidget {
  const AthletLogFoodEmptyScreen({super.key});

  @override
  State<AthletLogFoodEmptyScreen> createState() =>
      _AthletLogFoodEmptyScreenState();
}

class _AthletLogFoodEmptyScreenState extends State<AthletLogFoodEmptyScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isAnalyzing = false;

  // Add selected filter index
  int _selectedFilterIndex = 0; // 0 = All, 1 = Breakfast, 2 = Lunch, 3 = Dinner

  // Filter options with icons
  final List<Map<String, dynamic>> _filterOptions = [
    {
      "icon": Icons.filter_list, // Using a generic icon for "All"
      "title": "All"
    },
    {
      "icon": Icons.free_breakfast, // Coffee/breakfast icon
      "title": 'Breakfast',
    },
    {
      "icon": Icons.lunch_dining, // Lunch icon
      "title": 'Lunch',
    },
    {
      "icon": Icons.dinner_dining, // Dinner icon
      "title": 'Dinner'
    },
  ];

  Future<void> _takePhoto() async {
    await _pickAndAnalyze(ImageSource.camera);
  }

  Future<void> _pickImage() async {
    await _pickAndAnalyze(ImageSource.gallery);
  }

  ///=============PickAnd Analyze===============================================
  Future<void> _pickAndAnalyze(ImageSource source) async {
    if (_isAnalyzing) return;

    setState(() => _isAnalyzing = true);

    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null || !mounted) {
        setState(() => _isAnalyzing = false);
        return;
      }
      await foodScanPostRxObj.postFoodScanApi(image: File(image.path));

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AthletLogFoodScanOneScreen(imagePath: image.path),
        ),
      );
      log("=========>>>>>>>>>>>API Success → Going to AthletLogFoodScanOneScreen");
    } catch (e) {
      log("Food scan error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Analysis failed: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isAnalyzing = false);
      }
    }
  }

  ///================ShowImageSourceOption======================================
  void _showImageSourceOptions() {
    showModalBottomSheet(
      backgroundColor: AppColors.c181818,
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera, color: AppColors.orangeColor),
            title: Text('Take Photo',
                style: TextStyle(color: AppColors.orangeColor)),
            onTap: () {
              Navigator.pop(context);
              _takePhoto();
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: AppColors.orangeColor),
            title: Text(
              'Choose from Gallery',
              style: TextStyle(color: AppColors.orangeColor),
            ),
            onTap: () {
              Navigator.pop(context);
              _pickImage();
            },
          ),
        ],
      ),
    );
  }

  ///======Init State============================================================
  @override
  void initState() {
    getAllFoodRxObj.getAllFoodApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///============AppBar Section=================================
                  ArrowButtonAtheleteFlow(
                    text: 'Log Food',
                    subtitle: 'Snap your meal, get calorie estimates',
                    onTap: () => NavigationService.goBack,
                  ),
                  UIHelper.verticalSpace(32.h),

                  ///===========Image Section===================================
                  GestureDetector(
                    onTap: _isAnalyzing ? null : _showImageSourceOptions,
                    child: CustomDotted(
                      title: _isAnalyzing
                          ? 'Analyzing your meal...'
                          : 'Take a photo to track your meal',
                    ),
                  ),
                  UIHelper.verticalSpace(32.h),

                  ///===========Filter Buttons Section (Added from design)=====
                  Container(
                    height: 40.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filterOptions.length,
                      separatorBuilder: (context, index) =>
                          UIHelper.horizontalSpace(12.w),
                      itemBuilder: (context, index) {
                        bool isSelected = _selectedFilterIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFilterIndex = index;
                            });
                            // Here you can add logic to filter meals based on selection
                            // For example: filter by meal type (Breakfast, Lunch, Dinner)
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.orangeColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.orangeColor
                                    : AppColors.c757575,
                                width: 1.w,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _filterOptions[index]["icon"],
                                    size: 16.sp,
                                    color: isSelected
                                        ? AppColors.c181818
                                        : AppColors.cFFFFFF,
                                  ),
                                  UIHelper.horizontalSpace(6.w),
                                  Text(
                                    _filterOptions[index]["title"],
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
                  ),
                  UIHelper.verticalSpace(24.h),

                  ///===========Recent Meal History Header=====================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Recent Meal History',
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                  .copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500)),
                          Text('View and manage your food logs',
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                  .copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70)),
                        ],
                      ),
                      // Optional: Add a "View All" button if needed
                      TextButton(
                        onPressed: () {
                          // Navigate to all meals history
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50.w, 30.h),
                        ),
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: AppColors.orangeColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(12.h),

                  ///========Recent Meal Food card==============================
                  StreamBuilder<GetAllFoodModel>(
                    stream: getAllFoodRxObj.GetAllFood,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.orangeColor,
                            ));
                      }
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text("Something went wrong"));
                      }
                      if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                        return const Center(child: Text("No meals found"));
                      }

                      final List<Datum> meals = snapshot.data!.data!;

                      // Optional: Filter meals based on selected filter
                      List<Datum> filteredMeals = meals;
                      if (_selectedFilterIndex > 0) {
                        // Add your filtering logic here based on meal type
                        // For example: filteredMeals = meals.where((meal) => meal.mealType == _filterOptions[_selectedFilterIndex]["title"]).toList();
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredMeals.length,
                        separatorBuilder: (context, index) =>
                            UIHelper.verticalSpace(12.h),
                        itemBuilder: (context, index) {
                          final meal = filteredMeals[index];

                          String formattedTime = "—";
                          if (meal.takenAt != null &&
                              meal.takenAt!.isNotEmpty) {
                            try {
                              final DateTime dateTime =
                              DateTime.parse(meal.takenAt!);
                              formattedTime =
                                  DateFormat('h:mm a').format(dateTime);
                            } catch (e) {
                              formattedTime = meal.takenAgo ?? "—";
                            }
                          } else {
                            formattedTime = meal.takenAgo ?? "—";
                          }

                          return GestureDetector(
                            onTap: () {
                              log("===============Tapped on meal: ${meal.foodName}");
                              log("============ Id ${meal.id}");
                              log("==============athletsMealScreen");
                              // NavigationService.navigateTo(
                              //     Routes.athletsMealScreen);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 13.h),
                              decoration: ShapeDecoration(
                                color: AppColors.c181818,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                      meal.imageUrl ?? "",
                                      height: 94.h,
                                      width: 94.h,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            "assets/placeholder_food.jpg",
                                            height: 94.h,
                                            width: 94.h,
                                            fit: BoxFit.cover);
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Container(
                                          height: 94.h,
                                          width: 94.h,
                                          color: Colors.grey[800],
                                          child: const Center(
                                              child: CircularProgressIndicator(
                                                  color:
                                                  AppColors.orangeColor)),
                                        );
                                      },
                                    ),
                                  ),
                                  UIHelper.horizontalSpace(16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 145.w,

                                                  child: Text(
                                                    meal.foodName ?? "Just now",
                                                    style: TextFontStyle
                                                        .textStyle24w600cFFFFFFpoppins
                                                        .copyWith(fontSize: 18.sp),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                UIHelper.verticalSpace(8.h),
                                              ],
                                            ),
                                            IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.white,))
                                          ],
                                        ),
                                        Text(
                                          "${meal.totalEstimatedCalories ?? 0} Cal",
                                          style: TextFontStyle
                                              .textStyle24w600cF55216poppins
                                              .copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        UIHelper.verticalSpace(8.h),
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppIcons.clcokicon,
                                                height: 16.h),
                                            UIHelper.horizontalSpace(4.w),
                                            Text(
                                              formattedTime,
                                              style: TextFontStyle
                                                  .textStyle16w400c757575poppins
                                                  .copyWith(fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  UIHelper.verticalSpace(20.h), // Add bottom padding
                ],
              ),
            ),

            ///================Analyzing your meal...Section====================
            if (_isAnalyzing)
              Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                          color: AppColors.orangeColor),
                      const SizedBox(height: 20),
                      Text(
                        "Analyzing your meal...",
                        style: TextFontStyle.textStyle14w400c87B842poppins
                            .copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.orangeColor),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),

      floatingActionButton: Container(
        width: 60.w,
        height: 68.w,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(
                side: BorderSide(
                  color: AppColors.c87B842,
                )),
            onTap: () {
              NavigationService.navigateTo(Routes.athletDailySummeryScreen);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_note_sharp,
                  color: AppColors.cFFFFFF,
                  size: 22.sp,
                ),
                SizedBox(height: 2.h),
                Text(
                  "Summery",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.cFFFFFF,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),


    );
  }

//===================================== Galary or Camera ================================//
}