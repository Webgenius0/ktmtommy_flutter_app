import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomTimeLine extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final VoidCallback? onTap;
  final String morningText;
  final String amText;
  final Color? color;

  const CustomTimeLine({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
    required this.morningText,
    required this.amText, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: color?? Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            Container(width: 4.w, height: 73.h, color: AppColors.c454545),
          ],
        ),
        UIHelper.horizontalSpace(8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
            children: [
              Row(
                children: [
                  Text(
                    amText,
                    // '8:00 AM',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    morningText,
                    // 'Morning Medication',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(6.h),

              Container(
                width: double.infinity,

                decoration: ShapeDecoration(
                  color: AppColors.c181818,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          icon,
                         // SvgPicture.asset(AppIcons.logTableticon),
                          UIHelper.horizontalSpace(12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                //'Morning Medication',
                                textAlign: TextAlign.center,
                                style: TextFontStyle
                                    .textStyle24w600cFFFFFFpoppins
                                    .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              UIHelper.verticalSpace(5.h),

                              Text(
                                subtitle,
                               // 'Completed',
                                style:
                                    TextFontStyle.textStyle14w400c8C8C8Cpoppins,
                              ),
                            ],
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
      ],
    );
  }
}
