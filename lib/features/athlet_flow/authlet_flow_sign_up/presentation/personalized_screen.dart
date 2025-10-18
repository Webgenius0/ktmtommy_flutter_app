
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_height.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_time.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_with.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/select_unselect_gender.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/stepbar_select_goal.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class PersonalizedScreen extends StatefulWidget {
  const PersonalizedScreen({super.key});

  @override
  State<PersonalizedScreen> createState() => _PersonalizedScreenState();
}

class _PersonalizedScreenState extends State<PersonalizedScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  bool isSelectedHeight = false;
  bool isSelectedWeight = false;

  String selectedGender = 'Male';
  String? selectedTime;
  String? timeError;

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      timeError = null;
    });

    if (_formKey.currentState!.validate()) {
      if (selectedTime == null) {
        setState(() {
          timeError = "⚠️ Please select a reminder time";
        });
        return;
      }


      NavigationService.navigateTo(Routes.allSetPersonalInformationScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ArrowButtonAtheleteFlow(
                    onTap: () {
                      NavigationService.goBack;
                    },
                  ),
                  UIHelper.verticalSpace(12.h),

                  Text(
                    'Tell us about you',
                    style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                      fontSize: 32.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(18.h),

                  StepBarSelectGoal(
                    currentStep: 3,
                    onTap: () {
                      NavigationService.navigateTo(
                          Routes.recoveryStepTwoScreen);
                    },
                    onStepTap: (int index) {},
                  ),
                  UIHelper.verticalSpace(18.h),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gender Select
                          Text(
                            'Select Gender',
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                .copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),
                          Row(
                            children: [
                              Expanded(
                                child: SelectUnselectGender(
                                  text: 'Male',
                                  isSelected: selectedGender == 'Male',
                                  onTap: () {
                                    setState(() {
                                      selectedGender = 'Male';
                                    });
                                  },
                                ),
                              ),
                              UIHelper.horizontalSpace(15.w),
                              Expanded(
                                child: SelectUnselectGender(
                                  text: 'Female',
                                  isSelected: selectedGender == 'Female',
                                  onTap: () {
                                    setState(() {
                                      selectedGender = 'Female';
                                    });
                                  },
                                ),
                              ),
                              UIHelper.horizontalSpace(15.w),
                              Expanded(
                                child: SelectUnselectGender(
                                  text: 'Other',
                                  isSelected: selectedGender == 'Other',
                                  onTap: () {
                                    setState(() {
                                      selectedGender = 'Other';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(24.h),

  //==================================== Height ===================================//

                          CustomHeight(
                            controller: heightController,
                            isFtIn: isSelectedHeight,
                            onUnitChange: (val) {
                              setState(() {
                                isSelectedHeight = val;
                              });
                            },
                          ),

                          UIHelper.verticalSpace(24.h),


   //============================= With ============================================//


                          CustomWith(
                            controller: weightController,
                            isLbs: isSelectedWeight,
                            onUnitChange: (val) {
                              setState(() {
                                isSelectedWeight = val;
                              });
                            },
                          ),

                          UIHelper.verticalSpace(24.h),

   //========================================= Remender =================================//
                          Text(
                            'Preferred reminder time',
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                .copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),

                          Row(
                            children: [
                              Expanded(
                                child: CustomTime(
                                  title: 'Morning',
                                  subtitle: '6-10 AM',
                                  isSelected: selectedTime == 'Morning',
                                  onTap: () {
                                    setState(() {
                                      selectedTime = 'Morning';
                                    });
                                  },
                                ),
                              ),
                              UIHelper.horizontalSpace(15.w),
                              Expanded(
                                child: CustomTime(
                                  title: 'Afternoon',
                                  subtitle: '11 AM - 5 PM',
                                  isSelected: selectedTime == 'Afternoon',
                                  onTap: () {
                                    setState(() {
                                      selectedTime = 'Afternoon';
                                    });
                                  },
                                ),
                              ),
                              UIHelper.horizontalSpace(15.w),
                              Expanded(
                                child: CustomTime(
                                  title: 'Evening',
                                  subtitle: '6 - 10 PM',
                                  isSelected: selectedTime == 'Evening',
                                  onTap: () {
                                    setState(() {
                                      selectedTime = 'Evening';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),


                          if (timeError != null) ...[
                            UIHelper.verticalSpace(8.h),
                            Text(
                              timeError!,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 14.sp),
                            ),
                          ],

                          UIHelper.verticalSpace(38.h),

    //============================= Submet button =================================//
                          CustomButtonWidget(
                            onTap: _submit,
                            textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                            image: DecorationImage(
                              image: AssetImage(AppImages.orangebutton),
                            ),
                            text: 'Next',
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
      ),
    );
  }
}