import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/welcome_back/widget/custom_continue_with_google_screen.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({super.key});

  @override
  State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  int selectedIndex = -1;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.restbacroundimage),fit: BoxFit.cover)
        ),child:   SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                UIHelper.verticalSpace(32.h),
                Image.asset(AppImages.bikeimage, height: 141.h),
                UIHelper.verticalSpace(23.h),
                Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                  ),
                ),
                UIHelper.verticalSpace(2.h),
                Text(
                  'Hello there, how would you like to continue',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle14w400cF3F3F3poppins,
                ),
                UIHelper.verticalSpace(24.h),



                CustomContinueWithGoogle(
                  title: 'Continue With Google',
                  icon: SvgPicture.asset(AppIcons.googleicon, height: 18.h),
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                ),
                UIHelper.verticalSpace(14.h),

                CustomContinueWithGoogle(
                  title: 'Continue With Apple',
                  icon: SvgPicture.asset(AppIcons.appleicon, height: 21.h),
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),
                UIHelper.verticalSpace(14.h),

                CustomContinueWithGoogle(
                  title: 'Login as Guest',
                  icon: SvgPicture.asset(AppIcons.loginisgusticon, height: 24.h),
                  isSelected: selectedIndex == 2,
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                ),
                UIHelper.verticalSpace(20.h),


                Text(
                  'OR',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle14w400cF3F3F3poppins,
                ),
                UIHelper.verticalSpace(18.h),

                CustomButtonWidget(
                  textStyle: TextFontStyle.textStyle20w700c000000poppins,
                  image: DecorationImage(
                    image: AssetImage(AppImages.withbacrounbutton),
                  ),
                  icon:  SvgPicture.asset(AppIcons.continueWithEmail,height: 24.h),
                  text: 'Continue With Email',
                  onTap: () {
                    NavigationService.navigateTo(Routes.loginScreen);
                  },
                ),

                UIHelper.verticalSpace(18.h),

                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text('Don’t have an account?',style: TextFontStyle.textStyle14w400cF3F3F3poppins),
                    UIHelper.horizontalSpace(4.w),

                    GestureDetector(
                      onTap: (){
                        NavigationService.navigateTo(Routes.chooseModeScreen);
                        log("=============Register now clicked go to chooseModeScreen ");


                        },
                      child: Text(' Register now',style: TextFontStyle.textStyle14w400cF55216poppins.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                      ),
                      ),
                    )
                  ],
                )


              ],
            ),
          ),
        ),
      ),
      )
    );
  }
}


