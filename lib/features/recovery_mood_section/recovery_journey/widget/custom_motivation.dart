
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomMotivation extends StatelessWidget {
  const CustomMotivation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 131,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.c87B842,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.c000000.withOpacity(.1),
                  spreadRadius: 2,
                  blurRadius: .5,
                )
              ]
          ),
        ),
        //-------------------------------------------------- Card -----------------------------------//
        Positioned(
          left: 5,
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            height: 160.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.c151515,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Today\'s Motivation:',
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                          fontSize: 18.sp
                      )
                  ),
                  UIHelper.verticalSpace(6.h),
                  Text(
                      'Time to hit the vibration board!',
                      style: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                          fontSize: 16.sp
                      )
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            debugPrint('Reload icon tapped');
                            // Add your reload functionality here
                          },
                          borderRadius: BorderRadius.circular(8.r),
                          child: Padding(
                            padding: EdgeInsets.all(4.w),
                            child: SvgPicture.asset(
                              AppIcons.reloadicon,
                              height: 32.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
                        ),
            ),
        ),
        //------------------------------------- Done ----------------------------------//
        )],
    );
  }
}