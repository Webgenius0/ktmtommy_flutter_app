import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class CustomWeeksToGo extends StatelessWidget {
  final String title;

  const CustomWeeksToGo({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              title,
              //  'LET S GRIND, ALEX. NO EXCUSES TODAY.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Teko',
                  fontWeight: FontWeight.w500,
                  height: 1.50,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1,
                        color: AppColors.orangeColor
                    ),
                    borderRadius: BorderRadius.circular(80.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 10.h),
                  child: Text(
                      '🏁 TRIATHLON — 12 WEEKS TO GO',
                      textAlign: TextAlign.start,
                      style: TextFontStyle.textStylePoppins.copyWith(
                          fontSize: 14.sp,fontWeight: FontWeight.w400
                      )
                  ),
                ),
              ),
            ],
          ),
        ),

        Image.asset(
          AppImages.weeksimage,
          height: 48.h,
        ),
      ],
    );
  }
}