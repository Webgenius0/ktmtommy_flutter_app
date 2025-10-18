

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';






class CustomSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;

  const CustomSlider({

    Key? key,
    required this.initialValue,
    required this.onChanged,

  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {

  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.initialValue;
  }
  @override
  Widget build(BuildContext context) {
    return

      Column(
        children: [


        SizedBox(
        width: 307.w,
        height: 40.h,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Slider Track
            Positioned(
              top: (40.h - 8.h) / 2,
              child: Container(
                width: 300.w,
                height: 8.h,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.01, 0.50),
                    end: const Alignment(0.99, 0.50),
                    colors: [const Color(0xFF87B842), const Color(0xFFFF5B00)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ),
            ),

            // Slider Thumb
            Positioned(
              left: (_sliderValue * 290.w).clamp(0.0, 280.w),
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _sliderValue += details.delta.dx / 290.w;
                    _sliderValue = _sliderValue.clamp(0.0, 1.0);
                    widget.onChanged(_sliderValue);
                  });
                },
                child: Container(
                  width: 22.w,
                  height: 22.h,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 3.w,
                        color: const Color(0xFF87B842),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

          SizedBox(
            width: 307.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mild',
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  '${(_sliderValue * 10).round()}/10',
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  'Severe',
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}





























