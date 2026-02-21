
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_shimmer_image.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/log_activity_calander.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';

class DailySummeryScreen extends StatefulWidget {
  const DailySummeryScreen({super.key});

  @override
  State<DailySummeryScreen> createState() => _DailySummeryScreenState();
}

class _DailySummeryScreenState extends State<DailySummeryScreen> {

  TextEditingController timeController = TextEditingController();
  DateTime? selectedDateTime;
  String selectedTime = '18:30:00';


  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.bacroundColorBlack,
        body: Column(
          children: [
            UIHelper.verticalSpace(45),
            CustomAppbarWidget(
              onTap:() =>  NavigationService.goBack,
              text: 'Daily Summary',
              subtitle: 'Review your daily food intake',
           ),
            UIHelper.verticalSpace(24),





            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text('Select Date', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                  UIHelper.verticalSpace(4.h),
                  LogActivityTimePicker(
                    controller: timeController,
                    hintText: 'dd/mm/yyyyy',
                    onTimeSelected: (DateTime selectedTime) {
                      setState(() {
                        selectedDateTime = selectedTime; // This combines date and time
                        this.selectedTime = DateFormat('HH:mm:ss').format(selectedTime);
                      });
                    },
                  ),
                  UIHelper.verticalSpace(16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 153.50,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF181818),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFF454545),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Calories",style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(color: Colors.grey),),
                            Text("620",style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(color: AppColors.c87B842,fontWeight: FontWeight.w700),)
                          ],
                        ),
                      ),
                      Container(width: 153.50,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF181818),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFF454545),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Items Logged",style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(color: Colors.grey),),
                            Text("1",style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(color: AppColors.cFFFFFF,fontWeight: FontWeight.w700),)
                          ],
                        ),
                      )
                    ],
                  ),

                  UIHelper.verticalSpace(16.h),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF181818),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),child: Row(
                    children: [
                      ShimmerImage(imageUrl: personImageUrl, placeholder: AppImages.placeholderImage, height: 75, width: 75),
                      UIHelper.horizontalSpaceMedium,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Greek Toast",style: TextFontStyle.textStyle16w400c87B842poppins.copyWith(color: Colors.white,fontWeight: FontWeight.w700),),
                                IconButton(onPressed: (){}, icon:Icon(Icons.delete,color: Colors.grey,))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("425 Calories",style: TextFontStyle.textStyle16w400c87B842poppins.copyWith(color: AppColors.c87B842,fontWeight: FontWeight.w700),),
                                Row(
                                  children: [
                                    Icon(Icons.watch_later_outlined,color: Colors.grey,),
                                    UIHelper.horizontalSpace(4),
                                    Text("8:00 AM",style: TextFontStyle.textStyle16w400c5C5C5C,),
                                  ],
                                )

                              ],
                            ),
                            UIHelper.verticalSpace(08),
                            Container(
                              width: 125,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                              decoration: ShapeDecoration(
                                color:   Color(0x33FFB84D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),child:   Row(
                              children: [
                                Icon(Icons.coffee ,color: Colors.orange),
                                UIHelper.horizontalSpace(4),
                                Text("8:00 AM",style: TextFontStyle.textStyle16w400c5C5C5C.copyWith(
                                  color: Colors.orange
                                ),),
                              ],
                            ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  ),
                  UIHelper.verticalSpace(16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF181818),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF454545),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.email ,color: Colors.white),
                              UIHelper.horizontalSpace(4),
                              Text("Email Summary",style: TextFontStyle.textStyle16w400c5C5C5C.copyWith(
                                  color: Colors.white
                              ),),
                            ],
                          ),InkWell(
                              onTap: (){
                                NavigationService.navigateTo(Routes.dailySummerySettingsScreen);
                              },
                              child: Icon(Icons.settings,color: AppColors.c87B842,))
                        ],
                      ),
                      UIHelper.verticalSpace(08),
                      Text("Configure dietitian email in Settings to enable automatic daily summaries",style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(color: Colors.grey,fontSize: 15
                      ),),
                    ],
                  ),
                  )
                  ],
              ),
            ),

          ],
        ),


      ),
    );
  }
}
