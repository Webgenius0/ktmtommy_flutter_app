import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class CustomButtonWidget extends StatelessWidget {
  final DecorationImage? image;
  final String text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Widget? icon;
  final Widget? child;
  final bool isLoading;

  const CustomButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.image,
    this.textStyle,
    this.icon,
    this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 56.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          image: image ??
              DecorationImage(
                image: AssetImage(AppImages.buttonBackground),
                fit: BoxFit.cover,
              ),
        ),
        child: Center(
          child: child ??
              (isLoading
                  ? SizedBox(
                      height: 24.h,
                      width: 24.w,
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          icon!,
                          UIHelper.horizontalSpace(10.w),
                        ],
                        Text(
                          text,
                          style: textStyle ??
                              TextFontStyle.textStylePoppins.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
