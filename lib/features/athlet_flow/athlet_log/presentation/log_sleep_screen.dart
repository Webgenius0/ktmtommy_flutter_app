
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/custom_night_day_time.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/recent_sleep.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class LogSleepScreen extends StatefulWidget {
  const LogSleepScreen({super.key});

  @override
  State<LogSleepScreen> createState() => _LogSleepScreenState();
}
class _LogSleepScreenState extends State<LogSleepScreen> {



///====================================================///


  final List<String> icon = [
    'assets/icons/signureicon.svg',
    'assets/icons/signureicon.svg',
  ];

  final List<String> title = ['10:30 pm-06:30 am', '10:30 pm-06:30 am'];
  final List<String> subtitle = ['Yesterday', 'Yesterday'];

  final List<String> mg = ['6h 15m', '6h 15m'];

  final List<String> deleteIcon = [
    'assets/icons/deleteicon.svg',
    'assets/icons/deleteicon.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.restbacroundimage),
                fit: BoxFit.cover
            )
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              children: [
                ArrowButtonAtheleteFlow(
                  text: 'Log Sleep',
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
                UIHelper.verticalSpace(24.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

//============================= Night And Day Custom ========================================//
                        CustomNightDayTime(),
                        UIHelper.verticalSpace(18.h),



      //==================================== Custom ====================================//
                        Text(
                          'Recent Sleep log',
                          style:  TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                            fontSize: 18.sp,fontWeight: FontWeight.w500
                          )
                        ),
                        UIHelper.verticalSpace(12.h),


//========================================= Recenet Sleep ================================//
                        RecentSleep(
                          title: title,
                          icon: icon,
                          mg: mg,
                          subtitle: subtitle,
                          deleteIcon: deleteIcon,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

