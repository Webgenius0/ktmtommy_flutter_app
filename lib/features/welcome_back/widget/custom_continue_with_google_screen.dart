import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomContinueWithGoogle extends StatelessWidget {
  final Widget? icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;


  const CustomContinueWithGoogle({
    super.key,
   required this.title, this.icon, required this.isSelected, required this.onTap,

  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: ShapeDecoration(
          color: AppColors.c181818,
          shape: RoundedRectangleBorder(
           side: BorderSide(width: 2.w,   color: isSelected ? AppColors.c87B842 : AppColors.cEBECF0),
            borderRadius: BorderRadius.circular(28.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SvgPicture.asset(AppIcons.googleicon, width: 24.w, height: 24.w),
            UIHelper.horizontalSpace(10.w),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
