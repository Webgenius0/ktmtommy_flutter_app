import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';




class DurationTime extends StatefulWidget {
  final ValueChanged<String>? onDurationSelected;

  const DurationTime({
    super.key,
    this.onDurationSelected,
  });

  @override
  State<DurationTime> createState() => _DurationTimeState();
}

class _DurationTimeState extends State<DurationTime> {
  List<String> durationList = ['30 minutes', '20 minutes', '40 minutes', '10 minutes', '15 minutes'];


  late String selectedUnit = durationList[0];


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      decoration: ShapeDecoration(
        color: AppColors.c2A2A2A,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child:


      PopupMenuButton<String>(
        color: const Color(0xFF2A2A2A),
        onSelected: (String value) {
          setState(() {
            selectedUnit = value;
          });
          if (widget.onDurationSelected != null) {
            widget.onDurationSelected!(value);
          }
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
            SvgPicture.asset(AppIcons.bottomdrodwonicon, height: 18.h),
          ],
        ),
      ),

    );
  }
}