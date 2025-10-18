import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';






class TimeCustom extends StatefulWidget {
   const TimeCustom({
    super.key,
  });

  @override
  State<TimeCustom> createState() => _TimeCustomState();
}

class _TimeCustomState extends State<TimeCustom> {
  List<String> durationList = ['3:30 PM', '1:20 PM', '12:30 PM', '2:30 PM', '8:10 PM'];

  late String selectedUnit = durationList[0];



  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SvgPicture.asset(AppIcons.timePopup, height: 18.h),
            ],
          ),
        ),

    );
  }
}