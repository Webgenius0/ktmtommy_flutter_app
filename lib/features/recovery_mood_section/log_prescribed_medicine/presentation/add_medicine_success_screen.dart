import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AddMedicineSuccessScreen extends StatelessWidget {
  final bool isEdit;
  const AddMedicineSuccessScreen({super.key, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Success icon or graphic
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffA6FF00).withOpacity(0.1),
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  color: const Color(0xffA6FF00),
                  size: 80.sp,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              
              Text(
                isEdit ? 'Medicine Updated\nSuccessfully!' : 'Medicine Added\nSuccessfully!',
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              
              Text(
                'Reminder has been scheduled',
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
              ),
              
              const Spacer(),
              CustomButtonWidget(
                text: 'Continue',
                onTap: () {
                  // Go back to Home Screen
                  NavigationService.navigateTo(Routes.homeScreen);
                },
              ),
              UIHelper.verticalSpace(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
