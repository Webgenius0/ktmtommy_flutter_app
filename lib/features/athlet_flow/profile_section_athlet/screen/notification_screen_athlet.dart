import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/features/athlet_flow/profile_section_athlet/widget/settings_switch_tile_athlet.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/profile_section/widget/settings_switch_tile.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class NotificationScreenAthlet extends StatefulWidget {
  const NotificationScreenAthlet({super.key});

  @override
  State<NotificationScreenAthlet> createState() => _NotificationScreenAthletState();
}

class _NotificationScreenAthletState extends State<NotificationScreenAthlet> {

  bool appNotifications = true;
  bool morning6to10 = false;
  bool morning11to5 = true;
  bool evening6to10 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: Column(
        children: [
          UIHelper.verticalSpace(20.h),
          ///==========Appbar Section===========///
          ArrowButtonAtheleteFlow(
            text: 'Notification',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ///============Notification Section All==========///
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              children: [

                SettingsSwitchTileAthlet(
                  icon: Icons.notifications,
                  iconBackgroundColor: AppColors.c2F2F2F,
                  iconColor: AppColors.cF55216,
                  title: 'App Notifications',
                  subtitle: 'Receive app updates and alerts',
                  value: appNotifications,
                  onChanged: (value) {
                    setState(() {
                      appNotifications = value;
                    });
                  },
                ),

                UIHelper.verticalSpace(20.h),

                SettingsSwitchTileAthlet(
                  icon: Icons.access_time,
                  iconBackgroundColor: AppColors.c2F2F2F,
                  iconColor: AppColors.cF55216,
                  title: 'Daily Reminder',
                  subtitle: 'Morning 6 AM - 10 AM',
                  value: morning6to10,
                  onChanged: (value) {
                    setState(() {
                      morning6to10 = value;
                    });
                  },
                ),

                UIHelper.verticalSpace(20.h),

                SettingsSwitchTileAthlet(
                  icon: Icons.wb_sunny,
                  iconBackgroundColor: AppColors.c2F2F2F,
                  iconColor: AppColors.cF55216,
                  title: 'Daily Reminder',
                  subtitle: 'Morning 11 AM - 5 PM',
                  value: morning11to5,
                  onChanged: (value) {
                    setState(() {
                      morning11to5 = value;
                    });
                  },
                ),

                UIHelper.verticalSpace(20.h),

                SettingsSwitchTileAthlet(
                  icon: Icons.nights_stay,
                  iconBackgroundColor: AppColors.c2F2F2F,
                  iconColor: AppColors.cF55216,
                  title: 'Daily Reminder',
                  subtitle: 'Evening 6 PM - 10 PM',
                  value: evening6to10,
                  onChanged: (value) {
                    setState(() {
                      evening6to10 = value;
                    });
                  },
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}