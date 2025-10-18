import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/custom_loog_food.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';






class NewLogEntryScreen extends StatefulWidget {
  const NewLogEntryScreen({super.key});

  @override
  State<NewLogEntryScreen> createState() => _NewLogEntryScreenState();
}

class _NewLogEntryScreenState extends State<NewLogEntryScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbarWidget(
                onTap: (){NavigationService.goBack;},
                text: 'Log New Activity',
              ),
              UIHelper.verticalSpace(23.h),
              Text(
                'Please select a category from below ',
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,fontWeight: FontWeight.w400
                )
              ),
              UIHelper.verticalSpace(23.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomLoogFood(
                    onTap: (){NavigationService.navigateTo(Routes.logTabletScreen);},
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

                  CustomLoogFood(
                    onTap: (){NavigationService.navigateTo(Routes.logFoodEmptyScreen);},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomLoogFood(
                    onTap: (){NavigationService.navigateTo(Routes.logStepsScreen);},
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

                  CustomLoogFood(
                    onTap: (){NavigationService.navigateTo(Routes.logActivityScreen);},
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




            ],
          ),
        ),
      ),
    );
  }
}
