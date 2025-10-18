
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/widget/athlet_date_calander.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/widget/custom_shedul.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class AtheleteSheduleScreen extends StatefulWidget {
  const AtheleteSheduleScreen({super.key});

  @override
  State<AtheleteSheduleScreen> createState() => _AtheleteSheduleScreenState();
}

class _AtheleteSheduleScreenState extends State<AtheleteSheduleScreen> {
  DateTime? selectedDate;

  String getFormattedDate(DateTime date) {
    // Format as: Saturday, May 19
    return DateFormat('EEEE, MMM d').format(date);
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
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //============================== Text =====================================//
                CustomShedul(
                  text: 'My schedule',
                ),
                UIHelper.verticalSpace(24.h),

                //========================================= Expanded  ===================================================//
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            color: AppColors.c090809,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x28F55216),
                                blurRadius: 32,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(AppImages.doliamge, height: 24.h),
                                UIHelper.verticalSpace(4.h),
                                Text(
                                    'Your week, optimized for peak performance 💪 — based on your goal: Triathlon',
                                    style: TextFontStyle.textStyle20w700cFFFFFFTeko
                                        .copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ),

                        //========================================   AthletDateCalander ================================//
                        UIHelper.verticalSpace(24.h),
                        AthletDateCalander(
                          onDateSelected: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                          selectedColor: AppColors.orangeColor,
                          textColor: AppColors.cFFFFFF,
                          unselectedTextColor: AppColors.cBABABA,
                        ),
                        UIHelper.verticalSpace(24.h),

                        //======================================= FullBodyStrength ===========================================//
                        Container(
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedDate != null
                                      ? getFormattedDate(selectedDate!)
                                      : 'Saturday, May 19', // default
                                  textAlign: TextAlign.center,
                                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins,
                                ),
                                UIHelper.verticalSpace(8.h),
                                Text(
                                  'Full body Strength',
                                  style: TextFontStyle.textStyle24w600cF55216poppins
                                      .copyWith(fontSize: 20.sp),
                                ),
                                UIHelper.verticalSpace(18.h),

                                Row(
                                  children: [
                                    Container(
                                      decoration: ShapeDecoration(
                                        color: AppColors.c202020,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.r),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(AppIcons.clockminicon,
                                                height: 16.h),
                                            UIHelper.horizontalSpace(4.w),
                                            Text(
                                              '45 mins',
                                              textAlign: TextAlign.center,
                                              style: TextFontStyle
                                                  .textStyle24w600cFFFFFFpoppins
                                                  .copyWith(
                                                  fontSize: 16.sp,
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(12.w),
                                    Expanded(
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          color: AppColors.c202020,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w, vertical: 10.h),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(AppIcons.powericon,
                                                  height: 16.h),
                                              UIHelper.horizontalSpace(4.w),
                                              Text(
                                                'Form & Power',
                                                textAlign: TextAlign.center,
                                                style: TextFontStyle
                                                    .textStyle24w600cFFFFFFpoppins
                                                    .copyWith(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                UIHelper.verticalSpace(12.h),

                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 10.h),
                                      decoration: ShapeDecoration(
                                        color: AppColors.c202020,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.r),
                                        ),
                                      ),
                                      child: Text(
                                        'Power',
                                        textAlign: TextAlign.center,
                                        style: TextFontStyle
                                            .textStyle24w600cFFFFFFpoppins
                                            .copyWith(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(12.w),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 10.h),
                                        decoration: ShapeDecoration(
                                          color: AppColors.c202020,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20.r),
                                          ),
                                        ),
                                        child: Text(
                                          'Endurance',
                                          textAlign: TextAlign.center,
                                          style: TextFontStyle
                                              .textStyle24w600cFFFFFFpoppins
                                              .copyWith(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(12.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 10.h),
                                      decoration: ShapeDecoration(
                                        color: AppColors.c202020,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.r),
                                        ),
                                      ),
                                      child: Text(
                                        'Form',
                                        textAlign: TextAlign.center,
                                        style: TextFontStyle
                                            .textStyle24w600cFFFFFFpoppins
                                            .copyWith(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),

                                UIHelper.verticalSpace(18.h),

                                Container(
                                  width: double.infinity,
                                  decoration: ShapeDecoration(
                                    color: AppColors.c202020,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.h, horizontal: 16.w),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(AppIcons.coachtipicon,
                                            height: 40.h),
                                        UIHelper.horizontalSpace(8.w),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Coach Tip',
                                              style: TextFontStyle
                                                  .textStyle16w400c757575poppins
                                                  .copyWith(fontSize: 14.sp),
                                            ),
                                            UIHelper.verticalSpace(4.h),
                                            Text(
                                              '"Stay slow on the negative\nreps to maximize muscle\nengagement and prevent\ninjury"',
                                              style: TextFontStyle
                                                  .textStyle24w600cFFFFFFpoppins
                                                  .copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                  FontWeight.w400),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpace(18.h),

                                CustomButtonWidget(
                                  onTap: () {},
                                  textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.orangebutton)),
                                  text: 'Mark as complete',
                                ),
                              ],
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(20.h),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
