import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class CustomAcetaminophen extends StatelessWidget {
  const CustomAcetaminophen({
    super.key,
    required this.title,
    required this.icon,
    required this.mg,
    required this.subtitle,
    required this.deleteIcon,
    required this.onDelete,
    this.onTap, // Optional onTap callback
    this.id, // Optional id parameter
  });

  final String title;
  final String icon;
  final String mg;
  final String subtitle;
  final String deleteIcon;
  final VoidCallback onDelete;
  final VoidCallback? onTap; // Made nullable to be optional
  final String? id; // Made nullable to be optional

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Will work as is since onTap is nullable
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: 24.h),
            UIHelper.horizontalSpace(20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      UIHelper.horizontalSpace(20.w),
                      Text(
                        mg,
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    subtitle,
                    style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.horizontalSpace(10.w),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: SvgPicture.asset(
                    deleteIcon,
                    height: 24.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}