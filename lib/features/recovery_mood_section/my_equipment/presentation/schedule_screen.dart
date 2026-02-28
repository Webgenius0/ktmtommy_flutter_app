import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/balance_dialouge_box.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/tbi_recovery.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/custom_morning.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/date_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Padding(
              padding:  EdgeInsets.all(24.sp),
              child: TBIRecovery(title: 'Schedule',widget: Image.asset( AppImages.logo225)),
            ),
            UIHelper.verticalSpace(18.h),



            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    DateWidget(
                      // onDateSelected: (date) {
                      //   print("Selected date: $date");
                      // },
                      // selectedColor: AppColors.cCC1F28,
                      // textColor: Colors.white,
                      // unselectedTextColor: AppColors.c8C8C8C,
                    ),
                    UIHelper.verticalSpace(36.h),

                    Text(
                        'Morning',
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                            fontSize: 18.sp,fontWeight: FontWeight.w500
                        )
                    ),
                    UIHelper.verticalSpace(12.h),
                    Row(
                      children: [
                        Text(
                            '9:45–10:45 AM',
                            textAlign: TextAlign.center,
                            style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                fontSize: 14.sp
                            )
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                            'therapy Activity',
                            textAlign: TextAlign.center,
                            style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                fontSize: 14.sp
                            )
                        ),
                      ],
                    ),


                  UIHelper.verticalSpace(6.h),
                    CustomMorning(title: '🏃 Physio Therapy', subtitle: 'Upcoming',icon: SvgPicture.asset(AppIcons.shedulicon)),


                   UIHelper.verticalSpace(24.h),

                    Text(
                        'Afternoon',
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                            fontSize: 18.sp,fontWeight: FontWeight.w500
                        )
                    ),
                    UIHelper.verticalSpace(12.h),
                    Row(
                      children: [
                        Text(
                            '3:00–3:45 PM',
                            textAlign: TextAlign.center,
                            style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                fontSize: 14.sp
                            )
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                            'Therapy activity',
                            textAlign: TextAlign.center,
                            style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                fontSize: 14.sp
                            )
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(6.w),

                    CustomMorning(title: '💧 Hydro Therapy', subtitle: 'Completed',icon: SvgPicture.asset(AppIcons.shedulicon)),
                    UIHelper.verticalSpace(16.w),
                    CustomButton(name: "Complete The Day", onCallBack: (){
                      showDialog(
  context: context,
  builder: (context) => const BalanceDialog(),
);

                    }, context: context,color: Colors.transparent,borderRadius: 50.r,borderColor: Color(0xFF87B842)),

                    UIHelper.verticalSpace(32.w),


                  ]
                ),
              ),
            )




          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: AppColors.c87B842,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(Icons.add, color: AppColors.c181818),
          onPressed: () {
            NavigationService.navigateTo(Routes.addSessionScreen);
            // Your action here
          },
        ),
      ),
    );
  }
}


