// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
// import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
// import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/new_record.dart';
// import 'package:ktmtommy_apps/helpers/navigation_service.dart';
// import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
// import 'package:ktmtommy_apps/networks/api_acess.dart';
//
// class LogStepsScreen extends StatefulWidget {
//   const LogStepsScreen({super.key});
//
//   @override
//   State<LogStepsScreen> createState() => _LogStepsScreenState();
// }
//
// class _LogStepsScreenState extends State<LogStepsScreen> {
//   final isLoading = false.obs;
//
//
//
//   @override
//   void initState() {
//
//     getRecentStepRxObj.getAllRecentStepsApi();
//
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bacroundColorBlack,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomAppbarWidget(
//                 onTap: () {
//                   NavigationService.goBack;
//                 },
//                 text: 'Log Steps',
//               ),
//               UIHelper.verticalSpace(18.h),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('New Record',
//                           style: TextFontStyle.textStyle24w600cFFFFFFpoppins
//                               .copyWith(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w500)),
//                       UIHelper.verticalSpace(12.h),
//                       Obx(() => NewRecord(
//                             title: "Select activity",
//                             initialWalkingType: "Brisk Walk",
//                             initialHours: 0,
//                             initialMinutes: 30,
//                             isLoading: isLoading.value,
//                             onAddPressed: (
//                                 {required activity,
//                                 required hours,
//                                 required minutes}) async {
//                               log("==============Activity:$activity");
//                               log("==============Hours:$hours");
//                               log("==============Minutes:$minutes");
//                               isLoading.value = true;
//
//                               try {
//                                 await logStepsScreenRxObj.storeStepsPostApi(
//                                   activity: activity,
//                                   hours: hours,
//                                   minutes: minutes,
//                                 );
//                                 Get.back();
//                               } catch (e) {
//                                 return;
//                               } finally {
//                                 isLoading.value = false;
//                               }
//                             },
//                           )),
//                       UIHelper.verticalSpace(18.h),
//                       Text('Recent Steps',
//                           style: TextFontStyle.textStyle24w600cFFFFFFpoppins
//                               .copyWith(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w500)),
//                       UIHelper.verticalSpace(12.h),
//                       ListView.separated(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.vertical,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             width: double.infinity,
//                             decoration: ShapeDecoration(
//                               color: AppColors.c181818,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12.r),
//                               ),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 12.w, vertical: 13.h),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       SvgPicture.asset(AppIcons.logSteps),
//                                       UIHelper.horizontalSpace(16.w),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text('25 min walk',
//                                               style: TextFontStyle
//                                                   .textStyle24w600cFFFFFFpoppins
//                                                   .copyWith(
//                                                       fontSize: 16.sp,
//                                                       fontWeight:
//                                                           FontWeight.w400)),
//                                           UIHelper.verticalSpace(4.h),
//                                           Text('Yesterday, 8:00 PM',
//                                               style: TextFontStyle
//                                                   .textStyle16w400c757575poppins
//                                                   .copyWith(fontSize: 12.sp))
//                                         ],
//                                       ),
//                                       Spacer(),
//                                       Material(
//                                         color: Colors.transparent,
//                                         child: InkWell(
//                                           onTap: () {
//
//                                             log("==============Delate Icon Clicked");
//                                           },
//                                           borderRadius:
//                                               BorderRadius.circular(8.r),
//                                           child: Padding(
//                                             padding: EdgeInsets.all(4.w),
//                                             child: SvgPicture.asset(
//                                               AppIcons.deleteicon,
//                                               height: 24.h,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         separatorBuilder: (BuildContext context, int index) {
//                           return UIHelper.verticalSpace(12.h);
//                         },
//                         itemCount: 5,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

///=======================Uper code row code ================================///


import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/model/get_recent_step_model.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/new_record.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class LogStepsScreen extends StatefulWidget {
  const LogStepsScreen({super.key});

  @override
  State<LogStepsScreen> createState() => _LogStepsScreenState();
}

class _LogStepsScreenState extends State<LogStepsScreen> {
  final screenLoading = true.obs;
  final actionLoading = false.obs;

  @override
  void initState() {
    loadRecentSteps();
    super.initState();
  }

  Future<void> loadRecentSteps() async {
    screenLoading.value = true;
    await getRecentStepRxObj.getAllRecentStepsApi();
    screenLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.bacroundColorBlack,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppbarWidget(
                    onTap: () => NavigationService.goBack,
                    text: 'Log Steps',
                  ),
                  UIHelper.verticalSpace(18.h),

                  Expanded(
                    child: Obx(
                          () => screenLoading.value
                          ? const Center(
                        child: CircularProgressIndicator(color: AppColors.c87B842),
                      )
                          : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New Record',
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            UIHelper.verticalSpace(12.h),

                            /// ADD RECORD POPUP LOADER
                            NewRecord(
                              title: "Select activity",
                              initialWalkingType: "Brisk Walk",
                              initialHours: 0,
                              initialMinutes: 30,


                              isLoading: false,

                              onAddPressed: ({
                                required activity,
                                required hours,
                                required minutes,
                              }) async {
                                actionLoading.value = true;

                                try {
                                  await logStepsScreenRxObj.storeStepsPostApi(
                                    activity: activity,
                                    hours: hours,
                                    minutes: minutes,
                                  );

                                  Get.back();

                                  await loadRecentSteps();

                                } catch (e) {
                                  log("Add Error: $e");
                                } finally {
                                  actionLoading.value = false;
                                }
                              },
                            ),

                            UIHelper.verticalSpace(18.h),
                            Text(
                              'Recent Steps',
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            UIHelper.verticalSpace(12.h),

                            FutureBuilder<GetRecentStepModel>(
                              future: getRecentStepRxObj.dataFetcher.first,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                                  return Center(
                                    child: Text(
                                      "No walking records yet",
                                      style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  );
                                }
                                ///============Recent Steps Data================
                                final stepsList = snapshot.data!.data!;
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: stepsList.length,
                                  separatorBuilder: (_, __) => UIHelper.verticalSpace(12.h),
                                  itemBuilder: (context, index) {
                                    final item = stepsList[index];

                                    String durationText = "";
                                    if (item.hours! > 0) {
                                      durationText += "${item.hours}h ";
                                    }
                                    if (item.minutes! > 0) {
                                      durationText += "${item.minutes}m";
                                    }
                                    if (durationText.isEmpty) durationText = "0m";

                                    return Container(
                                      decoration: ShapeDecoration(
                                        color: AppColors.c181818,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(AppIcons.logSteps),
                                            UIHelper.horizontalSpace(16.w),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${item.activity} • $durationText",
                                                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  UIHelper.verticalSpace(4.h),
                                                  Text(
                                                    item.recordedAt ?? "",
                                                    style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /// DELETE WITH LOADER
                                            InkWell(
                                              onTap: () async {
                                                actionLoading.value = true; // center loader

                                                try {
                                                  await deleteStepsRxObj.deleteLogStepsApi(id: item.id.toString());

                                                  await loadRecentSteps(); // reload
                                                } catch (e) {
                                                  Get.back();
                                                  log("Delete Error: $e");
                                                } finally {
                                                  actionLoading.value = false; // loader off
                                                }
                                              },

                                              child: SvgPicture.asset(AppIcons.deleteicon, height: 24.h),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// DELETE LOADER (CENTER)
        Obx(() => actionLoading.value
            ? Container(
          color: Colors.black38,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.c87B842,
            ),
          ),
        )
            : const SizedBox.shrink()),

      ],
    );
  }
}






