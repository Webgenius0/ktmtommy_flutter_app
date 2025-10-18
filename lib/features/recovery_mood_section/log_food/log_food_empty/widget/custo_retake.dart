import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';







class CustomRetake extends StatelessWidget {
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final BoxBorder? borderColor;

  const CustomRetake({
    super.key,
    required this.text,
    this.color,
    this.textStyle, this.onTap, this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 11.h),
        decoration: BoxDecoration(
            color: color ?? AppColors.c181818,
            borderRadius: BorderRadius.circular(28.r),
           border:borderColor?? Border.all(color: AppColors.c87B842,width: 2)
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}