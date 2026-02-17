// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
// import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
// import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
// import 'package:ktmtommy_apps/constants/app_constants.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/custom_stepbar.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_emotional-symptoms.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_frequency.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_physical_symptoms.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_slider.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/dropdwon_button.dart';
// import 'package:ktmtommy_apps/helpers/all_routes.dart';
// import 'package:ktmtommy_apps/helpers/navigation_service.dart';
// import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
//
// import '../../../../helpers/di.dart';
//
// class RecoveryStepTwoScreen extends StatefulWidget {
//   const RecoveryStepTwoScreen({super.key});
//
//   @override
//   State<RecoveryStepTwoScreen> createState() => _RecoveryStepTwoScreenState();
// }
//
// class _RecoveryStepTwoScreenState extends State<RecoveryStepTwoScreen> {
//   double sliderValue = 0.3;
//   String selectedSymptom = 'Headaches';
//   String? selectedFrequency;
//   String selectedDuration = '2-3'; // Default numerical value
//   List<String> durationList = ['1-2 hour','2-3 hour', '3-4 hour', '4-6 hour']; // Display values with "hour"
//   String selectedEmotional = 'Emotional';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bacroundColorBlack,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24.h),
//               child: Column(
//                 children: [
//                   CustomAppbarWidget(
//                     onTap: () {
//                       NavigationService.goBack();
//                     },
//                     text: 'Your Recovery Journey',
//                   ),
//                   UIHelper.verticalSpace(24.h),
//                   CustomStepBar(
//                     currentStep: 1,
//                     onTap: () {
//                       NavigationService.navigateTo(
//                         Routes.recoveryStepThreeScreen,
//                       );
//                     },
//                     onStepTap: (int index) {},
//                   ),
//                 ],
//               ),
//             ),
//             UIHelper.verticalSpace(24.h),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: 24.h),
//                 child: Column(
//                   children: [
//                     /// ===================== Physical Symptoms =====================
//                     CustomPhysicalSymptoms(
//                       title: 'Physical Symptoms',
//                       selectedSymptom: selectedSymptom,
//                       onSelected: (value) {
//                         setState(() {
//                           selectedSymptom = value;
//                         });
//                       },
//                     ),
//
//                     UIHelper.verticalSpace(24.h),
//
//                     /// ===================== Physical Symptom Details =====================
//                     Container(
//                       width: double.infinity,
//                       decoration: ShapeDecoration(
//                         color: AppColors.c181818,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 12.w, vertical: 16.h),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '$selectedSymptom Level',
//                               style: TextFontStyle.textStyle14w400cA3A3A3poppins
//                                   .copyWith(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             UIHelper.verticalSpace(12.h),
//
//                             CustomSlider(
//                               initialValue: sliderValue,
//                               onChanged: (value) {
//                                 setState(() {
//                                   sliderValue = value;
//                                 });
//                               },
//                             ),
//
//                             UIHelper.verticalSpace(16.h),
//
//                             /// ===================== Frequency =====================
//                             Text(
//                               'Frequency',
//                               style: TextFontStyle.textStyle14w400cA3A3A3poppins
//                                   .copyWith(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             UIHelper.verticalSpace(12.h),
//
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: CustomFrequency(
//                                     text: 'Rarely',
//                                     isSelected: selectedFrequency == 'Rarely',
//                                     onTap: () {
//                                       setState(() {
//                                         selectedFrequency = 'Rarely';
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 UIHelper.horizontalSpace(10.w),
//                                 Expanded(
//                                   child: CustomFrequency(
//                                     text: 'Weekly',
//                                     isSelected: selectedFrequency == 'Weekly',
//                                     onTap: () {
//                                       setState(() {
//                                         selectedFrequency = 'Weekly';
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 UIHelper.horizontalSpace(10.w),
//                                 Expanded(
//                                   child: CustomFrequency(
//                                     text: 'Daily',
//                                     isSelected: selectedFrequency == 'Daily',
//                                     onTap: () {
//                                       setState(() {
//                                         selectedFrequency = 'Daily';
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 UIHelper.horizontalSpace(10.w),
//                                 Expanded(
//                                   child: CustomFrequency(
//                                     text: 'Not sure',
//                                     isSelected: selectedFrequency == 'Not sure',
//                                     onTap: () {
//                                       setState(() {
//                                         selectedFrequency = 'Not sure';
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             UIHelper.verticalSpace(16.h),
//
//                             /// ===================== Duration =====================
//                             Text(
//                               'Duration',
//                               style: TextFontStyle.textStyle14w400cA3A3A3poppins
//                                   .copyWith(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             UIHelper.verticalSpace(12.h),
//
//                             CustomDropdownMenu(
//                               items: durationList,
//                               initialValue: '$selectedDuration hour', // Display with "hour"
//                               onChanged: (value) {
//                                 setState(() {
//                                   // Store only the numerical part (e.g., "2-3" or "4-6")
//                                   selectedDuration = value!.replaceAll(' hour', '');
//                                 });
//                               },
//                               padding: EdgeInsets.symmetric(horizontal: 16.w),
//                               iconPath: AppIcons.bottomdrodwonicon,
//                               iconHeight: 18,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     UIHelper.verticalSpace(12.h),
//
//                     /// ===================== Emotional Symptoms =====================
//                     Container(
//                       width: double.infinity,
//                       decoration: ShapeDecoration(
//                         color: AppColors.c181818,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 16.h,
//                           horizontal: 16.w,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Emotional Symptoms',
//                               style: TextFontStyle.textStyle14w400cA3A3A3poppins
//                                   .copyWith(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             UIHelper.verticalSpace(16.h),
//                             Row(
//                               children: [
//                                 CustomEmotionalSymptoms(
//                                   title: 'Irritability',
//                                   isSelected:
//                                   selectedEmotional == 'Irritability',
//                                   onTap: () {
//                                     setState(() {
//                                       selectedEmotional = 'Irritability';
//                                     });
//                                   },
//                                 ),
//                                 CustomEmotionalSymptoms(
//                                   title: 'Anxiety',
//                                   isSelected: selectedEmotional == 'Anxiety',
//                                   onTap: () {
//                                     setState(() {
//                                       selectedEmotional = 'Anxiety';
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                             UIHelper.verticalSpace(12.h),
//                             Row(
//                               children: [
//                                 CustomEmotionalSymptoms(
//                                   title: 'Depression',
//                                   isSelected: selectedEmotional == 'Depression',
//                                   onTap: () {
//                                     setState(() {
//                                       selectedEmotional = 'Depression';
//                                     });
//                                   },
//                                 ),
//                                 CustomEmotionalSymptoms(
//                                   title: 'Mood Swings',
//                                   isSelected:
//                                   selectedEmotional == 'Mood Swings',
//                                   onTap: () {
//                                     setState(() {
//                                       selectedEmotional = 'Mood Swings';
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     UIHelper.verticalSpace(32.h),
//
//                     /// ===================== Next Button =====================
//                     CustomButtonWidget(
//                       text: 'Next',
//                       onTap: () {
//                         // Log all selected values
//                         log('==============================');
//                         log('💪 Physical Symptom: $selectedSymptom');
//                         log('📊 Symptom Level (Slider): ${sliderValue.toStringAsFixed(2)}');
//                         log('🔁 Frequency: ${selectedFrequency ?? "Not selected"}');
//                         log('⏱ Duration: $selectedDuration'); // Logs "2-3" or "4-6"
//                         log('😔 Emotional Symptom: $selectedEmotional');
//                         log('==============================');
//
//                         appData.write(kKeyPhysicalSymptom, selectedSymptom);
//                         appData.write(kKeySymptomLevel, sliderValue);
//                         appData.write(kKeyFrequency, selectedFrequency);
//                         appData.write(kKeyDuration, selectedDuration); // Stores "2-3" or "4-6"
//                         appData.write(kKeyEmotionalSymptom, selectedEmotional);
//
//                         log('+++++++++physical_symptom_details: ${appData.read(kKeyPhysicalSymptom)}');
//                         log('+++++++++physical_symptom_frequency: ${appData.read(kKeySymptomLevel)}');
//                         log('+++++++++Frequency: ${appData.read(kKeyFrequency)}');
//                         log('+++++++++Duration: ${appData.read(kKeyDuration)}'); // Logs "2-3" or "4-6"
//                         log('+++++++++Emotional Symptom: ${appData.read(kKeyEmotionalSymptom)}');
//
//                         // Navigate to next step
//                         NavigationService.navigateTo(
//                           Routes.recoveryStepThreeScreen,
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



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
  // Physical Symptoms
  String selectedPhysicalSymptom = 'Headaches';

  // Headaches Details
  double headachesSliderValue = 0.3;
  String? headachesFrequency;
  String headachesDuration = '2-3';

  // Dizziness Details
  double dizzinessSliderValue = 0.3;
  String? dizzinessFrequency;
  String dizzinessDuration = '2-3';

  // Vision Problems Details
  double visionSliderValue = 0.3;
  String? visionFrequency;
  String visionDuration = '2-3';

  // Balance Issues Details
  double balanceSliderValue = 0.3;
  String? balanceFrequency;
  String balanceDuration = '2-3';

  // Emotional Symptoms
  String selectedEmotional = 'Irritability';

  List<String> durationList = ['1-2 hour', '2-3 hour', '3-4 hour', '4-6 hour'];

  // Track expanded states for each symptom
  bool isHeadachesExpanded = true;
  bool isDizzinessExpanded = false;
  bool isVisionExpanded = false;
  bool isBalanceExpanded = false;

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
                    /// ===================== Physical Symptoms Selection =====================
                    
                    
                    
                    Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text("Physical Symptoms",style: TextFontStyle.textStyle18w500c333333.copyWith(color: Colors.white,fontSize: 18),)),
                    

                    Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text("Please toggle on the symtoms you have and fill the details.",style: TextFontStyle.textStyle18w500c333333 ,)),


                    
                    
                    
                    
                    // CustomPhysicalSymptoms(
                    //   title: 'Physical Symptoms',
                    //   selectedSymptom: selectedPhysicalSymptom,
                    //   onSelected: (value) {
                    //     setState(() {
                    //       selectedPhysicalSymptom = value;
                    //       // Auto-expand the selected symptom
                    //       isHeadachesExpanded = value == 'Headaches';
                    //       isDizzinessExpanded = value == 'Dizziness';
                    //       isVisionExpanded = value == 'Vision Problems';
                    //       isBalanceExpanded = value == 'Balance Issues';
                    //     });
                    //   },
                    // ),

                    UIHelper.verticalSpace(24.h),

                    /// ===================== Headaches Section =====================
                    _buildSymptomSection(
                      title: 'Headaches',
                      isExpanded: isHeadachesExpanded,
                      onToggle: () {
                        setState(() {
                          isHeadachesExpanded = !isHeadachesExpanded;
                        });
                      },
                      child: _buildSymptomDetails(
                        symptomLevel: 'Headaches Level',
                        sliderValue: headachesSliderValue,
                        onSliderChanged: (value) {
                          setState(() {
                            headachesSliderValue = value;
                          });
                        },
                        selectedFrequency: headachesFrequency,
                        onFrequencySelected: (frequency) {
                          setState(() {
                            headachesFrequency = frequency;
                          });
                        },
                        selectedDuration: headachesDuration,
                        onDurationChanged: (value) {
                          setState(() {
                            headachesDuration = value!.replaceAll(' hour', '');
                          });
                        },
                      ),
                    ),

                    UIHelper.verticalSpace(12.h),

                    /// ===================== Dizziness Section =====================
                    _buildSymptomSection(
                      title: 'Dizziness',
                      isExpanded: isDizzinessExpanded,
                      onToggle: () {
                        setState(() {
                          isDizzinessExpanded = !isDizzinessExpanded;
                        });
                      },
                      child: _buildSymptomDetails(
                        symptomLevel: 'Dizziness Details',
                        sliderValue: dizzinessSliderValue,
                        onSliderChanged: (value) {
                          setState(() {
                            dizzinessSliderValue = value;
                          });
                        },
                        selectedFrequency: dizzinessFrequency,
                        onFrequencySelected: (frequency) {
                          setState(() {
                            dizzinessFrequency = frequency;
                          });
                        },
                        selectedDuration: dizzinessDuration,
                        onDurationChanged: (value) {
                          setState(() {
                            dizzinessDuration = value!.replaceAll(' hour', '');
                          });
                        },
                      ),
                    ),

                    UIHelper.verticalSpace(12.h),

                    /// ===================== Vision Problems Section =====================
                    _buildSymptomSection(
                      title: 'Vision Problems',
                      isExpanded: isVisionExpanded,
                      onToggle: () {
                        setState(() {
                          isVisionExpanded = !isVisionExpanded;
                        });
                      },
                      child: _buildSymptomDetails(
                        symptomLevel: 'Vision Problems Level',
                        sliderValue: visionSliderValue,
                        onSliderChanged: (value) {
                          setState(() {
                            visionSliderValue = value;
                          });
                        },
                        selectedFrequency: visionFrequency,
                        onFrequencySelected: (frequency) {
                          setState(() {
                            visionFrequency = frequency;
                          });
                        },
                        selectedDuration: visionDuration,
                        onDurationChanged: (value) {
                          setState(() {
                            visionDuration = value!.replaceAll(' hour', '');
                          });
                        },
                      ),
                    ),

                    UIHelper.verticalSpace(12.h),

                    /// ===================== Balance Issues Section =====================
                    _buildSymptomSection(
                      title: 'Balance Issues',
                      isExpanded: isBalanceExpanded,
                      onToggle: () {
                        setState(() {
                          isBalanceExpanded = !isBalanceExpanded;
                        });
                      },
                      child: _buildSymptomDetails(
                        symptomLevel: 'Balance Issues Level',
                        sliderValue: balanceSliderValue,
                        onSliderChanged: (value) {
                          setState(() {
                            balanceSliderValue = value;
                          });
                        },
                        selectedFrequency: balanceFrequency,
                        onFrequencySelected: (frequency) {
                          setState(() {
                            balanceFrequency = frequency;
                          });
                        },
                        selectedDuration: balanceDuration,
                        onDurationChanged: (value) {
                          setState(() {
                            balanceDuration = value!.replaceAll(' hour', '');
                          });
                        },
                      ),
                    ),

                    UIHelper.verticalSpace(24.h),

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
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 12.h,
                              childAspectRatio: 3.5,
                              children: [
                                CustomEmotionalSymptoms(
                                  title: 'Irritability',
                                  isSelected: selectedEmotional == 'Irritability',
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
                                  isSelected: selectedEmotional == 'Mood Swings',
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
                        log('💪 Selected Physical Symptom: $selectedPhysicalSymptom');

                        log('\n📊 Headaches - Level: ${headachesSliderValue.toStringAsFixed(2)}, Frequency: ${headachesFrequency ?? "Not selected"}, Duration: $headachesDuration');
                        log('📊 Dizziness - Level: ${dizzinessSliderValue.toStringAsFixed(2)}, Frequency: ${dizzinessFrequency ?? "Not selected"}, Duration: $dizzinessDuration');
                        log('📊 Vision Problems - Level: ${visionSliderValue.toStringAsFixed(2)}, Frequency: ${visionFrequency ?? "Not selected"}, Duration: $visionDuration');
                        log('📊 Balance Issues - Level: ${balanceSliderValue.toStringAsFixed(2)}, Frequency: ${balanceFrequency ?? "Not selected"}, Duration: $balanceDuration');

                        log('\n😔 Emotional Symptom: $selectedEmotional');
                        log('==============================');

                        // Save to SharedPreferences or appData
                        appData.write(kKeyPhysicalSymptom, selectedPhysicalSymptom);



                        // Save Headaches data
                        appData.write('headaches_level', headachesSliderValue);
                        appData.write('headaches_frequency', headachesFrequency);
                        appData.write('headaches_duration', headachesDuration);

                        // Save Dizziness data
                        appData.write('dizziness_level', dizzinessSliderValue);
                        appData.write('dizziness_frequency', dizzinessFrequency);
                        appData.write('dizziness_duration', dizzinessDuration);

                        // Save Vision Problems data
                        appData.write('vision_level', visionSliderValue);
                        appData.write('vision_frequency', visionFrequency);
                        appData.write('vision_duration', visionDuration);

                        // Save Balance Issues data
                        appData.write('balance_level', balanceSliderValue);
                        appData.write('balance_frequency', balanceFrequency);
                        appData.write('balance_duration', balanceDuration);

                        appData.write(kKeyEmotionalSymptom, selectedEmotional);

                        // Navigate to next step
                        NavigationService.navigateTo(
                          Routes.recoveryStepThreeScreen,
                        );
                      },
                    ),

                    UIHelper.verticalSpace(20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build symptom section with expandable functionality
  Widget _buildSymptomSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.c181818,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Column(
        children: [
          /// Header with toggle
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       title,
              //       style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
              //         fontSize: 18.sp,
              //         fontWeight: FontWeight.w500,
              //         color: AppColors.cFFFFFF,
              //       ),
              //     ),
              //     Icon(
              //       isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              //       color: AppColors.cFFFFFF,
              //       size: 24.sp,
              //     ),
              //   ],
              // ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.cFFFFFF,
                    ),
                  ),
                  Switch(
                    value: isExpanded,
                    onChanged: (bool value) {
                      onToggle();
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
                      return Colors.white; // White knob
                    }),
                    trackColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColors.c00AA4D; // Green background (ON)
                      }
                      return Colors.grey.shade400; // Light grey (OFF)
                    }),
                    trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      return Colors.transparent; // No border
                    }),
                  ),

                ],
              ),


            ),
          ),

          /// Expanded content
          if (isExpanded)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: child,
            ),
        ],
      ),
    );
  }

  /// Helper method to build symptom details (slider, frequency, duration)
  Widget _buildSymptomDetails({
    required String symptomLevel,
    required double sliderValue,
    required Function(double) onSliderChanged,
    required String? selectedFrequency,
    required Function(String) onFrequencySelected,
    required String selectedDuration,
    required Function(String?) onDurationChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Symptom Level
        Text(
          symptomLevel,
          style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.cFFFFFF,
          ),
        ),
        UIHelper.verticalSpace(12.h),

        /// Slider with Mild/Severe labels
        Row(
          children: [
            Expanded(
              child: CustomSlider(
                initialValue: sliderValue,
                onChanged: onSliderChanged,
              ),
            ),
          ],
        ),

        UIHelper.verticalSpace(16.h),

        /// Frequency
        Text(
          'Frequency',
          style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.cFFFFFF,
          ),
        ),
        UIHelper.verticalSpace(12.h),

        Row(
          children: [
            Expanded(
              child: CustomFrequency(
                text: 'Rarely',
                isSelected: selectedFrequency == 'Rarely',
                onTap: () => onFrequencySelected('Rarely'),
              ),
            ),
            UIHelper.horizontalSpace(8.w),
            Expanded(
              child: CustomFrequency(
                text: 'Weekly',
                isSelected: selectedFrequency == 'Weekly',
                onTap: () => onFrequencySelected('Weekly'),
              ),
            ),
            UIHelper.horizontalSpace(8.w),
            Expanded(
              child: CustomFrequency(
                text: 'Daily',
                isSelected: selectedFrequency == 'Daily',
                onTap: () => onFrequencySelected('Daily'),
              ),
            ),
          ],
        ),

        UIHelper.verticalSpace(12.h),

        /// Duration
        Text(
          'Duration',
          style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.cFFFFFF,
          ),
        ),
        UIHelper.verticalSpace(12.h),

        CustomDropdownMenu(
          items: durationList,
          initialValue: '$selectedDuration hour',
          onChanged: onDurationChanged,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          iconPath: AppIcons.bottomdrodwonicon,
          iconHeight: 18,
        ),
      ],
    );
  }
}