

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';





class ProgressTimeline extends StatefulWidget {
  final double sliderValue;
  final ValueChanged<double> onChanged;
  final List<String> labels;

  const ProgressTimeline({
    super.key,
    required this.sliderValue,
    required this.onChanged,
    required this.labels,
  });

  @override
  State<ProgressTimeline> createState() => _ProgressTimelineState();
}

class _ProgressTimelineState extends State<ProgressTimeline> {
  late double _sliderValue;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.sliderValue;
  }

  double _snapToPosition(double value) {
    // Snap to nearest position (0.0, 0.5, or 1.0)
    if (value < 0.25) return 0.0;
    if (value < 0.75) return 0.5;
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    final displayValue = _isDragging ? _sliderValue : _snapToPosition(_sliderValue);

    return Column(
      children: [
        SizedBox(
          width: 307.w,
          height: 40.h,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Slider track
              Positioned(
                top: (40.h - 8.h) / 2,
                child: Container(
                  width: 290.w,
                  height: 8.h,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(0.99, 0.50),
                      end: const Alignment(0.01, 0.50),
                      colors: [const Color(0xFF87B842), Colors.white],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                ),
              ),
              // Slider thumb
              Positioned(
                left: (displayValue * 290.w).clamp(0.0, 270.w),
                child: GestureDetector(
                  onHorizontalDragStart: (_) => setState(() => _isDragging = true),
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _sliderValue += details.delta.dx / 290.w;
                      _sliderValue = _sliderValue.clamp(0.0, 1.0);
                    });
                  },
                  onHorizontalDragEnd: (_) {
                    setState(() => _isDragging = false);
                    final snappedValue = _snapToPosition(_sliderValue);
                    if (snappedValue != _sliderValue) {
                      setState(() => _sliderValue = snappedValue);
                    }
                    widget.onChanged(snappedValue);
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
                widget.labels[0],
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                widget.labels[1],
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                widget.labels[2],
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