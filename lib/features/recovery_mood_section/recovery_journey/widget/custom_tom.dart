import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';







class CustomTom extends StatelessWidget {
  final String title;
  const CustomTom({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,

        decoration: ShapeDecoration(
          color: AppColors.c151515,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                      fontSize: 18.sp,fontWeight: FontWeight.w500
                  )
              ),
              UIHelper.verticalSpace(4.h),

              Text('In 2021, I had a high-speed motocro'
                  'ss crash out the back of Turlinjah that '
                  'nearly killed me. I was placed in an in'
                  'duced coma, spent 16 months in hospital,'
                  ' and was diagnosed with a severe traumatic'
                  ' brain injury — including damage to my brain'
                  'stem. That’s the part of the brain that controls basic'
                  ' movement, balance, and even staying alive. Doctors'
                  'didn’t expect me to walk again\n\n\nBut I didnt accept that\n\n\n'
                  ' I sat in a wheelchair for over a year, relearning everything '
                  'from scratch. No one could fix this for me  not my doctors,'
                  ' not even my parents. I had to build it all back myself. And '
                  'I did. I started walking again. I started frame running. I '
                  'even started helping others.\n\n\n I created My Balance Day to track'
                  ' what helps  from levodopa timing to hydration, therapy, '
                  'diet, and equipment. Its designed for people like me: stroke'
                  'survivors, TBI warriors, or anyone chasing better balance '
                  'and mobility.\n\n\nThis app is built on real recovery. No BS. '
                  'Just persistence, trial and error, and a system that'
                  ' actually works.',style: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                  fontSize: 16.sp
              ),),
            ],

          ),
        )








    );
  }
}