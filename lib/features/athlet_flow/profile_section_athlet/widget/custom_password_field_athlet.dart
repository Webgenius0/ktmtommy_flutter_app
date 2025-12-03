import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';

import '../../../../assets_helper/app_colors.dart';
import '../../../../assets_helper/app_icons.dart';

class CustomPasswordFieldAthlet extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String> validator;

  const CustomPasswordFieldAthlet({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  @override
  State<CustomPasswordFieldAthlet> createState() => _CustomPasswordFieldAthletState();
}

class _CustomPasswordFieldAthletState extends State<CustomPasswordFieldAthlet> {
  bool obscureText = true;

  OutlineInputBorder _inputBorder({Color color = Colors.transparent}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(color: color, width: 1.0), // 1px border
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      validator: widget.validator,
      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.cA3A3A3, fontSize: 15.sp),
        filled: true,
        fillColor: AppColors.c181818,

        // Lock SVG Icon
        prefixIcon: Padding(
          padding: EdgeInsets.all(14.w),
          child: SvgPicture.asset(
            AppIcons.password_key,
            width: 24.w,
            height: 24.h,
            colorFilter: const ColorFilter.mode(AppColors.cF55216, BlendMode.srcIn),
          ),
        ),

        // Eye SVG Icons (Show/Hide)
        // Flutter Default Eye Icons
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.cF55216,
          ),
          onPressed: () {
            setState(() => obscureText = !obscureText);
          },
        ),

        // Border States
        enabledBorder: _inputBorder(color: Colors.white),
        focusedBorder: _inputBorder(color: AppColors.c87B842),
        errorBorder: _inputBorder(color: Colors.red),
        focusedErrorBorder: _inputBorder(color: Colors.red),
        border: _inputBorder(),

        errorStyle: TextStyle(color: Colors.red, fontSize: 12.sp),
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
      ),
    );
  }
}