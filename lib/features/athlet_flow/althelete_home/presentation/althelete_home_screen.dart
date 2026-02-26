import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_calander.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_circular_progress.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_energy_level.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_logactivity.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_weeks_to_go.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

import '../widget/custom_send.dart';



class AltheleteHomeScreen extends StatefulWidget {
  const AltheleteHomeScreen({super.key});

  @override
  State<AltheleteHomeScreen> createState() => _AltheleteHomeScreenState();
}

class _AltheleteHomeScreenState extends State<AltheleteHomeScreen> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.restbacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w,),
            child: Column(
              children: [
                CustomWeeksToGo(
                  onProfileTap: () {
                    NavigationService.navigateTo(Routes.myProfileSettingScreenAthlet);
                    log("=============Profile Icon Click and go to myProfileSettingScreenAthlet");

                  },
                    profileImageAsset: AppImages.logo225,
                    title: 'LET S GRIND, ALEX. NO EXCUSES TODAY.'),
                UIHelper.verticalSpace(18.h),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        CustomCircularProgress(title: 'RACE READINESS'),
                        UIHelper.verticalSpace(18.h),

                        CustomCalander(
                          onDateSelected: (date) {
                            print("Selected date: $date");
                          },
                          selectedColor: AppColors.orangeColor,
                          textColor: AppColors.cFFFFFF,
                          unselectedTextColor: AppColors.cBABABA,
                        ),
                        UIHelper.verticalSpace(18.h),

                        CustomEnergyLevel(title: 'Energy level:'),
                        UIHelper.verticalSpace(18.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomLogactivity(
                              onTap: (){NavigationService.navigateTo(Routes.logSupplementScreen);},
                              icon: SvgPicture.asset(AppIcons.logTableticon),
                              subtitle: 'Record Medication',
                              plusicon: SvgPicture.asset(
                                AppIcons.pluseadd,
                                color: AppColors.cFFFFFF,
                                height: 24.h,
                              ),
                              title: 'Log Supplement',
                            ),
                            UIHelper.horizontalSpace(20.w),

                            CustomLogactivity(
                              onTap: (){NavigationService.navigateTo(Routes.athletLogFoodEmptyScreen);},
                              // onTap: (){NavigationService.navigateTo(Routes.logFoodEmptyScreen);},
                              icon: SvgPicture.asset(AppIcons.logfoodicon),
                              subtitle: 'Track Nutrition',
                              plusicon: SvgPicture.asset(
                                AppIcons.pluseadd,
                                height: 24.h,
                                color: AppColors.cFFFFFF,
                              ),
                              title: 'Log Food',
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(20.h),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CustomLogactivity(
                              onTap: (){NavigationService.navigateTo(Routes.logSleepScreen);},

                              icon: SvgPicture.asset(AppIcons.logsleepicon),
                              subtitle: 'Sync your steps',
                              plusicon: SvgPicture.asset(
                                AppIcons.pluseadd,
                                color: AppColors.cFFFFFF,
                                height: 24.h,
                              ),
                              title: 'Log Sleep',
                            ),
                            UIHelper.horizontalSpace(20.w),

                            CustomLogactivity(
                              onTap: (){NavigationService.navigateTo(Routes.athletLogActivityScreen);},
                              icon: SvgPicture.asset(AppIcons.logactivity),
                              subtitle: 'Add your workout',
                              plusicon: SvgPicture.asset(
                                AppIcons.pluseadd,
                                height: 24.h,
                                color: AppColors.cFFFFFF,
                              ),
                              title: 'Log Activity',
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(18.h),

                       CustomSend(),
                        UIHelper.verticalSpace(20.h),




                      ],
                    ),
                  ),
                )
              ]),
          ),
              )));
  }
}




