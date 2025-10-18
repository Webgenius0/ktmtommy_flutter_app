import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets_helper/app_colors.dart';
import '../assets_helper/app_fonts.dart';

Widget CustomButton({
  required String name,
  required VoidCallback onCallBack,
  double? height,
  double? minWidth,
  double? borderRadius,
  Color? color,
  EdgeInsetsGeometry? padding,
  TextStyle? textStyle,
  ImageProvider? prefixImage,
  Icon? iconPrefix,
  ImageProvider? suffixImage,
  required BuildContext context,
  Color? borderColor,
  double? prefixImageSize,
  double elevation = 0.0,
}) {
  return SizedBox(
    height: height ?? 50.h,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        backgroundColor: color ?? AppColors.primaryColor,
        minimumSize: Size(minWidth ?? 170.w, height ?? 55.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          side: BorderSide(color: borderColor ?? AppColors.primaryColor,width: 1),
        ),
        elevation: elevation,
      ),
      onPressed: onCallBack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixImage != null)
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Image(
                image: prefixImage,
                width: prefixImageSize ?? 14.w,
                height: prefixImageSize ?? 14.h,
              ),
            ),
          if (iconPrefix != null)
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: iconPrefix,
            ),
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: textStyle ??
                TextFontStyle.textStyle14w500SecondaryColorPlusJakartaSans.copyWith(
                  color: Colors.white, // Change based on design
                ),
          ),
          if (suffixImage != null)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Image(
                image: suffixImage,
                width: prefixImageSize ?? 14.w,
                height: prefixImageSize ?? 14.h,
              ),
            ),
        ],
      ),
    ),
  );
}
