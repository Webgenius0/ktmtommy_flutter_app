

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';





class ArrowButtonAtheleteFlow extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final String? subtitle;
  final TextStyle? textStyle;
  final bool? noBack;


  const ArrowButtonAtheleteFlow({
    super.key,
    this.onTap,
    this.textStyle,
    this.text,


    this.subtitle, this.noBack,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

        noBack== true?SizedBox():  SvgPicture.asset(
            AppIcons.arrwButton,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                if (text != null)
                  Text(
                    text!,
                    style: textStyle ?? TextFontStyle.textStylePoppins.copyWith(
                      fontSize: 20.sp,fontWeight: FontWeight.w500, height: 0.h,
                    ),
                    // maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (subtitle != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    subtitle!,
                    style: TextFontStyle.textStylePoppins.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.cA3A3A3,
                    ) ?? TextFontStyle.textStyle14w400cA3A3A3poppins,
                    //maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
