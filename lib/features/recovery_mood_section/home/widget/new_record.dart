import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/custom_minitues.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/custom_walking.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class NewRecord extends StatelessWidget {
  final String title;

  const NewRecord({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: ShapeDecoration(
        color:  AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                title,

                style:  TextFontStyle.textStyle14w400cA3A3A3poppins
            ),
            UIHelper.verticalSpace(4.h),
            CustomWalking(),
            UIHelper.verticalSpace(18.h),

            CustomMinitues(
              onHoursChanged: (hours) {
                print('Hours changed to: $hours');
                // Add your custom logic here
              },
              onMinutesChanged: (minutes) {
                print('Minutes changed to: $minutes');
              },
            ),
            UIHelper.verticalSpace(18.h),



//=========================== Button ===========================//

            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                onTap: () {
                  print("✅ Add Record tapped");
                },
                borderRadius: BorderRadius.circular(12.r),
                splashColor: AppColors.c87B842,
                highlightColor: AppColors.c87B842,
                child: CustomButtonWidget(
                  text: 'Add Record',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}