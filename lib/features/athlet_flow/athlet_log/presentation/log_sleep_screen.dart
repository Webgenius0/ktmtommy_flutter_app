import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/model/GetAllSleep.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/custom_night_day_time.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/recent_sleep.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class LogSleepScreen extends StatefulWidget {
  const LogSleepScreen({super.key});

  @override
  State<LogSleepScreen> createState() => _LogSleepScreenState();
}



class _LogSleepScreenState extends State<LogSleepScreen> {




  @override
  void initState() {

    getRecentSleepRx.getRecentSleepInfo();
    super.initState();

  }

  void deleteSleepLog(int index) {
    setState(() {

      ///>>>>>>>>>>>>>>>> here call the delete function >>>>>>>>>>>>
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.restbacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              children: [
                ArrowButtonAtheleteFlow(
                  text: 'Log Sleep',
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
                UIHelper.verticalSpace(24.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //============================= Night And Day Custom ========================================//
                        CustomNightDayTime(

                        ),
                        UIHelper.verticalSpace(18.h),

                        //==================================== Custom ====================================//
                        Text(
                          'Recent Sleep log',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),

                        //========================================= Recent Sleep ================================//








                        StreamBuilder<GetAllSleepDataModel>(
                          stream: getRecentSleepRx.dataFetcher,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator(color: Colors.deepOrangeAccent,));
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Error: ${snapshot.error}',
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                              return Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'No sleep data found',
                                      style: TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.w700,fontSize: 16 ),
                                    ),
                                    UIHelper.verticalSpace(16.h),
                                    Icon(Icons.sentiment_dissatisfied,color: Colors.deepOrangeAccent,size: 80,)
                                  ],
                                ),
                              );
                            }

                            final sleepData = snapshot.data!;

                            return RecentSleep(
                              sleepLogs: sleepData ,

                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}