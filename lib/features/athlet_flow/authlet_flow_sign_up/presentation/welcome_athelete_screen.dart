import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class WelcomeAtheleteScreen extends StatefulWidget {
  const WelcomeAtheleteScreen({super.key});

  @override
  State<WelcomeAtheleteScreen> createState() => _WelcomeAtheleteScreenState();
}

class _WelcomeAtheleteScreenState extends State<WelcomeAtheleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.welcombacroundimage),fit: BoxFit.cover)
        ),
        child:  SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(130),

              Text(
                  'Welcome, \nAthlete! 💪',
                  style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                      fontSize: 40.sp,fontWeight: FontWeight.w700
                  )
              ),
              UIHelper.verticalSpace(18.h),

              Text(
                  'Your 25-day journey toward better balance, strength, and performance starts now.',
                  style: TextFontStyle.textStyle30w400cA3A3A3Teko,

              ),
              UIHelper.verticalSpace(300.h),

              CustomButtonWidget(
                onTap: (){
                  log("==========>>>>>>>Lets Begin clicked go to selectGoalScreen");
                  NavigationService.navigateTo(Routes.selectGoalScreen);},
                textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                image: DecorationImage(image: AssetImage(AppImages.orangebutton)),

                text: 'LET’S BEGIN',
              ),




            ],
          ),
        ),
      ),
    );
  }
}
