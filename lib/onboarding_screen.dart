import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.restbacroundimage),fit: BoxFit.cover)
        ),
        child:  SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              UIHelper.verticalSpace(50.h),
              Center(
                child: Image.asset(
                  AppImages.bikeimage,
                  height: 204.h,
                ),
              ),
              UIHelper.verticalSpace(18.h),

              Text(
                  textAlign: TextAlign.start,
                  'Welcome to My Balance Day',
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 40.sp
                  )
              ),
              UIHelper.verticalSpace(18.h),
              Row(
                children: [

                ],
              ),
              Text(
                  textAlign: TextAlign.start,
                  'Your companion in\nrecovery, balance, and\nwell-being.',
                  style: TextFontStyle.textStyle24w400cA3A3A3poppins
              ),
              UIHelper.verticalSpace(160.h),

              CustomButtonWidget(
                textStyle: TextFontStyle.textStyle20w700c000000poppins,
                image: DecorationImage(
                  image: AssetImage(AppImages.withbacrounbutton),
                ),
                text: 'GET STARTED',
                onTap: () {
                  NavigationService.navigateTo(Routes.welcomeBackScreen);

                },
              ),
            ],
          ),
        ),
      )


    );
  }
}
