import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_diagnosis.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class RecoveryJourney extends StatelessWidget {
  const RecoveryJourney({
    super.key,
    required this.progressValue,
  });

  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color:  AppColors.c181818,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color: AppColors.c87B842
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Recovery Journey',
              style:  TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 16.sp,fontWeight: FontWeight.w500,
              )
          ),
          UIHelper.verticalSpace(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              CustomDiagnosis(
                icon:     SvgPicture.asset(
                  AppIcons.diagnosisicon,
                  height: 18.h,
                ),
              ), CustomDiagnosis(
                icon:     SvgPicture.asset(
                  AppIcons.loveicon,
                  height: 18.h,
                ),
              ), CustomDiagnosis(
                icon:     SvgPicture.asset(
                  AppIcons.progressicon,
                  height: 18.h,
                ),
              ),

            ],
          ),
          Center(
            child: SizedBox(
              height: 6.h,
              width: 307.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(44.r),
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: AppColors.c87B842,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.c87B842),
                  minHeight: 5.h,
                ),
              ),
            ),
          ),
          UIHelper.verticalSpace(6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                      'Diagnosis',
                      style: TextFontStyle.textStyle14w400c87B842poppins
                  ),
                  UIHelper.verticalSpace(2),
                  Text(
                      'Sept 2021',
                      style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                          fontSize: 12.sp
                      )
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                      'Therapy',
                      style: TextFontStyle.textStyle14w400c87B842poppins
                  ),
                  UIHelper.verticalSpace(2),
                  Text(
                      'Jan 2022',
                      style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                          fontSize: 12.sp
                      )
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                      'Progress',
                      style: TextFontStyle.textStyle14w400c87B842poppins
                  ),
                  UIHelper.verticalSpace(2),
                  Text(
                      'July 2024',
                      style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                          fontSize: 12.sp
                      )
                  )
                ],
              ),


            ],
          )


        ],
      ),
    )





      //    UIHelper.verticalSpace(12.h),

      /// Long thin progress bar

    );
  }
}