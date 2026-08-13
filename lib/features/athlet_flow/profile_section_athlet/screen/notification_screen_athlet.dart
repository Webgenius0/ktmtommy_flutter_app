import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/profile_section_athlet/widget/settings_switch_tile_athlet.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class NotificationScreenAthlet extends StatefulWidget {
  const NotificationScreenAthlet({super.key});

  @override
  State<NotificationScreenAthlet> createState() =>
      _NotificationScreenAthletState();
}

class _NotificationScreenAthletState extends State<NotificationScreenAthlet> {
  bool appNotifications = true;
  bool morning6to10 = false;
  bool afternoon11to5 = false;
  bool evening6to10 = true;

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
          child: Column(
            children: [
              UIHelper.verticalSpace(12.h),

              /// ========== Appbar Section =========== ///
              ArrowButtonAtheleteFlow(
                text: 'Notification',
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              UIHelper.verticalSpace(20.h),

              /// ============ Notification Section Items ========== ///
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SettingsSwitchTileAthlet(
                        icon: Icons.notifications,
                        iconBackgroundColor: const Color(0xFF262626),
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
                        icon: Icons.notifications,
                        iconBackgroundColor: const Color(0xFF262626),
                        iconColor: AppColors.cF55216,
                        title: 'Daily Reminder',
                        subtitle: 'Morning 6-10 AM',
                        value: morning6to10,
                        onChanged: (value) {
                          setState(() {
                            morning6to10 = value;
                          });
                        },
                      ),
                      UIHelper.verticalSpace(20.h),
                      SettingsSwitchTileAthlet(
                        icon: Icons.notifications,
                        iconBackgroundColor: const Color(0xFF262626),
                        iconColor: AppColors.cF55216,
                        title: 'Daily Reminder',
                        subtitle: 'Afternoon 11AM- 5 PM',
                        value: afternoon11to5,
                        onChanged: (value) {
                          setState(() {
                            afternoon11to5 = value;
                          });
                        },
                      ),
                      UIHelper.verticalSpace(20.h),
                      SettingsSwitchTileAthlet(
                        icon: Icons.notifications,
                        iconBackgroundColor: const Color(0xFF262626),
                        iconColor: AppColors.cF55216,
                        title: 'Daily Reminder',
                        subtitle: 'Evening 6-10 PM',
                        value: evening6to10,
                        onChanged: (value) {
                          setState(() {
                            evening6to10 = value;
                          });
                        },
                      ),
                      const Spacer(),

                      /// ========== Bottom Action Button =========== ///
                      CustomButtonWidget(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                        image: DecorationImage(
                          image: AssetImage(AppImages.orangebutton),
                        ),
                        text: 'Update Password',
                      ),
                      UIHelper.verticalSpace(24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}