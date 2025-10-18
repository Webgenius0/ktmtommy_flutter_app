import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets_helper/app_colors.dart';


class CustomSteper extends StatelessWidget {
  final circleColor1;
  final circleColor2;
  final circleColor3;
  final lineColor1;
  final lineColor2;
  const CustomSteper(
      {super.key,
      this.circleColor1,
      this.circleColor2,
      this.circleColor3,
      this.lineColor1,
      this.lineColor2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor:circleColor1?? AppColors.primaryColor,
          radius: 11.r,
        ),
        Expanded(
            child: Container(
          height: 6.h,
          width: double.infinity,
          color:lineColor1?? AppColors.primaryColor,
        )),
        CircleAvatar(
          backgroundColor:circleColor2?? AppColors.primaryColor,
          radius: 11.r,
        ),
        Expanded(
            child: Container(
          height: 6.h,
          width: double.infinity,
          color: lineColor2??AppColors.primaryColor,
        )),
        CircleAvatar(
          backgroundColor:circleColor3?? AppColors.primaryColor,
          radius: 11.r,
        ),
      ],
    );
  }
}
