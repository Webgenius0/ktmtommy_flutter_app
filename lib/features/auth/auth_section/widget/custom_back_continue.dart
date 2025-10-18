
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';

class CustomBackContinue extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final BorderSide? borderSide;

  const CustomBackContinue({
    super.key,
    this.onTap,
    required this.text,
    this.color,
    this.textStyle, this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
          decoration: ShapeDecoration(
            color: color ?? AppColors.c000000,
            shape: RoundedRectangleBorder(
              side: borderSide?? BorderSide(width: 1.w, color: AppColors.cEEE6DA),
              borderRadius: BorderRadius.circular(23.r),
            ),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle ?? TextFontStyle.textStyle20w700cEEE6DApoppins,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
