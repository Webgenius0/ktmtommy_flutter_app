import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class CustomYourAllSet extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final TextStyle? textStyle;

  const CustomYourAllSet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        UIHelper.horizontalSpace(12.w),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle??TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                color: AppColors.orangeColor,
              ),
            ),

            Text(
              subtitle,
              style: TextFontStyle.textStyle14w400cE8E8E8poppins.copyWith(
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
