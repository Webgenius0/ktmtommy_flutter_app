import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class CustomCard extends StatelessWidget {
  final String text;

  const CustomCard({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(1.00, 0.50),
          end: Alignment(-0.00, 0.50),
          colors: [const Color(0xFF0C0A0A), const Color(0xFF2D3520)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  text,
                //
                  style: TextFontStyle.textStyle16w400c87B842poppins,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
              UIHelper.horizontalSpace(12.w),
              SvgPicture.asset(
                AppIcons.cressicon,
                height: 72.h,
              ),
            ],
          )




        ],
      ),
    ),
    );
  }
}