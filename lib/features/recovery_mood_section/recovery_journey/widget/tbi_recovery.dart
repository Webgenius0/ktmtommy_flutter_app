import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';






class TBIRecovery extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget widget;

  const TBIRecovery({super.key, required this.title, this.onTap, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
            ),
            UIHelper.verticalSpace(8.h),

            Container(
              decoration: ShapeDecoration(
                color: AppColors.cCC1F28,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                child: Text(
                  'TBI Recovery',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onTap,
            child: widget)
      ],
    );
  }
}
