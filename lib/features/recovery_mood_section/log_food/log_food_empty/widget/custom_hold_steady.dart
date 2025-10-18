
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custo_retake.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/presentation/meal_analyze_screen.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomHoldSteady extends StatelessWidget {
  const CustomHoldSteady({
    super.key,
    required this.imagePath,
    required this.onRetake,
  });

  final String imagePath;
  final Future<void> Function(ImageSource source) onRetake;

  void _showPickOptions(BuildContext context) {
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
                leading:  Icon(Icons.camera_alt,color:  AppColors.c87B842,),
                title:  Text("Camera",  style: TextStyle(color: AppColors.c87B842 )),
                onTap: () {
                  Navigator.pop(ctx);
                  onRetake(ImageSource.camera);
                },
              ),
              ListTile(
                leading:  Icon(Icons.photo, color:  AppColors.c87B842),
                title:  Text("Gallery", style: TextStyle(color: AppColors.c87B842 )),
                onTap: () {
                  Navigator.pop(ctx);
                  onRetake(ImageSource.gallery);
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
          imagePath.isNotEmpty
              ? ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(
              File(imagePath),
              height: 84.h,
              width: 84.h,
              fit: BoxFit.cover,
            ),
          )
              : Image.asset(AppImages.retakeimage, height: 84.h),
          UIHelper.horizontalSpace(16.w),
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _showPickOptions(context),
                  child: CustomRetake(
                    borderColor: Border.all(color: AppColors.c87B842),
                    color: AppColors.c181818,
                    text: 'Retake',
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MealAnalyzeScreen(imagePath: imagePath),
                      ),
                    );
                  },
                  child: CustomRetake(
                    color: AppColors.c87B842,
                    textStyle: TextFontStyle.textStyle20w700c000000poppins
                        .copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    text: 'Analyze Now',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
