import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/new_record.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class LogStepsScreen extends StatefulWidget {
  const LogStepsScreen({super.key});

  @override
  State<LogStepsScreen> createState() => _LogStepsScreenState();
}

class _LogStepsScreenState extends State<LogStepsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


                CustomAppbarWidget(
                  onTap: (){NavigationService.goBack;},
                  text: 'Log Steps',
                ),


                 UIHelper.verticalSpace(18.h),

              Expanded(
                child: SingleChildScrollView(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                          'New Record',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                              fontSize: 18.sp,fontWeight: FontWeight.w500
                          )
                      ),
                      UIHelper.verticalSpace(12.h),


                      NewRecord(title:    'Select activity',),

                      UIHelper.verticalSpace(18.h),
                      Text(
                          'Recent Steps',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                              fontSize: 18.sp,fontWeight: FontWeight.w500
                          )
                      ),
                      UIHelper.verticalSpace(12.h),
                      ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return

                            Container(
                            width: double.infinity,

                            decoration: ShapeDecoration(
                              color: AppColors.c181818,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
                              child: Column(
                                children: [
                                  Row(

                                    children: [
                                      SvgPicture.asset(AppIcons.logSteps),
                                      UIHelper.horizontalSpace(16.w),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '25 min walk',
                                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                                  fontSize: 16.sp,fontWeight: FontWeight.w400
                                              )
                                          ),
                                          UIHelper.verticalSpace(4.h),
                                          Text(
                                              'Yesterday, 8:00 PM',
                                              style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                                  fontSize: 12.sp
                                              )
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                          },
                                          borderRadius: BorderRadius.circular(8.r),
                                          child: Padding(
                                            padding: EdgeInsets.all(4.w),
                                            child: SvgPicture.asset(
                                              AppIcons.deleteicon,
                                              height: 24.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return UIHelper.verticalSpace(12.h);
                        },
                        itemCount: 5,



                      )


                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

