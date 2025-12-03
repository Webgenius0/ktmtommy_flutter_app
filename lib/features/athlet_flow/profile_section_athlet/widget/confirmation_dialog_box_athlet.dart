import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'dart:ui';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final Color confirmButtonColor;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmButtonText,
    required this.onConfirm,
    required this.onCancel,
    this.confirmButtonColor = AppColors.cED5050,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 1.0),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: AppColors.c181818,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                title,
                style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                  fontSize: 24.sp,
                  color: AppColors.primaryColor,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(12.h),

              // Message
              Text(
                message,
                style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                  color: AppColors.c757575,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              UIHelper.verticalSpace(32.h),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      borderColor: AppColors.c87B842,
                      name: "Cancel",
                      onCallBack: onCancel,
                      context: context,
                      color: Colors.transparent,
                      height: 44.h,
                      borderRadius: 999.r,
                      textStyle:
                          TextFontStyle.textStyle16w400c757575poppins.copyWith(
                        color: AppColors.c87B842,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpace(12.w),
                  Expanded(
                    child: CustomButton(
                      name: confirmButtonText,
                      onCallBack: onConfirm,
                      context: context,
                      color: AppColors.c87B842,
                      height: 44.h,
                      borderRadius: 999.r,
                      textStyle:
                          TextFontStyle.textStyle16w400c757575poppins.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
