import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/athlet_flow/profile_section_athlet/widget/confirmation_dialog_box_athlet.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class MyProfileSettingScreen extends StatefulWidget {
  const MyProfileSettingScreen({super.key});

  @override
  State<MyProfileSettingScreen> createState() => _MyProfileSettingScreenState();
}

class _MyProfileSettingScreenState extends State<MyProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///========== Appbar with back button and title=================
              CustomAppbarWidget(
                onTap: () {
                  Navigator.pop(context);
                },
                text: 'My Profile & Settings',
              ),
              UIHelper.verticalSpace(20.h),

              ///================ Profile Section ====================

              GestureDetector(
                onTap: () {
                  log("================>>> Profile Section Clicked");
                  NavigationService.navigateTo(Routes.editProfileScreen);
                },
                child: Container(
                  height: 109.h,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 18.w),
                  padding: EdgeInsets.all(24.w),
                  decoration: ShapeDecoration(
                    color: AppColors.c181818,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Profile Image
                      Image.asset(
                        AppImages.tomimage,
                        height: 50.h,
                        width: 50.w,
                        fit: BoxFit.cover,
                      ),

                      UIHelper.horizontalSpace(12.w),

                      /// Name + Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sarah Jhonson',
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                  .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Product Designer',
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                  .copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.c87B842,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Right Arrow
                      SvgPicture.asset(
                        AppIcons.arrow_right,
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
              ),

              UIHelper.verticalSpace(20.h),

              ///===============Manage Subscription===================///
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 197.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.c87B842),
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Subscription Status",
                                style: TextFontStyle
                                    .textStyle16w400c757575poppins
                                    .copyWith(
                                  color: AppColors.primaryColor,
                                  height: 0.h,
                                  fontSize: 20.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.premium,
                                  width: 24.w,
                                  height: 24.h,
                                ),
                                UIHelper.horizontalSpace(8.w),
                                Text(
                                  "Premium Plan",
                                  style: TextFontStyle
                                      .textStyle24w600cFFFFFFpoppins
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.check_icon,
                                  width: 24.w,
                                  height: 24.h,
                                ),
                                UIHelper.horizontalSpace(8.w),
                                Text(
                                  "Active",
                                  style: TextFontStyle
                                      .textStyle24w600cFFFFFFpoppins
                                      .copyWith(
                                          color: AppColors.c87B842,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            )
                          ],
                        ),
                        UIHelper.verticalSpace(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Next billing date: June 30, 2025",
                                style: TextFontStyle
                                    .textStyle24w600cFFFFFFpoppins
                                    .copyWith(
                                        color: AppColors.cA3A3A3,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(30.h),
                        CustomButton(
                          name: "Manage Subscription",
                          onCallBack: () {
                            print(
                                "=====================>>>Manage Subscription click");
                          },
                          borderColor: AppColors.c87B842,
                          context: context,
                          color: AppColors.c87B842,
                          height: 40.h,
                          borderRadius: 999.r,
                          textStyle: TextFontStyle.textStyle16w400c757575poppins
                              .copyWith(
                                  color: AppColors.cFFFFFF,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              UIHelper.verticalSpace(16.h),

              ///===============Menu Options===================///
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 510.h,
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 20,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///============== Account Settings Section====================
                      UIHelper.verticalSpace(10.h),
                      Text(
                        'Account Settings',
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                            .copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      UIHelper.verticalSpace(10.h),
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(
                              Routes.changePasswordScreen);
                          log("================>>> Update Password Clicked");
                        },
                        child: _buildMenuRow(
                          title: "Update Password",
                          textColor: Colors.white,
                          iconPath: AppIcons.key,
                          trailing: Icons.arrow_forward_ios_rounded,
                          iconColor: AppColors.c87B842,
                        ),
                      ),

                      UIHelper.verticalSpace(20.h),

                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(
                              Routes.notificationScreen);
                          log("================>>> Notification Settings Clicked");
                        },
                        child: _buildMenuRow(
                          title: "Notification Settings",
                          textColor: Colors.white,
                          iconPath: AppIcons.notification_icon,
                          trailing: Icons.arrow_forward_ios_rounded,
                          iconColor: AppColors.c87B842,
                        ),
                      ),
                      UIHelper.verticalSpace(10.h),
                      _divider(),
                      UIHelper.verticalSpace(10.h),

                      UIHelper.verticalSpace(10.h),
                      Text(
                        'Support',
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                            .copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      UIHelper.verticalSpace(10.h),

                      GestureDetector(
                        onTap: () {
                          // NavigationService.navigateTo(
                          //     Routes.termsConditionScreen);
                        },
                        child: _buildMenuRow(
                          title: "Help Center",
                          textColor: Colors.white,
                          iconPath: AppIcons.help_center,
                          trailing: Icons.arrow_forward_ios_rounded,
                          iconColor: AppColors.c87B842,
                        ),
                      ),

                      UIHelper.verticalSpace(10.h),

                      GestureDetector(
                        onTap: () {
                          log("================>>> Privacy Policy Clicked");
                        },
                        child: _buildMenuRow(
                          title: "Privacy Policy",
                          textColor: Colors.white,
                          iconPath: AppIcons.lock,
                          trailing: Icons.arrow_forward_ios_rounded,
                          iconColor: AppColors.c87B842,
                        ),
                      ),

                      UIHelper.verticalSpace(10.h),
                      _divider(),
                      UIHelper.verticalSpace(10.h),

                      /// ===== Log Out =====
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmationDialog(
                              title: "Log Out ?",
                              message:
                                  "Are you sure you want to log out of your account?",
                              confirmButtonText: "Confirm",
                              onConfirm: () async {
                                try {
                                  bool isLogout =
                                      await postLogOutRXObj.logout();

                                  if (isLogout) {
                                    NavigationService
                                        .navigateToUntilReplacement(
                                            Routes.logInSelectionModeScreen);
                                    appData.write(kKeyIsLoggedIn, false);
                                  }
                                } catch (error) {
                                  log(error.toString());
                                }

                                log("================>>> Log Out Confirmed");
                              },
                              onCancel: () {
                                Navigator.pop(context); // Close dialog
                              },
                              confirmButtonColor: AppColors.c87B842,
                            ),
                          );
                        },
                        child: _buildMenuRow(
                          title: "Log Out",
                          textColor: Colors.white,
                          iconPath: AppIcons.log_out,
                          trailing: Icons.arrow_forward_ios_rounded,
                          iconColor: AppColors.c87B842,
                        ),
                      ),

                      UIHelper.verticalSpace(20.h),

                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmationDialog(
                              title: "Delete Account",
                              message:
                                  "Are you sure you want to permanently delete your account?",
                              confirmButtonText: "Confirm",
                              onConfirm: () {
                                log("================>>> Delete Account Confirmed");
                                Navigator.pop(context);
                              },
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              confirmButtonColor: AppColors.c87B842,
                            ),
                          );
                        },
                        child: _buildMenuRow(
                          title: "Delete Account",
                          textColor: Colors.red,
                          iconPath: AppIcons.delete_icon,
                          iconColor: AppColors.cCC1F28,
                          trailing: Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              UIHelper.verticalSpace(12.h),
            ],
          ),
        ),
      ),
    );
  }
}

///---------------- Helper Widgets ----------------///
Widget _divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.h),
    height: 0.5,
    color: AppColors.c454545,
  );
}

Widget _buildMenuRow({
  required String title,
  required Color textColor,
  required Color iconColor,
  required String iconPath,
  IconData? trailing,
  Widget? trailingWidget,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          /// ===== Left Icon =====
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.c2F2F2F,
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: SvgPicture.asset(
                iconPath,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w), // Consistent spacing

          /// ===== Text =====
          Text(
            title,
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),

      /// ===== Trailing widget or arrow =====
      trailingWidget ??
          Icon(
            trailing,
            size: 16.sp,
            color: iconColor,
          ),
    ],
  );
}
