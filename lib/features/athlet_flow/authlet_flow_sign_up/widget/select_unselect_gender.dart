import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';





class SelectUnselectGender extends StatelessWidget {
  final String text;
  final bool isSelected;
  final  VoidCallback? onTap;

  const SelectUnselectGender({
    super.key, required this.text, this.onTap, required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isSelected ? AppColors.orangeColor : AppColors.c5E5E5E,
              //color:  Color(0xFF87B842)
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Text(
            textAlign: TextAlign.center,
            maxLines: 1,
            text,
            style:  TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp
            )
        ),
      ),
    );
  }
}
