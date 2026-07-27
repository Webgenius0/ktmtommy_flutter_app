import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/custom_your_all_set.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:lottie/lottie.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/di.dart';

class AllSetScreen extends StatefulWidget {
  const AllSetScreen({super.key});

  @override
  State<AllSetScreen> createState() => _AllSetScreenState();
}

class _AllSetScreenState extends State<AllSetScreen> {
  @override
  Widget build(BuildContext context) {
    String? name = appData.read(kKeyuserFullName);
    String? goal = appData.read(kKRecoveryGoal);
    String? startTime = appData.read(kKeyuserReminderStartTime);
    String? endTime = appData.read(kKeyuserReminderEndTime);

    String reminderText = 'Morning (8 AM - 12 PM)';
    if (startTime != null && endTime != null) {
      if (startTime == '08:00:00') {
        reminderText = 'Morning (8 AM - 12 PM)';
      } else if (startTime == '12:00:00') {
        reminderText = 'Afternoon (12 PM - 5 PM)';
      } else if (startTime == '18:00:00') {
        reminderText = 'Evening (6 PM - 10 PM)';
      } else {
        // Strip seconds if present to make it look clean
        String cleanStart = startTime.split(':').take(2).join(':');
        String cleanEnd = endTime.split(':').take(2).join(':');
        reminderText = '$cleanStart - $cleanEnd';
      }
    }

    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.restbacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              Lottie.asset(
                'assets/lottie/Success.json',
                height: 300.h,
                width: 300.w,
              ),

              Text(
                "You're all set!",
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 32.sp,
                ),
              ),
              UIHelper.verticalSpace(8.h),

              Text(
                'Your Balance Day journey is\nready to begin',
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                  fontSize: 16.sp,
                ),
              ),
              UIHelper.verticalSpace(24.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                decoration: ShapeDecoration(
                  color: AppColors.c181818,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Column(
                  children: [
                    CustomYourAllSet(
                      textStyle: TextFontStyle.textStyle14w400c87B842poppins,
                      title: 'Name',
                      subtitle: name ?? 'Alex Johnson',
                      icon: SvgPicture.asset(
                        AppIcons.usernameicon,
                        height: 20.h,
                      ),
                    ),

                    Divider(color: AppColors.cD1D1D1),

                    UIHelper.verticalSpace(16.h),

                    CustomYourAllSet(
                      textStyle: TextFontStyle.textStyle14w400c87B842poppins,
                      title: 'Goals',
                      subtitle: goal ?? 'Return to work(Part Time)',
                      icon: SvgPicture.asset(AppIcons.liteicon, height: 20.h),
                    ),

                    Divider(color: AppColors.cD1D1D1),
                    UIHelper.verticalSpace(16.h),
                    CustomYourAllSet(
                      textStyle: TextFontStyle.textStyle14w400c87B842poppins,
                      title: 'Daily Reminder',
                      subtitle: reminderText,
                      icon: SvgPicture.asset(
                        AppIcons.notification,
                        height: 20.h,
                      ),
                    ),

                    Divider(color: AppColors.cD1D1D1),
                  ],
                ),
              ),

              UIHelper.verticalSpace(24.h),

              CustomButtonWidget(
                onTap: () {
                  NavigationService.navigateTo(Routes.subscriptionTbiModeScreen);
                },
                text: 'Ready To Go',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
