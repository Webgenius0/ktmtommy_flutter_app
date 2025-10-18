import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';




class CustomSelectSupport extends StatelessWidget {
  final String title;
  final bool isSelected;
  const CustomSelectSupport({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.sp),
      decoration: ShapeDecoration(
        color: isSelected ? AppColors.c111111 : AppColors.c1C1C1C,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: isSelected ? AppColors.orangeColor : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextFontStyle.textStyle24w600cF55216poppins.copyWith(
              color: isSelected ? AppColors.orangeColor : AppColors.cFFFFFF,
            ),
          ),
        ],
      ),
    );
  }
}
