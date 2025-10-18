
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import '../../../../assets_helper/app_icons.dart';




class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String> onChanged;
  final String hintText;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.hintText = 'Select an option',
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedValue.isEmpty ? null : selectedValue,
      validator: (value) {
        if (value == null || value.isEmpty || value == hintText) {
          return "Please select an option";
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
              decoration: ShapeDecoration(
                color: AppColors.c2A2A2A,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: PopupMenuButton<String>(
                color: const Color(0xFF2A2A2A),
                onSelected: (String value) {
                  state.didChange(value);
                  onChanged(value);
                },
                itemBuilder: (BuildContext context) {
                  return items.map<PopupMenuEntry<String>>((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                            .copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList();
                },
                offset: const Offset(30, 40),
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedValue.isEmpty ? hintText : selectedValue,
                      maxLines: 1,
                      style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                        color: selectedValue.isEmpty || selectedValue == hintText
                            ? AppColors.cA3A3A3
                            : Colors.white,
                      ),
                    ),
                    SvgPicture.asset(
                      AppIcons.bottomdrodwonicon,
                      height: 18.h,
                      color: AppColors.c87B842,
                    ),
                  ],
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: EdgeInsets.only(top: 4.h, left: 4.w),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: Colors.red, fontSize: 12.sp),
                ),
              ),
          ],
        );
      },
    );
  }
}
