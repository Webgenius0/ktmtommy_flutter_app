import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';





class WeeksDropdwon extends StatefulWidget {
  final List<String> items;
  final String initialValue;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? padding;
  final double? iconHeight;
  final String? iconPath;

  const WeeksDropdwon({
    super.key,
    required this.items,
    required this.initialValue,
    this.onChanged,
    this.padding,
    this.iconHeight = 18,
    this.iconPath,
  });

  @override
  State<WeeksDropdwon> createState() => _WeeksDropdwonState();
}

class _WeeksDropdwonState extends State<WeeksDropdwon> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 12.w),
      decoration: ShapeDecoration(
        color: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedValue,
            textAlign: TextAlign.center,
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          PopupMenuButton<String>(
            color: AppColors.c2A2A2A,
            padding: EdgeInsets.zero,
            icon: widget.iconPath != null
                ? SvgPicture.asset(
              widget.iconPath!,
              height: widget.iconHeight?.h,
            )
                : Icon(
              Icons.arrow_drop_down,
              color: AppColors.cFFFFFF,
              size: (widget.iconHeight ?? 18).h,
            ),
            onSelected: (String value) {
              setState(() {
                selectedValue = value;
              });
              widget.onChanged?.call(value);
            },
            itemBuilder: (BuildContext context) {
              return widget.items.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.cFFFFFF,
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}