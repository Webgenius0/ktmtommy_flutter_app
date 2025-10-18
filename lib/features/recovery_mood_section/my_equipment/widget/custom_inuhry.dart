import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/tbi_custom.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class CustomInuhry extends StatefulWidget {
  const CustomInuhry({
    super.key,
  });

  @override
  State<CustomInuhry> createState() => _CustomInuhryState();
}

class _CustomInuhryState extends State<CustomInuhry> {
  List<String> injuryList = ['Injury 1', 'Injury 2', 'Injury 3', 'Injury 4'];
  String selectedInjury = 'Injury 1';

  String selectedGender = "Mid";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          'Injury Name',
          style: TextFontStyle
              .textStyle24w600cFFFFFFpoppins
              .copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),


        UIHelper.verticalSpace(12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: ShapeDecoration(
            color: Color(0xFF2A2A2A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedInjury,
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              PopupMenuButton<String>(
                color: AppColors.c2A2A2A,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(AppIcons.bottomdrodwonicon, height: 18.h),
                onSelected: (String value) {
                  setState(() {
                    selectedInjury = value;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return injuryList.map((String item) {
                    return PopupMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 14.sp, color: AppColors.cFFFFFF),
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ),


            UIHelper.verticalSpace(16.h),

            Text(
              'Injury Level',
              style: TextFontStyle
                  .textStyle24w600cFFFFFFpoppins
                  .copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
            UIHelper.verticalSpace(16.h),

            Row(
              children: [
                TbiCustom(
                  title: 'Mid',
                  isSelected: selectedGender == 'Mid',
                  onTap: () {
                    setState(() {
                      selectedGender = 'Mid';
                    });
                  },
                ),
                TbiCustom(
                  title: 'Moderate',
                  isSelected: selectedGender == 'Moderate',
                  onTap: () {
                    setState(() {
                      selectedGender = 'Moderate';
                    });
                  },
                ),
              ],
            ),
            UIHelper.verticalSpace(12.h),
            Row(
              children: [
                TbiCustom(
                  title: 'Severe',
                  isSelected: selectedGender == 'Severe',
                  onTap: () {
                    setState(() {
                      selectedGender = 'Severe';
                    });
                  },
                ),
                TbiCustom(
                  title: 'Other',
                  isSelected: selectedGender == 'Other',
                  onTap: () {
                    setState(() {
                      selectedGender = 'Other';
                    });
                  },
                ),
              ],
            ),




          ],
        ),
      ),
    );
  }
}



