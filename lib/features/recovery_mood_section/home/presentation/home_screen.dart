import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
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
                      onTap: () {

                        NavigationService.navigateTo(Routes.myProfileSettingScreen);
                      },
                      title: 'My Balance Day'),
                ],
              ),
            ),
            UIHelper.verticalSpace(24.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///===========Log Tablet Section========================
                        CustomLoogFood(
                          onTap: () {
                            log("========>>>>>>>>>Log Tablet Clicked go to logTabletScreen");
                            NavigationService.navigateTo(Routes.logTabletScreen);
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
                        ///================Log Food Section=====================
                        CustomLoogFood(
                          onTap: () {
                            log("========>>>>>>>>>Log Food Clicked go to logFoodEmptyScreen");
                            NavigationService.navigateTo(Routes.logFoodEmptyScreen);
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
                    ///====Tablet, Food, Steps, Activity Section================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///==============Log Steps Section=====================
                        CustomLoogFood(
                          onTap: () {
                            log("========>>>>>>>>>Log Steps Clicked go to logStepsScreen");
                            NavigationService.navigateTo(Routes.logStepsScreen);
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
                        ///============Log Activity Section ===================
                        CustomLoogFood(
                          onTap: () {
                            log("========>>>>>>>>>Log Food Clicked go to logActivityScreen");
                            NavigationService.navigateTo(Routes.logActivityScreen);
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
                    UIHelper.verticalSpace(44.w),
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
