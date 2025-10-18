import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class WaterIntake extends StatefulWidget {
  final bool initialToggleState;
  final int initialGlassCount;
  final ValueChanged<bool>? onToggleChanged;
  final ValueChanged<int>? onGlassCountChanged;

  const WaterIntake({
    super.key,
    this.initialToggleState = false,
    this.initialGlassCount = 0,
    this.onToggleChanged,
    this.onGlassCountChanged,
  });

  @override
  State<WaterIntake> createState() => _WaterIntakeState();
}

class _WaterIntakeState extends State<WaterIntake> {
  late bool _isOn;
  late int _activeGlassCount;

  @override
  void initState() {
    super.initState();
    _isOn = widget.initialToggleState;
    _activeGlassCount = widget.initialGlassCount;
  }

  void _incrementGlass() {
    if (_activeGlassCount < 8) {
      setState(() {
        _activeGlassCount++;
        widget.onGlassCountChanged?.call(_activeGlassCount);
      });
    }
  }

  void _decrementGlass() {
    if (_activeGlassCount > 0) {
      setState(() {
        _activeGlassCount--;
        widget.onGlassCountChanged?.call(_activeGlassCount);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
  //============================= Water Intake =================================//
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Water Intake',
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

   //========================== Toggole ====================================//
            Transform.scale(
              scale: 0.90,
              child: Switch(
                activeColor: AppColors.cFFFFFF,
                activeTrackColor: AppColors.orangeColor,
                inactiveTrackColor: AppColors.cE9E9EA,
                inactiveThumbColor: AppColors.orangeColor,
                value: _isOn,
                onChanged: (bool value) {
                  setState(() {
                    _isOn = value;
                    if (!_isOn) {
                      _activeGlassCount = 0;
                      widget.onGlassCountChanged?.call(0);
                    }
                    widget.onToggleChanged?.call(_isOn);
                  });
                },
              ),
            ),
          ],
        ),

        if (_isOn) ...[
          UIHelper.verticalSpace(16.h),

  //============================== Intake =======================================//
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Water Intake',
                style: TextFontStyle.textStyle16w400c757575poppins,
              ),
              Text(
                '$_activeGlassCount/8 Glass',
                style: TextFontStyle.textStyle24w600cF55216poppins.copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(16.h),

     //================================
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 12,
            children: [
              GestureDetector(
                onTap: _decrementGlass,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
                  decoration: ShapeDecoration(
                    color: AppColors.c2F2F2F,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  child: SvgPicture.asset(AppIcons.minicon, height: 18.h),
                ),
              ),


    //=============================== Intak===========================//
              Row(
               spacing: 8,
                children: List.generate(8, (index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    decoration: ShapeDecoration(
                      color: index < _activeGlassCount
                          ? AppColors.orangeColor
                          : AppColors.c2F2F2F,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r)),
                    ),
                  );
                }),
              ),

      //------------------------------------------- Plus Icon-------------------------------//
              GestureDetector(
                onTap: _incrementGlass,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
                  decoration: ShapeDecoration(
                    color: AppColors.c2F2F2F,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  child: SvgPicture.asset(AppIcons.plusicon, height: 18.h),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}