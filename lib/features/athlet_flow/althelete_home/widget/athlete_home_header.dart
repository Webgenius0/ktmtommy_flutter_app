import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AthleteHomeHeader extends StatelessWidget {
  final String title;
  final String goalText;
  final VoidCallback onProfileTap;

  const AthleteHomeHeader({
    super.key,
    required this.title,
    required this.goalText,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                  fontSize: 22.sp,
                  height: 1.1,
                  letterSpacing: 0.5,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.c181818,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.orangeColor,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      goalText,
                      style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        UIHelper.horizontalSpace(12.w),
        GestureDetector(
          onTap: onProfileTap,
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE50914),
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: AssetImage(AppImages.logo225),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
