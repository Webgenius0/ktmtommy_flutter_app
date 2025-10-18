import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class ItemsWidget extends StatelessWidget {
  const ItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              color: AppColors.c87B842
          ),
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Total Equipment',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle16w400c757575poppins
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                    '5 items',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 20.sp
                    )
                )

              ],
            ),


            Container(

              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 2,
                      color: AppColors.c87B842
                  ),
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Text(
                    '05',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 20.sp
                    )
                ),
              ),

            ),



          ],
        ),
      ),
    );
  }
}