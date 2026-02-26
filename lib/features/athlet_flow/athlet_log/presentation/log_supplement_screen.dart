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
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/model/log_suppliment_data_model.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/water_intake.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/custom_date_times.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/custom_medication_details.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/widget_animation.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

import '../../../../networks/api_acess.dart';







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
  final TextEditingController amountUnitController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  TextEditingController powderController = TextEditingController();
  bool isWaterIntakeEnabled = false;
  bool isMealEnabled = false;
  DateTime? _selectedDateTime;
  bool isDeleting = false;
  bool isUploading= false;

  @override
  void initState() {
    getLogSupplementRx.getLogSupplementInfo();
    super.initState();
  }
  Future<void> _submitForm() async {
    if (_medicationFormKey.currentState!.validate() &&
        _formKey.currentState!.validate()) {

      final dateTimeToUse = _selectedDateTime ?? DateTime.now();


      setState(() {
        isUploading = true;
      });
      // 2025-12-17 18:45:00 এই ফরম্যাটে রূপান্তর
      final formattedDateTime =
          '${dateTimeToUse.year}-'
          '${dateTimeToUse.month.toString().padLeft(2, '0')}-'
          '${dateTimeToUse.day.toString().padLeft(2, '0')} '
          '${dateTimeToUse.hour.toString().padLeft(2, '0')}:'
          '${dateTimeToUse.minute.toString().padLeft(2, '0')}:'
          '00'; // সেকেন্ড সবসময় 00 রাখতে চাইলে

      print('=== SUPPLEMENT LOG VALUES ===');

      // Supplement Details
      print('Supplement Type - Name: ${medicationNameController.text}');
      print('Supplement Type - Dosage: ${dosageController.text}');
      print('Supplement Type - Powder: ${powderController.text}');
      print('Supplement amount unit : ${amountUnitController.text}');

      // Time - 2025-12-17 18:45:00 ফরম্যাটে
      print('Time Taken: $formattedDateTime');

      // Wellness Tracking
      print('Water Intake: $isWaterIntakeEnabled');
      print('Water Intake Glass Count: $currentGlassCount');
      print('Taken with meal: $isMealEnabled');

      // Notes
      print('Notes: ${notesController.text}');

      print('============================');

      // API কল - 2025-12-17 18:45:00 ফরম্যাটে
      bool success = await storeSupplementRx.storeSupplementInfo(
          withMeal: isMealEnabled,
          waterIntake: isWaterIntakeEnabled,
          type: powderController.text,
          takenAt: formattedDateTime, // এখানে 2025-12-17 18:45:00 ফরম্যাট
          note: notesController.text,
          name: medicationNameController.text,
          glassOfWater: currentGlassCount,
          amountUnit: amountUnitController.text,
          amount: dosageController.text
      );

      setState(() {
        isUploading = false;
      });

      if (success) {
        getLogSupplementRx.getLogSupplementInfo();
        ToastUtil.showLongToast("Log Supplement success");
        // NavigationService.navigateTo(Routes.recentSupplementLogScreen);
      } else {
        ToastUtil.showLongToast("Failed to save supplement log");
      }
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
  int currentGlassCount = 0;
  bool isAMSelected = true;
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

                            amountUnitController: amountUnitController,
                            onToggleChanged: (toggleValue) {
                              setState(() {
                                isMealEnabled = toggleValue;
                              });
                              print("with meel value : $toggleValue");
                            },
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
                              // এখানে selectedDateTime store করুন
                              setState(() {
                                _selectedDateTime = selectedDateTime;
                              });
                              print('Selected DateTime: $selectedDateTime');
                            },
                            restrictToCurrentMonth: true,
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
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       'Upright Posture',
                                //       style: TextFontStyle
                                //           .textStyle24w600cFFFFFFpoppins
                                //           .copyWith(
                                //         fontSize: 16.sp,
                                //         fontWeight: FontWeight.w400,
                                //       ),
                                //     ),
                                //
                                //     //================================== Toggle =================================//
                                //
                                //     Transform.scale(
                                //       scale: 0.90,
                                //       child: Switch(
                                //         activeColor: AppColors.cFFFFFF,
                                //         activeTrackColor: AppColors.orangeColor,
                                //         inactiveTrackColor: AppColors.cE9E9EA,
                                //         inactiveThumbColor: AppColors.orangeColor,
                                //         value: isOf,
                                //         onChanged: (bool value) {
                                //           setState(() => isOf = value);
                                //         },
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // UIHelper.verticalSpace(16.h),

                                //=========================== waterIntake ===============================//


                              WaterIntake(
                              initialToggleState: true, // Start with toggle ON
                              initialGlassCount: 3, // Start with 3 glasses
                              onToggleChanged: (toggleValue) {
                                setState(() {
                                  isWaterIntakeEnabled = toggleValue;
                                });
                                print("Water intake toggle: $toggleValue");
                              },
                              onGlassCountChanged: (count) {
                                setState(() => currentGlassCount = count);
                                print("Glass count: $count");
                              },
                            )




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
                          isUploading? Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepOrange,
                            ),
                          ) : CustomButtonWidget(
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




                    StreamBuilder<LogSupplementModelData>(
                      stream: getLogSupplementRx.dataFetcher,
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

                        final logSupplementData = snapshot.data!;

                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: logSupplementData.data?.length,
                          itemBuilder: (context, index) {
                            final data = logSupplementData.data?[index];
                            return   WidgetAnimation(
                              title:data?.name.toString()??"" ,

                              onDeletePress: () async {
                                // Confirmation dialog show করুন
                                bool? confirm = await showDialog(

                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.deepOrange,
                                    title: Text("Delete Confirmation",style: TextStyle(color: Colors.white),),
                                    content: Text("Are you sure you want to delete this supplement log?",style: TextStyle(color: Colors.white),),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: Text("Cancel",style: TextStyle(color: Colors.white),),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        child: Text("Delete", style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                );

                                // যদি user confirm না করে
                                if (confirm != true) return;

                                // Deleting process শুরু করুন
                                if (isDeleting) return;

                                setState(() => isDeleting = true);

                                try {
                                  bool success = await deleteLogSupplementRx.deleteSleepApiInfo(id: data?.id);

                                  if (success) {
                                    await getLogSupplementRx.getLogSupplementInfo();
                                    ToastUtil.showLongToast("Deleted successfully");
                                  } else {
                                    ToastUtil.showLongToast("Failed to delete");
                                  }
                                } catch (e) {
                                  print("Delete error: $e");
                                  ToastUtil.showLongToast("Error occurred while deleting");
                                } finally {
                                  if (mounted) {
                                    setState(() => isDeleting = false);
                                  }
                                }
                              },
                              mg: data?.amountUnit??"",
                              subtitle: data?.takenAtHuman??"",

                            );
                          },);
                      },
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
