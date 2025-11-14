import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/custom_stepbar.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_emotional-symptoms.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_frequency.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_physical_symptoms.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_slider.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/dropdwon_button.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

import '../../../../helpers/di.dart';

class RecoveryStepTwoScreen extends StatefulWidget {
  const RecoveryStepTwoScreen({super.key});

  @override
  State<RecoveryStepTwoScreen> createState() => _RecoveryStepTwoScreenState();
}

class _RecoveryStepTwoScreenState extends State<RecoveryStepTwoScreen> {
  double sliderValue = 0.3;
  String selectedSymptom = 'Headaches';
  String? selectedFrequency;
  String selectedDuration = '2-3'; // Default numerical value
  List<String> durationList = ['1-2 hour','2-3 hour', '3-4 hour', '4-6 hour']; // Display values with "hour"
  String selectedEmotional = 'Emotional';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: Column(
                children: [
                  CustomAppbarWidget(
                    onTap: () {
                      NavigationService.goBack();
                    },
                    text: 'Your Recovery Journey',
                  ),
                  UIHelper.verticalSpace(24.h),
                  CustomStepBar(
                    currentStep: 1,
                    onTap: () {
                      NavigationService.navigateTo(
                        Routes.recoveryStepThreeScreen,
                      );
                    },
                    onStepTap: (int index) {},
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(24.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: Column(
                  children: [
                    /// ===================== Physical Symptoms =====================
                    CustomPhysicalSymptoms(
                      title: 'Physical Symptoms',
                      selectedSymptom: selectedSymptom,
                      onSelected: (value) {
                        setState(() {
                          selectedSymptom = value;
                        });
                      },
                    ),

                    UIHelper.verticalSpace(24.h),

                    /// ===================== Physical Symptom Details =====================
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
                            horizontal: 12.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$selectedSymptom Level',
                              style: TextFontStyle.textStyle14w400cA3A3A3poppins
                                  .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            UIHelper.verticalSpace(12.h),

                            CustomSlider(
                              initialValue: sliderValue,
                              onChanged: (value) {
                                setState(() {
                                  sliderValue = value;
                                });
                              },
                            ),

                            UIHelper.verticalSpace(16.h),

                            /// ===================== Frequency =====================
                            Text(
                              'Frequency',
                              style: TextFontStyle.textStyle14w400cA3A3A3poppins
                                  .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            UIHelper.verticalSpace(12.h),

                            Row(
                              children: [
                                Expanded(
                                  child: CustomFrequency(
                                    text: 'Rarely',
                                    isSelected: selectedFrequency == 'Rarely',
                                    onTap: () {
                                      setState(() {
                                        selectedFrequency = 'Rarely';
                                      });
                                    },
                                  ),
                                ),
                                UIHelper.horizontalSpace(10.w),
                                Expanded(
                                  child: CustomFrequency(
                                    text: 'Weekly',
                                    isSelected: selectedFrequency == 'Weekly',
                                    onTap: () {
                                      setState(() {
                                        selectedFrequency = 'Weekly';
                                      });
                                    },
                                  ),
                                ),
                                UIHelper.horizontalSpace(10.w),
                                Expanded(
                                  child: CustomFrequency(
                                    text: 'Daily',
                                    isSelected: selectedFrequency == 'Daily',
                                    onTap: () {
                                      setState(() {
                                        selectedFrequency = 'Daily';
                                      });
                                    },
                                  ),
                                ),
                                UIHelper.horizontalSpace(10.w),
                                Expanded(
                                  child: CustomFrequency(
                                    text: 'Not sure',
                                    isSelected: selectedFrequency == 'Not sure',
                                    onTap: () {
                                      setState(() {
                                        selectedFrequency = 'Not sure';
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),

                            UIHelper.verticalSpace(16.h),

                            /// ===================== Duration =====================
                            Text(
                              'Duration',
                              style: TextFontStyle.textStyle14w400cA3A3A3poppins
                                  .copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            UIHelper.verticalSpace(12.h),

                            CustomDropdownMenu(
                              items: durationList,
                              initialValue: '$selectedDuration hour', // Display with "hour"
                              onChanged: (value) {
                                setState(() {
                                  // Store only the numerical part (e.g., "2-3" or "4-6")
                                  selectedDuration = value!.replaceAll(' hour', '');
                                });
                              },
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              iconPath: AppIcons.bottomdrodwonicon,
                              iconHeight: 18,
                            ),
                          ],
                        ),
                      ),
                    ),

                    UIHelper.verticalSpace(12.h),

                    /// ===================== Emotional Symptoms =====================
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
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Emotional Symptoms',
                              style: TextFontStyle.textStyle14w400cA3A3A3poppins
                                  .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            UIHelper.verticalSpace(16.h),
                            Row(
                              children: [
                                CustomEmotionalSymptoms(
                                  title: 'Irritability',
                                  isSelected:
                                  selectedEmotional == 'Irritability',
                                  onTap: () {
                                    setState(() {
                                      selectedEmotional = 'Irritability';
                                    });
                                  },
                                ),
                                CustomEmotionalSymptoms(
                                  title: 'Anxiety',
                                  isSelected: selectedEmotional == 'Anxiety',
                                  onTap: () {
                                    setState(() {
                                      selectedEmotional = 'Anxiety';
                                    });
                                  },
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(12.h),
                            Row(
                              children: [
                                CustomEmotionalSymptoms(
                                  title: 'Depression',
                                  isSelected: selectedEmotional == 'Depression',
                                  onTap: () {
                                    setState(() {
                                      selectedEmotional = 'Depression';
                                    });
                                  },
                                ),
                                CustomEmotionalSymptoms(
                                  title: 'Mood Swings',
                                  isSelected:
                                  selectedEmotional == 'Mood Swings',
                                  onTap: () {
                                    setState(() {
                                      selectedEmotional = 'Mood Swings';
                                    });
                                  },
                                ),
                              ],
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
                        // Log all selected values
                        log('==============================');
                        log('💪 Physical Symptom: $selectedSymptom');
                        log('📊 Symptom Level (Slider): ${sliderValue.toStringAsFixed(2)}');
                        log('🔁 Frequency: ${selectedFrequency ?? "Not selected"}');
                        log('⏱ Duration: $selectedDuration'); // Logs "2-3" or "4-6"
                        log('😔 Emotional Symptom: $selectedEmotional');
                        log('==============================');

                        appData.write(kKeyPhysicalSymptom, selectedSymptom);
                        appData.write(kKeySymptomLevel, sliderValue);
                        appData.write(kKeyFrequency, selectedFrequency);
                        appData.write(kKeyDuration, selectedDuration); // Stores "2-3" or "4-6"
                        appData.write(kKeyEmotionalSymptom, selectedEmotional);

                        log('+++++++++physical_symptom_details: ${appData.read(kKeyPhysicalSymptom)}');
                        log('+++++++++physical_symptom_frequency: ${appData.read(kKeySymptomLevel)}');
                        log('+++++++++Frequency: ${appData.read(kKeyFrequency)}');
                        log('+++++++++Duration: ${appData.read(kKeyDuration)}'); // Logs "2-3" or "4-6"
                        log('+++++++++Emotional Symptom: ${appData.read(kKeyEmotionalSymptom)}');

                        // Navigate to next step
                        NavigationService.navigateTo(
                          Routes.recoveryStepThreeScreen,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
