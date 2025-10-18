
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class CustomButtonWidget extends StatelessWidget {
  final DecorationImage? image;
  final String text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Widget? icon;


  const CustomButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.image,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 32.w),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          image:
              image ??
              DecorationImage(
                image: AssetImage(AppImages.buttonBackground),
                fit: BoxFit.cover,
              ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SvgPicture.asset(''),
            UIHelper.horizontalSpace(10.w),
            Text(
              text,
              style:
                  textStyle ??
                  TextFontStyle.textStylePoppins.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}


