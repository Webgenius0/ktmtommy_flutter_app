import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/custom_duration.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/custom_notification.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/log_activity_calander.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/time_custom.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class LogActivityScreen extends StatefulWidget {
  const LogActivityScreen({super.key});

  @override
  State<LogActivityScreen> createState() => _LogActivityScreenState();}
class _LogActivityScreenState extends State<LogActivityScreen> {


  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  late TextEditingController dateController;
  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomAppbarWidget(
                  onTap: (){NavigationService.goBack;},
                  text: 'Log Activity',
                ),

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
                              Text(
                                  'Activity Type',
                                  style:  TextFontStyle.textStyle14w400cA3A3A3poppins
                              ),
                              UIHelper.verticalSpace(4.h),

                              CustomTextfield(
                                idoNotErrorBorder: true,
                                controller: nameController,
                                textAlign: TextAlign.start,
                                hintText: 'Enter activity name',
                                hintTextSyle: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                fillColor: AppColors.c2A2A2A,
                                borderRadius: 20.r,
                                borderColor: Colors.transparent,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                                style: TextStyle(color: Colors.white),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter activity type';
                                  }
                                  return null;
                                },),


                              UIHelper.verticalSpace(18.h),
                              Text(
                                  'Date',
                                  style:  TextFontStyle.textStyle14w400cA3A3A3poppins
                              ),
                              UIHelper.verticalSpace(4.h),

                              LogActivityCalander(
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
                        UIHelper.verticalSpace(18.h),
                        CustomButtonWidget(
                            onTap: (){
                              if (_formKey.currentState?.validate() ?? false) {
                                NavigationService.navigateTo(Routes.recentScreen);
                              }
                            },
                            text: 'Add Activity')

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



