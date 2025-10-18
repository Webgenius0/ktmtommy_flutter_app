import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/custom_acetaminophen.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/date_time.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/medication_details.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/water_intake.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class LogTabletScreen extends StatefulWidget {
  const LogTabletScreen({super.key});

  @override
  State<LogTabletScreen> createState() => _LogTabletScreenState();
}

class _LogTabletScreenState extends State<LogTabletScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _medicationFormKey = GlobalKey<FormState>();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController medicationNameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();


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
                  text: 'Log Tablet',
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
                        MedicationDetails(
                          title: 'Medication Name',
                          nameController: medicationNameController,
                          dosageController: dosageController,
                          formKey: _medicationFormKey,
                        ),




                        UIHelper.verticalSpace(18.h),

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

                        DateTimeSelector(
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime selectedDateTime) {
                            print('Selected DateTime: $selectedDateTime');
                          },
                          restrictToCurrentMonth: true, // Optional
                        ),

                        UIHelper.verticalSpace(18.h),
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
                              // Upright Posture Section
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

                              WaterIntake(
                                onGlassCountChanged: (count) {
                                  setState(() => currentGlassCount = count);
                                },
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(18.h),
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

                        CustomButtonWidget(
                          onTap: _submitForm,
                          text: 'Log Now',
                        ),





                        UIHelper.verticalSpace(24.h),
                        Text(
                          'Recent Medication',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                              .copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),

                        CustomAcetaminophen(
                          title: title,
                          icon: icon,
                          mg: mg,
                          subtitle: subtitle,
                          deleteIcon: deleteIcon,
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






