import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_sleep.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';






class CustomEnergyLevel extends StatelessWidget {
  final String title;

  const CustomEnergyLevel({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                 title,
                 // 'Energy level:',
                  style: TextFontStyle.textStyle20w700cFFFFFFTeko
                      .copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
                UIHelper.horizontalSpace(4.w),
                Text(
                  '7/10',
                  style: TextFontStyle.textStyle18w400cF55216Teko
                      .copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(12.h),

            Row(
              children: [
                Expanded(
                  child: CustomSleep(
                    image: Image.asset(
                      AppImages.sleepimage,
                      height: 40.h,
                    ),
                    title: 'Sleep',
                    subtitle: '6.2 hours',
                  ),
                ),
                UIHelper.horizontalSpace(12.w),

                Expanded(
                  child: CustomSleep(
                    image: Image.asset(
                      AppImages.recpvery,
                      height: 40.h,
                    ),
                    title: 'Recovery',
                    subtitle: 'Moderate',
                  ),
                ),

                UIHelper.horizontalSpace(12.w),
                Expanded(
                  child: CustomSleep(
                    image: Image.asset(
                      AppImages.load,
                      height: 40.h,
                    ),
                    title: 'Load',
                    subtitle: 'High',
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(12.h),

            Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.1),
                    blurRadius: 30,
                    offset: Offset(0, 1),
                  ),
                  BoxShadow(
                    color: Colors.red.withOpacity(0.1),
                    blurRadius: 30,
                    offset: Offset(0, 1),
                  ),
                ],
                color: AppColors.c090809,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppIcons.raceicon,
                          height: 24.h,
                        ),
                        UIHelper.horizontalSpace(4.w),
                        Text(
                          'BRICK DAY Goal',
                          //'RACE READINESS',
                          style:
                          TextFontStyle
                              .textStyle18w400cF55216Teko,
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(4.h),
                    Text(
                      'Today is a brick day: 40min ride + 20min run.\nHydrate well - it s 85°F outside.',
                      style: TextFontStyle
                          .textStyle20w700cFFFFFFTeko
                          .copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    UIHelper.verticalSpace(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 35.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            image: DecorationImage(
                              image: AssetImage(
                                AppImages.localactivity,
                              ),
                            ),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            'LOG ACTIVITY',
                            style: TextFontStyle
                                .textStyle20w700cFFFFFFTeko
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}