import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/date_time.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/medication_details.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/water_intake.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

import '../../../../networks/api_acess.dart';

class EditMedicationScreen extends StatefulWidget {
  final id;
  final name;
  final dosage;
  const EditMedicationScreen(
      {super.key, this.id, required this.name, this.dosage});

  @override
  State<EditMedicationScreen> createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _medicationFormKey = GlobalKey<FormState>();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController medicationNameController =
      TextEditingController();
  final TextEditingController dosageController = TextEditingController();

  // Selected date and time for medication
  DateTime? _selectedDateTime;

  // Loading state for form submission
  bool isLoading = false;

  void _submitForm() {
    // Validate both forms
    if (_medicationFormKey.currentState!.validate() &&
        _formKey.currentState!.validate()) {
      NavigationService.navigateTo(Routes.recentMedicationScreen);
    }
  }

  @override
  void dispose() {
    notesController.dispose();
    medicationNameController.dispose();
    dosageController.dispose();
    super.dispose();
  }

  bool isOn = false;
  bool isOf = false;
  int currentGlassCount = 0;
  bool isAMSelected = true;
  bool isMealEnabled = false;

  final List<String> icon = [
    'assets/icons/signureicon.svg',
    'assets/icons/signureicon.svg',
  ];

  final List<String> title = ['Acetaminophen', 'Acetaminophen'];
  final List<String> subtitle = ['Yesterday, 8:00 PM', 'Yesterday, 8:00 PM'];

  final List<String> mg = ['500mg', '500mg'];

  final List<String> deleteIcon = [
    'assets/icons/deleteicon.svg',
    'assets/icons/deleteicon.svg',
  ];

  @override
  Widget build(BuildContext context) {
    log("===============Print Received ID: ${widget.id}");
    log("===============Print Received Name: ${widget.name}");
    log("===============Print Received Name: ${widget.dosage}");
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbarWidget(
                  onTap: () {
                    NavigationService.goBack;
                  },
                  text: 'Edit Log Tablet',
                ),
                UIHelper.verticalSpace(20.h),
                Text(
                  'Medication Details',
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Medication name and dosage input
                        MedicationDetails(
                          hintText: widget.name,
                          title: 'Medication Name',
                          dosage: widget.dosage.toString(),
                          nameController: medicationNameController,
                          dosageController: dosageController,
                          formKey: _medicationFormKey,
                        ),
                        UIHelper.verticalSpace(18.h),
                        // Time Taken Section
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.timetoken, height: 18.h),
                            UIHelper.horizontalSpace(8.w),
                            Text(
                              'Time Taken',
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                  .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(12.h),
                        // Date and time selector
                        DateTimeSelector(
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime selectedDateTime) {
                            setState(() {
                              _selectedDateTime = selectedDateTime;
                            });
                            // Log selected date and time
                            print('Selected DateTime: $selectedDateTime');
                          },
                          restrictToCurrentMonth: true,
                        ),
                        UIHelper.verticalSpace(18.h),
                        // Wellness Tracking Section
                        Text(
                          'Wellness Tracking',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                              .copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 13.h,
                          ),
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Column(
                            children: [
                              // Upright Posture Switch
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Upright Posture',
                                    style: TextFontStyle
                                        .textStyle24w600cFFFFFFpoppins
                                        .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 0.90,
                                    child: Switch(
                                      activeColor: AppColors.cFFFFFF,
                                      activeTrackColor: AppColors.cCC1F28,
                                      inactiveTrackColor: AppColors.cE9E9EA,
                                      inactiveThumbColor: AppColors.c87B842,
                                      value: isOf,
                                      onChanged: (bool value) {
                                        setState(() => isOf = value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpace(16.h),
                              // Water Intake Tracker
                              WaterIntake(
                                onToggleChanged: (toggleValue) {
                                  setState(() {
                                    isMealEnabled = toggleValue;
                                  });
                                  print("Water intake toggle: $toggleValue");
                                },
                                onGlassCountChanged: (count) {
                                  setState(() => currentGlassCount = count);
                                },
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(18.h),
                        // Notes Section
                        Text(
                          'Notes',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                              .copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(18),
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Column(
                            children: [
                              CustomTextfield(
                                textAlign: TextAlign.start,
                                controller: notesController,
                                borderRadius: 4,
                                borderColor: Colors.transparent,
                                maxline: 3,
                                fillColor: AppColors.c2A2A2A,
                                hintText:
                                    'Add notes about symptom or Side effect',
                                hintTextSyle: TextFontStyle
                                    .textStyle16w400c757575poppins
                                    .copyWith(fontSize: 12.sp),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(24.h),
                        // Log Now Button
                        CustomButtonWidget(
                          textStyle: TextFontStyle.textStylePoppins,
                          onTap: () async {
                            // Validate forms before submission
                            if (_medicationFormKey.currentState!.validate() &&
                                _formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                // Collect form data
                                final name = medicationNameController.text;
                                final dosage =
                                    double.tryParse(dosageController.text) ??
                                        0.0;
                                const dosageUnit = "mg";
                                const isPrescribed = true;
                                final takenAt = _selectedDateTime != null
                                    ? DateFormat('yyyy-MM-dd HH:mm:ss')
                                        .format(_selectedDateTime!)
                                    : DateFormat('yyyy-MM-dd HH:mm:ss')
                                        .format(DateTime.now());
                                final uprightPosture = isOf;
                                final waterIntake = currentGlassCount > 0;
                                final glassOfWater = currentGlassCount;
                                final notes = notesController.text;

                                // Log collected data for debugging
                                print('>>>>>>===========<<<<<');
                                print('===========>>>Medication Name: $name');
                                print(
                                    '===========>>>Dosage: $dosage $dosageUnit');
                                print(
                                    '===========>>>Is Prescribed: $isPrescribed');
                                print('===========>>>Taken At: $takenAt');
                                print(
                                    '===========>>>Upright Posture: $uprightPosture');
                                print(
                                    '===========>>>Water Intake: $waterIntake');
                                print(
                                    '===========>>>Glass of Water: $glassOfWater');
                                print('===========>>>Notes: $notes');
                                print('>>>>>>===========<<<<<');

                                // Call API to save medication
                                bool success = await editMedicationRxObj
                                    .putEditMedicationPutApi(
                                  id: widget.id.toString(),
                                  name: name,
                                  dosage: dosage,
                                  dosageUnit: dosageUnit,
                                  isPrescribed: isPrescribed,
                                  takenAt: takenAt,
                                  uprightPosture: uprightPosture,
                                  waterIntake: waterIntake,
                                  glassOfWater: glassOfWater,
                                  notes: notes,
                                );

                                if (success) {
                                  // Log success and navigate to recent medication screen
                                  print(
                                      '==========>>>>>>Success medication saved');
                                  NavigationService.navigateTo(
                                      Routes.recentMedicationScreen);
                                }
                              } catch (e) {
                                // Log error and show toast
                                print('Error saving medication: $e');
                                ToastUtil.showShortToast(
                                    "Failed to save medication. Please try again.");
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          text: 'Save',
                          child: isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 3,
                                )
                              : Text(
                                  'Save',
                                  style:
                                      TextFontStyle.textStylePoppins.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
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
