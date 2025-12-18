import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/model/GetAllSleep.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';


class RecentSleep extends StatelessWidget {
  final GetAllSleepDataModel sleepLogs;




  const RecentSleep({
    super.key,
   required this.sleepLogs,



  });

  @override
  Widget build(BuildContext context) {


    // Add this helper function in your widget file or a separate utility file
    String formatTime({required String timeString}) {
      if (timeString.isEmpty) return "--:--";

      try {
        String timeOnly = timeString;

        if (timeString.contains(' ')) {
          List<String> parts = timeString.split(' ');
          if (parts.length > 1) {
            timeOnly = parts[1]; // Get the time part
          }
        }

        List<String> timeParts = timeOnly.split(':');
        if (timeParts.length >= 2) {
          return '${timeParts[0]}:${timeParts[1]}';
        }

        return timeOnly;
      } catch (e) {
        return "--:--";
      }
    }


    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: sleepLogs.data?.length ,
            itemBuilder: (context, index) {


              final data = sleepLogs.data?[index];

              return  Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/signureicon.svg',
                      height: 24.h,
                      color: AppColors.orangeColor,
                    ),
                    UIHelper.horizontalSpace(20.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${formatTime(timeString:data!.bedTime.toString() )} - ${formatTime(timeString:data.wakeUpTime.toString() )}",
                                  style: TextFontStyle
                                      .textStyle24w600cFFFFFFpoppins
                                      .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              UIHelper.horizontalSpace(20.w),
                              Text(
                                data.duration.toString()??"",
                                style: TextFontStyle
                                    .textStyle24w600cFFFFFFpoppins
                                    .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(4.h),
                          Text(
                            data.dateHuman.toString()??"",
                            style: TextFontStyle.textStyle16w400c757575poppins
                                .copyWith(fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap:() async {

                          bool success = await deleteSleepRx.deleteSleepApiInfo(id: data.id);

                          if(success){
                            getRecentSleepRx.getRecentSleepInfo();
                          }


                        },
                        borderRadius: BorderRadius.circular(8.r),
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: SvgPicture.asset(
                            'assets/icons/deleteicon.svg',
                            height: 24.h,
                            color: AppColors.orangeColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }}
