import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomRecentMedication extends StatelessWidget {
  final String title ;


  const CustomRecentMedication({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.signureicon,height: 24.h,),
        UIHelper.horizontalSpace(20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                    title,

                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                ),
                UIHelper.horizontalSpace(30.w),
                Text(
                    '500mg',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,fontWeight: FontWeight.w400
                    )
                )
              ],
            ),
            UIHelper.verticalSpace(4.h),
            Text(
                'Yesterday, 8:00 PM',
                style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                    fontSize: 12.sp
                )
            )
          ],
        ),
        Spacer(),
        SvgPicture.asset(AppIcons.deleteicon,height: 24.h,)
      ],
    );
  }
}