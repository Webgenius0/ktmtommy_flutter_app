import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class NewRecord extends StatefulWidget {
  final String title;
  final String initialWalkingType;
  final int initialHours;
  final int initialMinutes;

  final bool isLoading;

  final void Function({
    required String activity,
    required int hours,
    required int minutes,
  }) onAddPressed;

  const NewRecord({
    super.key,
    required this.title,
    this.initialWalkingType = 'Slow Walk',
    this.initialHours = 0,
    this.initialMinutes = 15,
    this.isLoading = false,
    required this.onAddPressed,
  });

  @override
  State<NewRecord> createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> {
  late String selectedWalkingType;
  late int hours;
  late int minutes;

  final List<String> durationList = [
    'Slow Walk',
    'Brisk Walk',
    'Power Walk',
    'Interval Walk',
  ];

  @override
  void initState() {
    super.initState();
    selectedWalkingType = widget.initialWalkingType;
    hours = widget.initialHours;
    minutes = widget.initialMinutes;
  }

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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextFontStyle.textStyle14w400cA3A3A3poppins,
            ),
            UIHelper.verticalSpace(4.h),

            // ========== Walking Type Dropdown ==========
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
              decoration: ShapeDecoration(
                color: AppColors.c2A2A2A,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
              ),
              child: PopupMenuButton<String>(
                color: const Color(0xFF2A2A2A),
                onSelected: (value) =>
                    setState(() => selectedWalkingType = value),
                itemBuilder: (_) => durationList
                    .map((e) => PopupMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ))
                    .toList(),
                offset: const Offset(30, 40),
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedWalkingType,
                      style:
                          TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SvgPicture.asset(AppIcons.bottomdrodwonicon,
                        height: 18.h, color: AppColors.cFFFFFF),
                  ],
                ),
              ),
            ),

            UIHelper.verticalSpace(18.h),

            // ========== Hours & Minutes Picker ==========
            Row(
              children: [
                _buildTimeControl(
                  label: 'Hours',
                  value: hours.toString(),
                  onDecrement: hours > 0 ? () => setState(() => hours--) : null,
                  onIncrement: () => setState(() => hours++),
                ),
                const Spacer(),
                _buildTimeControl(
                  label: 'Minutes',
                  value: minutes.toString().padLeft(2, '0'),
                  onDecrement: () {
                    if (minutes > 0) {
                      setState(() => minutes--);
                    } else if (hours > 0) {
                      setState(() {
                        minutes = 59;
                        hours--;
                      });
                    }
                  },
                  onIncrement: () {
                    if (minutes < 59) {
                      setState(() => minutes++);
                    } else {
                      setState(() {
                        minutes = 0;
                        hours++;
                      });
                    }
                  },
                ),
              ],
            ),

            UIHelper.verticalSpace(18.h),
            // ========== Add Record Button  ==========
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: Material(
                color: AppColors.c87B842,
                borderRadius: BorderRadius.circular(999.r),
                child: InkWell(
                  borderRadius: BorderRadius.circular(999.r),
                  splashColor: widget.isLoading
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.3),
                  highlightColor: widget.isLoading
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.15),
                  onTap: widget.isLoading
                      ? null
                      : () {
                    widget.onAddPressed(
                      activity: selectedWalkingType,
                      hours: hours,
                      minutes: minutes,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: widget.isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.8,
                        strokeCap: StrokeCap.round,
                      ),
                    )
                        : Text(
                      'Add Record',
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeControl({
    required String label,
    required String value,
    required VoidCallback? onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextFontStyle.textStyle14w400cA3A3A3poppins),
        UIHelper.verticalSpace(4.h),
        Container(
          decoration: ShapeDecoration(
            color: AppColors.c2A2A2A,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onDecrement,
                  child: SvgPicture.asset(AppIcons.mintuesicon, height: 18.h),
                ),
                UIHelper.horizontalSpace(16.w),
                Text(value,
                    style: TextFontStyle.textStyle14w400cBABABApoppins
                        .copyWith(fontSize: 16.sp)),
                UIHelper.horizontalSpace(16.w),
                GestureDetector(
                  onTap: onIncrement,
                  child: SvgPicture.asset(AppIcons.plusiconadd, height: 18.h),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
