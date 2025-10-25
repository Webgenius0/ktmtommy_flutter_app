import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_reminder_time.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/custom_select_gender.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class TellUsAboutScreen extends StatefulWidget {
  const TellUsAboutScreen({super.key});

  @override
  State<TellUsAboutScreen> createState() => _TellUsAboutScreenState();
}

class _TellUsAboutScreenState extends State<TellUsAboutScreen> {
  final TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedGender = 'Male';
  String selectedTime = 'Morning';

  // 🕒 New variables for start & end times
  String startTime = '08:00:00';
  String endTime = '12:00:00';

  @override
  void dispose() {
    ageController.dispose();
    super.dispose();
  }

  // 🕒 Function to update start and end time based on selection
  void _updateTimeRange(String timePeriod) {
    switch (timePeriod) {
      case 'Morning':
        startTime = '08:00:00';
        endTime = '12:00:00';
        break;
      case 'Afternoon':
        startTime = '12:00:00';
        endTime = '17:00:00';
        break;
      case 'Evening':
        startTime = '18:00:00';
        endTime = '22:00:00';
        break;
      default:
        startTime = '08:00:00';
        endTime = '12:00:00';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.restbacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppbarWidget(
                    onTap: () {
                      NavigationService.goBack;
                    },
                    text: 'Tell us about you',
                  ),
                  UIHelper.verticalSpace(18.h),

                  /// ===================== Age Textfield =====================
                  CustomTextfield(
                    textAlign: TextAlign.start,
                    borderColor: AppColors.cD1D1D1,
                    controller: ageController,
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    prefixIcon: Transform.scale(
                      scale: 0.50,
                      child: SvgPicture.asset(AppIcons.ageicon),
                    ),
                    hintText: 'Enter your age',
                    style: TextStyle(color: AppColors.cFFFFFF),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your age';
                      }
                      final age = int.tryParse(value);
                      if (age == null) {
                        return 'Please enter a valid number';
                      }
                      if (age < 1 || age > 120) {
                        return 'Please enter a valid age (1-120)';
                      }
                      return null;
                    },
                  ),

                  UIHelper.verticalSpace(24.h),

                  /// ===================== Gender Selection =====================
                  Text(
                    'Select Gender',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomSelectGender(
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
                        child: CustomSelectGender(
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
                        child: CustomSelectGender(
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

                  /// ===================== Reminder Time Selection =====================
                  Text(
                    'Preferred reminder time',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomReminderTime(
                          title: 'Morning',
                          subtitle: '6-10 AM',
                          isSelected: selectedTime == 'Morning',
                          onTap: () {
                            setState(() {
                              selectedTime = 'Morning';
                              _updateTimeRange('Morning');
                            });
                          },
                        ),
                      ),
                      UIHelper.horizontalSpace(15.w),
                      Expanded(
                        child: CustomReminderTime(
                          title: 'Afternoon',
                          subtitle: '11 AM - 5 PM',
                          isSelected: selectedTime == 'Afternoon',
                          onTap: () {
                            setState(() {
                              selectedTime = 'Afternoon';
                              _updateTimeRange('Afternoon');
                            });
                          },
                        ),
                      ),
                      UIHelper.horizontalSpace(15.w),
                      Expanded(
                        child: CustomReminderTime(
                          title: 'Evening',
                          subtitle: '6 - 10 PM',
                          isSelected: selectedTime == 'Evening',
                          onTap: () {
                            setState(() {
                              selectedTime = 'Evening';
                              _updateTimeRange('Evening');
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  UIHelper.verticalSpace(260.h),

                  /// ===================== Next Button =====================
                  CustomButtonWidget(
                    text: 'Next',
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // 🟢 Print all selected values
                        log('===========================');
                        log('Age: ${ageController.text}');
                        log('Gender: $selectedGender');
                        log('Reminder Time: $selectedTime');
                        log('Start Time: $startTime');
                        log('End Time: $endTime');
                        log('===========================');

                        // 📝 Save to local storage
                        appData.write(kKeyuserAge, ageController.text);
                        appData.write(kKeyuserGender, selectedGender);
                        appData.write(kKeyuserReminderStartTime, startTime);
                        appData.write(kKeyuserReminderEndTime, endTime);

                        log('=====📅 TELL US ABOUT INFO:======');
                        log('+++++++++Age: ${appData.read(kKeyuserAge)}');
                        log('++++++++Gender: ${appData.read(kKeyuserGender)}');
                        log('+++++++++++Reminder Start Time: ${appData.read(kKeyuserReminderStartTime)}');
                        log('++++++++++++Reminder End Time: ${appData.read(kKeyuserReminderEndTime)}');

                        // Then navigate to next screen
                        NavigationService.navigateTo(
                          Routes.recoveryStepOneScreen,
                        );
                      }
                    },
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
