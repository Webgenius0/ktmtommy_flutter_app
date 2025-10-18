import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';



class CustomDiagnosis extends StatelessWidget {
  final Widget? icon;
  const CustomDiagnosis({
    super.key, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: ShapeDecoration(
        color: AppColors.c87B842,
        shape: RoundedRectangleBorder(
          side:  BorderSide(width: 2, color: AppColors.c515151),
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Center(
        child: icon,
        // child: SvgPicture.asset(
        //
        //  // AppIcons.diagnosisicon,
        //   height: 18.h,
        // ),
      ),
    );
  }
}