
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class CalanderToday extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CalanderToday({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<CalanderToday> createState() => _CalanderTodayState();
}

class _CalanderTodayState extends State<CalanderToday> {
  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isEmpty) {
      final now = DateTime.now();
      widget.controller.text = "Today ${now.day}/${now.month}/${now.year}";
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.orangeColor,
              onPrimary: AppColors.c2A2A2A,
              onSurface: AppColors.cFFFFFF,
              background: AppColors.orangeColor,
              surface: AppColors.c2A2A2A,
            ),
            dialogBackgroundColor: AppColors.c2A2A2A,
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.c2A2A2A,
              dividerColor: AppColors.cFFFFFF,
              headerForegroundColor: AppColors.orangeColor,
              dayOverlayColor: MaterialStateProperty.all(Colors.white10),
              yearOverlayColor: MaterialStateProperty.all(Colors.white10),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.orangeColor,
              ),
            ),
          ),
          child: MediaQuery(
       //============================= Edit Icon  Fiexd ============================//
            data: MediaQuery.of(context).copyWith(viewInsets: EdgeInsets.zero),
            child: Center(
              child: SizedBox(
                width: 350.w,
                height: 450.h,
                child: child,
              ),
            ),
          ),
        );
      },
    );

    if (picked != null) {
      final selectedDate = "${picked.day}/${picked.month}/${picked.year}";
      setState(() {
        widget.controller.text = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.c2A2A2A,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _selectDate,
              child: SvgPicture.asset(
                AppIcons.calandericon,
                height: 24.h,
                color: AppColors.orangeColor,
              ),
            ),
            UIHelper.horizontalSpace(10.w),
            Text(
              widget.controller.text.isEmpty
                  ? widget.hintText
                  : widget.controller.text,
              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
