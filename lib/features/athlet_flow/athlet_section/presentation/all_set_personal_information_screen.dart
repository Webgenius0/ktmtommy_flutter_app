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




class AllSetPersonalInformationScreen extends StatefulWidget {
  const AllSetPersonalInformationScreen({super.key});

  @override
  State<AllSetPersonalInformationScreen> createState() =>
      _AllSetPersonalInformationScreenState();
}

class _AllSetPersonalInformationScreenState
    extends State<AllSetPersonalInformationScreen> {
  @override
  Widget build(BuildContext context) {
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
                style: TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
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
                      title: 'Name',
                      subtitle: 'Alex Johnson',
                      icon: SvgPicture.asset(
                        AppIcons.usernameicon,
                        height: 20.h,
                        color: AppColors.orangeColor,
                      ),
                    ),

                    Divider(color: AppColors.cD1D1D1),

                    UIHelper.verticalSpace(16.h),

                    CustomYourAllSet(
                      title: 'Goals',
                      subtitle: 'Return to work(Part Time)',
                      icon: SvgPicture.asset(AppIcons.liteicon, height: 20.h, color: AppColors.orangeColor,),
                    ),

                    Divider(color: AppColors.cD1D1D1),
                    UIHelper.verticalSpace(16.h),

                    CustomYourAllSet(
                      title: 'Daily Reminder',
                      subtitle: 'Evening 6-10 PM)',
                      icon: SvgPicture.asset(
                        AppIcons.notification,
                        height: 20.h, color: AppColors.orangeColor,
                      ),
                    ),

                    Divider(color: AppColors.cD1D1D1),
                  ],
                ),
              ),

              UIHelper.verticalSpace(24.h),

              CustomButtonWidget(
                textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                onTap: () {
                  NavigationService.navigateTo(Routes.subscriptionAthletModeScreen);
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
