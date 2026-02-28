import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class SpecialThanks extends StatelessWidget {
  final String title;
  const SpecialThanks({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return

      Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.c181818,
        border: Border(
          left: BorderSide(
            width: 2.w,
            color: AppColors.c87B842,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(16.h),


            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                UIHelper.horizontalSpace(6.w),
                SvgPicture.asset(
                  AppIcons.lovetwo,
                  height: 24.h,
                ),
              ],
            ),

            TextCard(
              title: "Jess",
              subTitle: "Thank you for your patience, skill, and constant encouragement. You’ve helped me understand my body better, move better, and believe that improvement is always possible.",
            ),
            TextCard(
              title: "Keelie",
              subTitle: "Your support, knowledge, and energy have made the hard days manageable and the good days even better. You’ve been a huge part of the progress behind this app.",
            ),
            TextCard(
              title: "Lindsey",
              subTitle: "Thank you for your support, belief, and encouragement throughout this journey. Having people who genuinely care makes all the difference.",
            ),
            TextCard(
              title: "Mum & Dad",
              subTitle: "For backing me, believing in the vision, and supporting the dream — not just financially, but emotionally. None of this happens without you.",
            ),
            TextCard(
              title: "Kiona",
              subTitle: "For sticking beside me through every high, every low, every crazy idea, and every big vision. Your loyalty, patience, and belief in me mean more than I can put into words. This journey is easier because you’re in it with me.",
            ),
            TextCard(
              title: "RoboFit Aus",
              subTitle: "Thank you for pushing boundaries in neurological rehabilitation and creating an environment where progress is expected, not doubted. The training, intensity, and belief in capability have directly influenced the mindset behind My Balance Day.\n\nThis app is built from lived experience, real therapy, real setbacks, and real wins.\n \n\nEvery balance day is built on the shoulders of people who refuse to accept “that’s just how it is.\”\n\nAnd for that — I am grateful.",
            ),
          ],
        ),
      ),
    );
  }
}

class TextCard extends StatelessWidget {
  const TextCard({
    super.key, required this.title, required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIHelper.verticalSpace(6.h),


        Text(
            title,
            style: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                fontSize: 14.sp,
              color: AppColors.c87B842
            )
        ),
        UIHelper.verticalSpace(4),
        Text(
            subTitle,
            style: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                fontSize: 14.sp
            )
        ),
      ],
    );
  }
}