
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';




class CustomAppbarWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final String? subtitle;
  final TextStyle? textStyle;


  const CustomAppbarWidget({
    super.key,
    this.onTap,
    this.textStyle,
    this.text,


    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.arrwiconback,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                if (text != null)
                  Text(
                    text!,
                    style: textStyle ?? TextFontStyle.textStylePoppins.copyWith(
                      fontSize: 20.sp,fontWeight: FontWeight.w500,
                    ),
                   // maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (subtitle != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    subtitle!,
                    style: textStyle?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.cA3A3A3,
                    ) ?? TextFontStyle.textStyle14w400cA3A3A3poppins,
                    maxLines: 1,
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
