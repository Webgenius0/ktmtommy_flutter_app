import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/presentation/athlet_meal_analyze_screen.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custo_retake.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/presentation/meal_analyze_screen.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AthletCustomHoldSteady extends StatelessWidget {
  const AthletCustomHoldSteady({
    super.key,
    required this.imagePath,
    this.onRetake,
    this.onAnalyze,
  });

  final String imagePath;


  final Future<void> Function(ImageSource source)? onRetake;

  final VoidCallback? onAnalyze;

  void _showPickOptions(BuildContext context) {
    if (onRetake == null) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.c181818,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.orangeColor),
                title: const Text("Camera", style: TextStyle(color: AppColors.orangeColor)),
                onTap: () {
                  Navigator.pop(ctx);
                  onRetake!(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: AppColors.orangeColor),
                title: const Text("Gallery", style: TextStyle(color: AppColors.orangeColor)),
                onTap: () {
                  Navigator.pop(ctx);
                  onRetake!(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preview image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: imagePath.isNotEmpty
                ? Image.file(
              File(imagePath),
              height: 84.h,
              width: 84.h,
              fit: BoxFit.cover,
            )
                : Image.asset(AppImages.retakeimage, height: 84.h, width: 84.h),
          ),

          UIHelper.horizontalSpace(16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ====== Retake Button ======
                GestureDetector(
                  onTap: onRetake != null ? () => _showPickOptions(context) : null,
                  child: CustomRetake(
                    borderColor: Border.all(color: AppColors.orangeColor),
                    color: AppColors.c181818,
                    text: 'Retake',
                  ),
                ),

                UIHelper.verticalSpace(12.h),

                // ====== Analyze Now Button ======
                GestureDetector(
                  onTap: () {
                    if (onAnalyze != null) {
                      onAnalyze!();
                    } else {
                      // Default fallback
                      log("=======>>>>>>>>>>>>>>>Go to MealAnalyzeScreen");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AthletMealAnalyzeScreen(imagePath: imagePath),
                        ),
                      );
                    }
                  },
                  child: CustomRetake(
                    color: AppColors.orangeColor,
                    textStyle: TextFontStyle
                        .textStyle20w700c000000poppins
                        .copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    text: 'Analyze Now',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
