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
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/custom_duration.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/custom_notification.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/time_custom.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/custom_activity_calander.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class AthletLogActivityScreen extends StatefulWidget {
  const AthletLogActivityScreen({super.key});

  @override
  State<AthletLogActivityScreen> createState() => _AthletLogActivityScreenState();}
class _AthletLogActivityScreenState extends State<AthletLogActivityScreen> {


  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    dateController.dispose();
    nameController.dispose();
    super.dispose();
  }
//===================================== Menu Button =========================================//

  List<String> workoutTypes = ['Running', 'Cycling', 'Swimming', 'Weight Training', 'Yoga'];
  String? selectedWorkout;



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.restbacroundimage),fit: BoxFit.cover)
        ),child:  SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [


                //========================= Arrw Button ==================================//

                ArrowButtonAtheleteFlow(
                  text: 'Log activity',
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
                UIHelper.verticalSpace(24.h),

                //===============================

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              //========================================== Activity ============================//

                              Text(
                                  'Activity Name',
                                  style:  TextFontStyle.textStyle14w400cA3A3A3poppins
                              ),
                              UIHelper.verticalSpace(4.h),


//========================================= TextFormfield Activity Name ================================//

                              CustomTextfield(
                                controller: nameController,
                                textAlign: TextAlign.start,
                                isRead: true,
                                style: TextStyle(color: Colors.white),
                                  hintText: 'Select Workout type',
                                  hintTextSyle: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                                    fontSize: 14.sp,fontWeight: FontWeight.w400
                                  ),
                                  fillColor: AppColors.c2A2A2A,
                                  borderRadius: 20.r,
                                  contentPadding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                  suffixIcon: PopupMenuButton<String>(
                                    icon: SvgPicture.asset(AppIcons.bottomdrodwonicon,height: 18.h,),
                                    color:  AppColors.c2A2A2A,
                                    onSelected: (String value) {
                                      setState(() {
                                        selectedWorkout = value;
                                        nameController.text = value;
                                      });
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return workoutTypes.map((String value) {
                                        return PopupMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style:  TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                  ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter activity type';
                                  }
                                  return null;
                                },
                                ontap: () {
                                  final state = _formKey.currentState;
                                  if (state != null) {
                                    state.save();
                                  }
                                },

                              ),





                              UIHelper.verticalSpace(18.h),

                              //========================== text =============================//


                              Text(
                                  'Date',
                                  style:  TextFontStyle.textStyle14w400cA3A3A3poppins
                              ),
                              UIHelper.verticalSpace(4.h),

                              //================================= Calander =========================//


                              CustomActivityCalander(
                                controller: dateController,
                                hintText: 'Select Date',
                              ),
                              UIHelper.verticalSpace(18.h),




                              Text(
                                  'Time',
                                  style:  TextFontStyle.textStyle14w400cA3A3A3poppins
                              ),
                              UIHelper.verticalSpace(4.h),

                              TimeCustom(),
                              UIHelper.verticalSpace(18.h),
                              Text(
                                  'Duration',
                                  style:  TextFontStyle.textStyle14w400cA3A3A3poppins
                              ),
                              UIHelper.verticalSpace(4.h),
                              CustomDuration(),
                              UIHelper.verticalSpace(18.h),
                              Text(
                                  'Notification',
                                  style:  TextFontStyle.textStyle14w400cA3A3A3poppins
                              ),
                              UIHelper.verticalSpace(4.h),

                              CustomNotification(),
                              UIHelper.verticalSpace(18.h),
                              Text(
                                  'Notes',
                                  style:  TextFontStyle.textStyle14w400cA3A3A3poppins
                              ),
                              UIHelper.verticalSpace(4.h),

                              CustomTextfield(
                                textAlign: TextAlign.start,
                                maxline: 4,
                                borderRadius: 20.r,
                                fillColor: AppColors.c2A2A2A,
                                hintText: 'Add notes here',
                                hintTextSyle: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                style: TextStyle(color: AppColors.cFFFFFF),
                              ),
                              UIHelper.verticalSpace(18.h),

                            ],
                          ),
                        ),


                        //================================ Button ==============================//
                        UIHelper.verticalSpace(55),


                        CustomButtonWidget(
                            textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                            image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                            onTap: (){
                              if (_formKey.currentState?.validate() ?? false) {
                                  NavigationService.navigateTo(Routes.athletActivityScreen);
                              }

                            },
                            text: 'Add Workout')

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



