import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';







class WidgetAnimation extends StatelessWidget {
  const WidgetAnimation({
    super.key,
    required this.title,
    required this.mg,
    required this.subtitle, required this.onDeletePress,

  });

  final String title;
  final VoidCallback onDeletePress;

  final String mg;
  final String subtitle;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Column(
      //  crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/signureicon.svg', height: 24.h,color: AppColors.orangeColor,),
          UIHelper.horizontalSpace(20.w),

          //===================================== Animation ============================//
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextFontStyle
                          .textStyle24w600cFFFFFFpoppins
                          .copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      mg,
                      style: TextFontStyle
                          .textStyle24w600cFFFFFFpoppins
                          .copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  subtitle,
                  style: TextFontStyle.textStyle16w400c757575poppins
                      .copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ),

          UIHelper.horizontalSpace(8.w),

          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onDeletePress,
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: SvgPicture.asset(
                  'assets/icons/deleteicon.svg',
                  height: 24.h,
                  color: AppColors.orangeColor,
                ),
              ),
            ),
          ),
        ],
      ),
    )
        ],
      ),
    );
  }
}