import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/features/auth/auth_section/widget/custom_back_continue.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class ErrorWithEmailScreen extends StatefulWidget {
  const ErrorWithEmailScreen({super.key});

  @override
  State<ErrorWithEmailScreen> createState() => _ErrorWithEmailScreenState();
}

class _ErrorWithEmailScreenState extends State<ErrorWithEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child:Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color:AppColors.c000000,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color:  AppColors.cEEE6DA
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 40,
                        offset: Offset(15, 15),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 20.h,horizontal: 7.w),
                    child: Column(
                      children: [
                        Container(
                          decoration: ShapeDecoration(
                            color:  Color(0x33EEE6DA),
                            shape: OvalBorder(),
                          ),
                          child: Transform.scale(
                              scale: 0.50,
                              child: SvgPicture.asset(AppIcons.settingIcon,height: 62.h,)),
                        ),
                        UIHelper.verticalSpace(10.h),
                        Text(
                            'Sorry, you don’t have\n an account with this email.',
                            textAlign: TextAlign.center,
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 18.sp)
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          'Click continue to create an account with this email.',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.textStyle14w400cBABABApoppins
                        ),
                        UIHelper.verticalSpace(10.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBackContinue(
                              text: "Back",
                              onTap: () {},
                            ),
                            UIHelper.horizontalSpace(10.w),

                            CustomBackContinue(
                              borderSide: BorderSide(color: Colors.transparent),
                              color: AppColors.cEEE6DA,
                              textStyle: TextFontStyle.textStyle20w700c000000poppins,
                              text: "Continue",
                              onTap: () {},
                            ),
                          ],
                        )


                      ],
                    ),
                  )



              ),

            ],
          ),
        )


      ),
    );
  }
}


