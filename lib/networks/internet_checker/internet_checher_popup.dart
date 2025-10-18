import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../assets_helper/app_colors.dart';
import '../../assets_helper/app_fonts.dart';


void InternetConnectionPopup(BuildContext context, VoidCallback onRetry) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          height: 180.h,
          padding: EdgeInsets.all(12.sp),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wifi_off,
                color: Colors.red,
                size: 40.sp,
              ),
              SizedBox(height: 10),
              Text(
                'No Internet Connection found. \nCheck your connection & try again.',
                style: TextFontStyle.textStyle14w400c333333,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onRetry();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(color: AppColors.c00AA4D),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
