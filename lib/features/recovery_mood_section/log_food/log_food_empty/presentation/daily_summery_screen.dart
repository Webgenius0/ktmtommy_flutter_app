
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_shimmer_image.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/log_activity_calander.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/model/daily_food_summary_model.dart';

class DailySummeryScreen extends StatefulWidget {
  const DailySummeryScreen({super.key});

  @override
  State<DailySummeryScreen> createState() => _DailySummeryScreenState();
}

class _DailySummeryScreenState extends State<DailySummeryScreen> {
  final TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd MMM yyyy').format(selectedDate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchSummary();
    });
  }

  void _fetchSummary() {
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    dailyFoodSummaryRxObj.getDailyFoodSummary(dateStr);
  }

  IconData _getMealTypeIcon(String? mealType) {
    switch (mealType?.toLowerCase()) {
      case 'breakfast':
        return Icons.free_breakfast;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      case 'snack':
      default:
        return Icons.fastfood;
    }
  }

  String _capitalize(String? s) {
    if (s == null || s.isEmpty) return "";
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.bacroundColorBlack,
        body: Column(
          children: [
            UIHelper.verticalSpace(45),
            CustomAppbarWidget(
              onTap: () => NavigationService.goBack,
              text: 'Daily Summary',
              subtitle: 'Review your daily food intake',
            ),
            UIHelper.verticalSpace(24),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select Date', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                      UIHelper.verticalSpace(4.h),
                      LogActivityCalander(
                        controller: dateController,
                        hintText: 'dd MMM yyyy',
                        onDateSelected: (DateTime selectedDate) {
                          setState(() {
                            this.selectedDate = selectedDate;
                          });
                          _fetchSummary();
                        },
                      ),
                      UIHelper.verticalSpace(16.h),
                      StreamBuilder<DailyFoodSummaryModel>(
                        stream: dailyFoodSummaryRxObj.dailySummaryStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: CircularProgressIndicator(color: AppColors.c87B842),
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  "Failed to load daily summary",
                                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                ),
                              ),
                            );
                          }
                          final summaryData = snapshot.data?.data;
                          final foods = summaryData?.foods ?? [];
                          final totalCalories = summaryData?.totalCalories?.toString() ?? "0";
                          final itemsLogged = summaryData?.itemsLogged?.toString() ?? "0";

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 153.50.w,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF181818),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xFF454545),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total Calories",
                                          style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(color: Colors.grey),
                                        ),
                                        Text(
                                          totalCalories,
                                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                            color: AppColors.c87B842,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 153.50.w,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF181818),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xFF454545),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Items Logged",
                                          style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(color: Colors.grey),
                                        ),
                                        Text(
                                          itemsLogged,
                                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                            color: AppColors.cFFFFFF,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              UIHelper.verticalSpace(16.h),
                              if (foods.isEmpty)
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 40.h),
                                    child: Text(
                                      "No meals logged for this day",
                                      style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                    ),
                                  ),
                                )
                              else
                                ...foods.map((food) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF181818),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          ShimmerImage(
                                            imageUrl: food.imageUrl ?? personImageUrl,
                                            placeholder: AppImages.placeholderImage,
                                            height: 75,
                                            width: 75,
                                          ),
                                          UIHelper.horizontalSpaceMedium,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        food.foodName ?? "Unknown Food",
                                                        style: TextFontStyle.textStyle16w400c87B842poppins.copyWith(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${food.totalEstimatedCalories ?? 0} Calories",
                                                      style: TextFontStyle.textStyle16w400c87B842poppins.copyWith(
                                                        color: AppColors.c87B842,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.watch_later_outlined,
                                                          color: Colors.grey,
                                                        ),
                                                        UIHelper.horizontalSpace(4),
                                                        Text(
                                                          food.time ?? "12:00 AM",
                                                          style: TextFontStyle.textStyle16w400c5C5C5C,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                UIHelper.verticalSpace(08),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                                  decoration: ShapeDecoration(
                                                    color: const Color(0x33FFB84D),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        _getMealTypeIcon(food.mealType),
                                                        color: Colors.orange,
                                                        size: 16.sp,
                                                      ),
                                                      UIHelper.horizontalSpace(4),
                                                      Text(
                                                        _capitalize(food.mealType),
                                                        style: TextFontStyle.textStyle16w400c5C5C5C.copyWith(
                                                          color: Colors.orange,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            ],
                          );
                        },
                      ),
                      UIHelper.verticalSpace(16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF181818),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFF454545),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.email, color: Colors.white),
                                    UIHelper.horizontalSpace(4),
                                    Text(
                                      "Email Summary",
                                      style: TextFontStyle.textStyle16w400c5C5C5C.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    NavigationService.navigateTo(Routes.dailySummerySettingsScreen);
                                  },
                                  child: const Icon(
                                    Icons.settings,
                                    color: AppColors.c87B842,
                                  ),
                                )
                              ],
                            ),
                            UIHelper.verticalSpace(08),
                            Text(
                              "Configure dietitian email in Settings to enable automatic daily summaries",
                              style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
