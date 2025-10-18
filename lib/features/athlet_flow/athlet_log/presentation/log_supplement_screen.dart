import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/water_intake.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/custom_date_times.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/custom_medication_details.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/widget_animation.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';







class LogSupplementScreen extends StatefulWidget {
  const LogSupplementScreen({super.key});

  @override
  State<LogSupplementScreen> createState() => _LogSupplementScreenState();
}

class _LogSupplementScreenState extends State<LogSupplementScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _medicationFormKey = GlobalKey<FormState>();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController medicationNameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  TextEditingController powderController = TextEditingController();

  void _submitForm() {
    if (_medicationFormKey.currentState!.validate() &&
        _formKey.currentState!.validate()) {
      NavigationService.navigateTo(Routes.recentSupplementLogScreen);
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

  final List<String> title = ['Proteim Powder', 'Omega-3'];
  final List<String> subtitle = ['Yesterday, 8:00 PM', 'Yesterday, 8:00 PM'];

  final List<String> mg = ['50gm', '10mg'];

  final List<String> deleteIcon = [
    'assets/icons/deleteicon.svg',
    'assets/icons/deleteicon.svg',
  ];






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.restbacroundimage),fit: BoxFit.cover)
        ),
        child:   SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,


                children: [
                  ArrowButtonAtheleteFlow(
                    text: 'Log Supplement',
                    subtitle: 'Track your daily performance\nsupplements',
                    onTap: () {
                      NavigationService.goBack;
                    },
                  ),

                  UIHelper.verticalSpace(14.h),


                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

    //===================================== CustomMedicationDetails ======================================//
                          Text(
                            'Supplement Details',
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          UIHelper.verticalSpace(12.h),

              //================================= Supplement ========================//


                          CustomMedicationDetails(
                            title: 'Supplement Type',
                            nameController: medicationNameController,
                            dosageController: dosageController,
                            powderController: powderController,
                            formKey: _medicationFormKey,
                          ),



                          //=============================== Time =============================//
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


                          //============================ Clock and Calander ==============================//
                          UIHelper.verticalSpace(12.h),
                          CustomDateTimes(
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime selectedDateTime) {
                              print('Selected DateTime: $selectedDateTime');
                            },
                            restrictToCurrentMonth: true, // Optional
                          ),

                          UIHelper.verticalSpace(18.h),

                          //================================= Wellness ==================================//


                          Text(
                            'Wellness Tracking',
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                .copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),

//==================================== Water =================================//


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


                                //======================= Text  ====================================//
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                                    //================================== Toggle =================================//

                                    Transform.scale(
                                      scale: 0.90,
                                      child: Switch(
                                        activeColor: AppColors.cFFFFFF,
                                        activeTrackColor: AppColors.orangeColor,
                                        inactiveTrackColor: AppColors.cE9E9EA,
                                        inactiveThumbColor: AppColors.orangeColor,
                                        value: isOf,
                                        onChanged: (bool value) {
                                          setState(() => isOf = value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                UIHelper.verticalSpace(16.h),

                                //=========================== waterIntake ===============================//

                                WaterIntake(
                                  onGlassCountChanged: (count) {
                                    setState(() => currentGlassCount = count);
                                  },
                                ),

                                //============================ Done ==============================//

                              ],
                            ),
                          ),

                          //============================= Notes =====================================//
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
//======================================= symptom ============================//


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
                            textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                            image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                            onTap: _submitForm,
                            text: 'Save Log',
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

                          WidgetAnimation(
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
      )
    );
  }
}
