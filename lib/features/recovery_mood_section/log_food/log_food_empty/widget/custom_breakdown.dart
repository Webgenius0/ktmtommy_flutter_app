import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomBreakdown extends StatelessWidget {
  const CustomBreakdown({
    super.key,
    required this.traleadingTitle,
  });

  final List<Map<String, dynamic>> traleadingTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: ShapeDecoration(
          color: AppColors.c181818,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Ingredient Breakdown',
              style:  TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 18.sp,fontWeight: FontWeight.w500
              )
          ),
          UIHelper.verticalSpace(12.h),


          ListView.builder(

              itemCount: traleadingTitle.length,
              shrinkWrap: true,
              primary: false,

              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            traleadingTitle[index]["title"],
                            //nutrients[index]["title"],
                            style:  TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                fontSize: 16.sp,fontWeight: FontWeight.w400
                            )
                        ),
                        Text(
                            traleadingTitle[index]["value"],
                            // nutrients[index]["percentage"],
                            style: TextFontStyle.textStyle14w400c8C8C8Cpoppins


                        )
                      ],
                    ),

                    UIHelper.verticalSpace(4.h),
                    Divider(
                      color: AppColors.c2F2F2F,
                    ),
                    UIHelper.verticalSpace(12.h),
                  ],
                );
              }),


        ],
      ),
    );
  }
}