import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';






class NutritionsWidget extends StatelessWidget {
  final String text;
  const NutritionsWidget({
    super.key, required this.text,
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
        padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                text,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 18.sp,fontWeight: FontWeight.w500
                )
            ),
            UIHelper.verticalSpace(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Protein',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),
                Text(
                    '46g',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),

              ],
            ),
            UIHelper.verticalSpace(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Carbss',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),
                Text(
                    '69g',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),

              ],
            ),
            UIHelper.verticalSpace(4.h),
            Divider(
              color: AppColors.c2F2F2F,

            ),
            UIHelper.verticalSpace(12.h),


            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                UIHelper.horizontalSpace(14.w),
                Text(
                    'Fiber',
                    style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                        fontSize: 16.sp
                    )
                ),
                Spacer(),
                Text(
                    '8g',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                )
              ],
            ),
            UIHelper.verticalSpace(4.h),
            Divider(
              color: AppColors.c2F2F2F,

            ),
            UIHelper.verticalSpace(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                UIHelper.horizontalSpace(14.w),
                Text(
                    'Sugar',
                    style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                        fontSize: 16.sp
                    )
                ),
                Spacer(),
                Text(
                    '3g',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                )
              ],
            ),
            UIHelper.verticalSpace(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Fat',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),
                Text(
                    '17g',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),

              ],
            ),
            UIHelper.verticalSpace(4.h),
            Divider(
              color: AppColors.c2F2F2F,

            ),
            UIHelper.verticalSpace(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                UIHelper.horizontalSpace(14.w),
                Text(
                    'Saturated',
                    style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                        fontSize: 16.sp
                    )
                ),
                Spacer(),
                Text(
                    '3g',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                )
              ],
            ),
            UIHelper.verticalSpace(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Sodium',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),
                Text(
                    '580mg',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),

              ],
            ),
            UIHelper.verticalSpace(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Potassium',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),
                Text(
                    '640mg',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),

              ],
            ),




          ],
        ),
      ),
    );
  }
}