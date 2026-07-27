import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart'; // নতুন যোগ করা
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/calander_custom.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/custom_stepbar.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/tbi_custom.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class RecoveryStepOneScreen extends StatefulWidget {
  const RecoveryStepOneScreen({super.key});

  @override
  State<RecoveryStepOneScreen> createState() => _RecoveryStepOneScreenState();
}

class _RecoveryStepOneScreenState extends State<RecoveryStepOneScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController dateController = TextEditingController();


  DateTime? selectedDate;

  final List<String> images = [
    'assets/images/recoverimage.png',
    'assets/images/ongoingimage.png',
    'assets/images/advenceimage.png',
    'assets/images/maintenaceimage.png',
  ];

  final List<String> titles = [
    'Early Recover Phase',
    'Ongoing Rehabilitation',
    'Advanced Recovery',
    'Ongoing Maintenance (Long Term)',
  ];

  List<String> injuryList = ['Injury 1', 'Injury 2', 'Injury 3', 'Injury 4'];
  String selectedInjury = 'Injury 1';
  String selectedInjuryLevel = 'Mid';
  int selectedIndex = -1;

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbarWidget(
                onTap: () {
                  NavigationService.goBack;
                },
                text: 'Your Recovery Journey',
              ),
              UIHelper.verticalSpace(24.h),
              CustomStepBar(
                currentStep: 0,
                onTap: () {
                  NavigationService.navigateTo(Routes.recoveryStepTwoScreen);
                },
                onStepTap: (int index) {},
              ),
              UIHelper.verticalSpace(24.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        /// ===================== Injury Name =====================
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Injury Name',
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                .copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF2A2A2A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedInjury,
                                textAlign: TextAlign.center,
                                style: TextFontStyle
                                    .textStyle24w600cFFFFFFpoppins
                                    .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              PopupMenuButton<String>(
                                color: AppColors.c2A2A2A,
                                padding: EdgeInsets.zero,
                                icon: SvgPicture.asset(
                                    AppIcons.bottomdrodwonicon,
                                    height: 18.h),
                                onSelected: (String value) {
                                  setState(() {
                                    selectedInjury = value;
                                  });
                                },
                                itemBuilder: (BuildContext context) {
                                  return injuryList.map((String item) {
                                    return PopupMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.cFFFFFF,
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                        ),

                        UIHelper.verticalSpace(16.h),

                        /// ===================== Injury Level =====================
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Injury Level',
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                .copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(16.h),

                        Row(
                          children: [
                            TbiCustom(
                              title: 'Mid',
                              isSelected: selectedInjuryLevel == 'Mid',
                              onTap: () {
                                setState(() {
                                  selectedInjuryLevel = 'Mid';
                                });
                              },
                            ),
                            TbiCustom(
                              title: 'Moderate',
                              isSelected: selectedInjuryLevel == 'Moderate',
                              onTap: () {
                                setState(() {
                                  selectedInjuryLevel = 'Moderate';
                                });
                              },
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(12.h),
                        Row(
                          children: [
                            TbiCustom(
                              title: 'Severe',
                              isSelected: selectedInjuryLevel == 'Severe',
                              onTap: () {
                                setState(() {
                                  selectedInjuryLevel = 'Severe';
                                });
                              },
                            ),
                            TbiCustom(
                              title: 'Other',
                              isSelected: selectedInjuryLevel == 'Other',
                              onTap: () {
                                setState(() {
                                  selectedInjuryLevel = 'Other';
                                });
                              },
                            ),
                          ],
                        ),

                        UIHelper.verticalSpace(24.h),

                        /// ===================== Injury Date =====================
                        Container(
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Injury Date',
                                  style: TextFontStyle
                                      .textStyle24w600cFFFFFFpoppins
                                      .copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                UIHelper.verticalSpace(12.h),
                                FormField<String>(
                                  validator: (value) {
                                    if (selectedDate == null) {
                                      return 'Please select injury date';
                                    }
                                    return null;
                                  },
                                  builder: (formFieldState) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CalanderCustom(
                                          controller: dateController,
                                          hintText: 'Select Date',
                                          onDateSelected: (DateTime date) {
                                            setState(() {
                                              selectedDate = date;
                                            });
                                            formFieldState.didChange('');
                                          },
                                        ),
                                        if (formFieldState.hasError)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 6.h, left: 8.w),
                                            child: Text(
                                              formFieldState.errorText!,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        UIHelper.verticalSpace(24.h),

                        /// ===================== Recovery Stage =====================
                        Container(
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Recovery Stage',
                                  style: TextFontStyle
                                      .textStyle24w600cFFFFFFpoppins
                                      .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                UIHelper.verticalSpace(12.w),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: titles.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final isSelected = selectedIndex == index;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Container(
                                        margin:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 8.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.c2A2A2A,
                                          borderRadius:
                                          BorderRadius.circular(20.r),
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.c87B842
                                                : Colors.transparent,
                                            width: 2.w,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              images[index],
                                              height: 32.h,
                                            ),
                                            UIHelper.horizontalSpace(10.h),
                                            Expanded(
                                              child: Text(
                                                titles[index],
                                                style: TextFontStyle
                                                    .textStyle14w400cA3A3A3poppins,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        UIHelper.verticalSpace(32.h),

                        /// ===================== Next Button =====================
                        CustomButtonWidget(
                          text: 'Next',
                          onTap: () {
                            log("=================Next Button Click go to recoveryStepTwoScreen");
                            if (_formKey.currentState?.validate() ?? false) {
                              if (selectedIndex == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please select your recovery stage.'),
                                  ),
                                );
                                return;
                              }

                              if (selectedDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please select injury date.')),
                                );
                                return;
                              }


                              final String formattedDate =
                              DateFormat('yyyy-MM-dd').format(selectedDate!);


                              log('==============================');
                              log('Injury Name: $selectedInjury');
                              log('Injury Level: $selectedInjuryLevel');
                              log('"injury_date": "$formattedDate"');
                              log('Current Recovery Stage: ${titles[selectedIndex]}');
                              log('==============================');


                              appData.write(kKeyInjuryName, selectedInjury);
                              appData.write(kKeyInjuryLevel, selectedInjuryLevel);
                              appData.write(kKeyInjuryDate, formattedDate);
                              appData.write(kKeyRecoveryStage, titles[selectedIndex]);

                              log('+++++++++injury_name: ${appData.read(kKeyInjuryName)}');
                              log('+++++++++injury_level: ${appData.read(kKeyInjuryLevel)}');
                              log('+++++++++injury_date: ${appData.read(kKeyInjuryDate)}');
                              log('+++++++++current_recovery_stage: ${appData.read(kKeyRecoveryStage)}');

                              NavigationService.navigateTo(
                                Routes.recoveryStepTwoScreen,
                              );
                            }
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
    );
  }
}

