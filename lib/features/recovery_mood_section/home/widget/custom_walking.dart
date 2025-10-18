import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';





class CustomWalking extends StatefulWidget {
  const CustomWalking({
    super.key,
  });

  @override
  State<CustomWalking> createState() => _CustomWalkingState();
}

class _CustomWalkingState extends State<CustomWalking> {


  List<String> durationList = ['Slow Walk', 'Brisk Walk', 'Power Walk', 'Interval Walk'];
  late String selectedUnit;

  @override
  void initState() {
    super.initState();
    selectedUnit = durationList[0];
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: ShapeDecoration(
        color: AppColors.c2A2A2A,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child:
      PopupMenuButton<String>(
        color: Color(0xFF2A2A2A),
        onSelected: (String value) {
          setState(() {
            selectedUnit = value;
          });
        },
        itemBuilder: (BuildContext context) {
          return durationList.map((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList();
        },
        offset: Offset(30, 40),
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
             selectedUnit,
             maxLines: 1,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SvgPicture.asset(AppIcons.bottomdrodwonicon, height: 18.h,color: AppColors.cFFFFFF),
          ],
        ),
      ),




    );
  }
}