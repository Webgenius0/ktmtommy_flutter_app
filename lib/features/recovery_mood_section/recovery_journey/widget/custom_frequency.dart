
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';





class CustomFrequency extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomFrequency({
    super.key,
    required this.text,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric( vertical: 8.h),
        decoration: ShapeDecoration(
          color: AppColors.c2A2A2A,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isSelected ? AppColors.c87B842 :Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}












//
//
//
// Row(
// children: [
// Expanded(
// child: CustomFrequency(
// text: 'Rarely',
// isSelected: selectedOption == 'Rarely',
// onTap: () {
// setState(() {
// selectedOption = 'Rarely';
// });
// },
// ),
// ),
// UIHelper.horizontalSpace(10.w),
// Expanded(
// child: CustomFrequency(
// text: 'Weekly',
// isSelected: selectedOption == 'Weekly',
// onTap: () {
// setState(() {
// selectedOption = 'Weekly';
// });
// },
// ),
// ),
// UIHelper.horizontalSpace(10.w),
// Expanded(
// child: CustomFrequency(
// text: 'Daily',
// isSelected: selectedOption == 'Daily',
// onTap: () {
// setState(() {
// selectedOption = 'Daily';
// });
// },
// ),
// ),
// UIHelper.horizontalSpace(10.w),
// Expanded(
// child: CustomFrequency(
// text: 'Not sure',
// isSelected: selectedOption == 'Not sure',
// onTap: () {
// setState(() {
// selectedOption = 'Not sure';
// });
// },
// ),
// ),
// ],
// ),













//
//
// CustomSlider(
// sliderValue: sliderValue,
// onChanged: (newVal) {
// setState(() {
// sliderValue = newVal;
// });
// },
// ),


