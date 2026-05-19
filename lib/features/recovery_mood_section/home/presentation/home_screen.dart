 import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/custom_loog_food.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/custom_time_line.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/tbi_recovery.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ///================= MEDICINE DIALOG =================
  void showMedicineDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.bacroundColorBlack,
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: AppColors.c5E5E5E.withOpacity(.3),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                ///=========== TOP IMAGE ===========
                Image.asset(
                  AppImages.logo225,
                  height: 70.h,
                ),

                UIHelper.verticalSpace(18.h),

                ///=========== TITLE ===========
                Text(
                  "Log Medicines",
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                UIHelper.verticalSpace(28.h),

                ///=========== LOG PRESCRIBED ===========
                customDialogCard(
                  onTap: () {
                    Navigator.pop(context);

                    log("Log Prescribed Medicine");
                    NavigationService.navigateTo(Routes.myMedicinesScreen);
                  },
                  icon: Icons.add,
                  iconBg: const Color(0xffA6FF00),
                  title: "Log Prescribed Medicine",
                  subtitle: "Add a new medicine to your schedule",
                ),

                UIHelper.verticalSpace(18.h),

                ///=========== LOG TABLET ===========
                customDialogCard(
                  onTap: () {
                    Navigator.pop(context);

                    log("Log Tablet");

                    NavigationService.navigateTo(
                      Routes.logTabletScreen,
                    );
                  },
                  icon: Icons.grid_view_rounded,
                  iconBg: Colors.red,
                  title: "Log Tablet",
                  subtitle: "Record Medication",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///================= CUSTOM DIALOG CARD =================
  Widget customDialogCard({
    required VoidCallback onTap,
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 18.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff121212),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: const Color(0xffA6FF00),
            width: 1,
          ),
        ),
        child: Row(
          children: [

            ///=========== ICON ===========
            Container(
              height: 46.h,
              width: 46.w,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22.sp,
              ),
            ),

            UIHelper.horizontalSpace(14.w),

            ///=========== TEXT ===========
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  UIHelper.verticalSpace(4.h),

                  Text(
                    subtitle,
                    style: TextFontStyle.textStyle14w500c242424.copyWith(
                      color: Colors.white38,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  TBIRecovery(
                    widget: Image.asset(AppImages.logo225),
                    onTap: () {
                      NavigationService.navigateTo(
                        Routes.myProfileSettingScreen,
                      );
                    },
                    title: 'My Balance Day',
                  ),
                ],
              ),
            ),

            UIHelper.verticalSpace(24.h),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ///=========== LOG TABLET =================
                        CustomLoogFood(
                          onTap: () {

                            /// OPEN DIALOG
                            showMedicineDialog();

                          },
                          icon: SvgPicture.asset(AppIcons.logTableticon),
                          subtitle: 'Record Medication',
                          plusicon: SvgPicture.asset(
                            AppIcons.pluseadd,
                            color: AppColors.c757575,
                            height: 24.h,
                          ),
                          title: 'Log Tablet',
                        ),

                        UIHelper.horizontalSpace(20.w),

                        ///=========== LOG FOOD =================
                        CustomLoogFood(
                          onTap: () {
                            log(
                              "========>>>>>>>>>Log Food Clicked",
                            );

                            NavigationService.navigateTo(
                              Routes.logFoodEmptyScreen,
                            );
                          },
                          icon: SvgPicture.asset(AppIcons.logfoodicon),
                          subtitle: 'Track Nutrition',
                          plusicon: SvgPicture.asset(
                            AppIcons.pluseadd,
                            height: 24.h,
                            color: AppColors.c757575,
                          ),
                          title: 'Log Food',
                        ),
                      ],
                    ),

                    UIHelper.verticalSpace(20.h),

                    ///=========== SECOND ROW =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ///=========== LOG STEPS =================
                        CustomLoogFood(
                          onTap: () {
                            NavigationService.navigateTo(
                              Routes.logStepsScreen,
                            );
                          },
                          icon: SvgPicture.asset(AppIcons.logSteps),
                          subtitle: 'Sync your steps',
                          plusicon: SvgPicture.asset(
                            AppIcons.pluseadd,
                            color: AppColors.c757575,
                            height: 24.h,
                          ),
                          title: 'Log Steps',
                        ),

                        UIHelper.horizontalSpace(20.w),

                        ///=========== LOG ACTIVITY =================
                        CustomLoogFood(
                          onTap: () {
                            NavigationService.navigateTo(
                              Routes.logActivityScreen,
                            );
                          },
                          icon: SvgPicture.asset(AppIcons.logactivity),
                          subtitle: 'Add your workout',
                          plusicon: SvgPicture.asset(
                            AppIcons.pluseadd,
                            height: 24.h,
                            color: AppColors.c757575,
                          ),
                          title: 'Log Activity',
                        ),
                      ],
                    ),

                    UIHelper.verticalSpace(24.h),

                    Text(
                      'Today’s Timeline',
                      style:
                      TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    UIHelper.verticalSpace(12.h),

                    CustomTimeLine(
                      title: 'Morning Medication',
                      subtitle: 'Completed',
                      icon: SvgPicture.asset(AppIcons.logTableticon),
                      morningText: 'Morning Medication',
                      amText: '8:00 AM',
                    ),

                    UIHelper.verticalSpace(18.h),

                    CustomTimeLine(
                      title: 'Lunch',
                      subtitle: 'Completed',
                      icon: SvgPicture.asset(AppIcons.logfoodicon),
                      morningText: 'Lunch',
                      amText: '12:30 PM',
                    ),

                    UIHelper.verticalSpace(18.h),

                    CustomTimeLine(
                      color: AppColors.c5E5E5E,
                      title: 'Morning Medication',
                      subtitle: 'Upcoming',
                      icon: SvgPicture.asset(AppIcons.logSteps),
                      morningText: 'Walk Outside',
                      amText: '2:00 PM',
                    ),

                    UIHelper.verticalSpace(18.h),

                    CustomTimeLine(
                      color: AppColors.c5E5E5E,
                      title: 'Evening Exercise',
                      subtitle: 'Completed',
                      icon: SvgPicture.asset(AppIcons.logactivity),
                      morningText: 'Evening Exercise',
                      amText: '5:30 PM',
                    ),

                    UIHelper.verticalSpace(44.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}