import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AddMedicineAdditionalInfoScreen extends StatefulWidget {
  final bool isEdit;
  const AddMedicineAdditionalInfoScreen({super.key, this.isEdit = false});

  @override
  State<AddMedicineAdditionalInfoScreen> createState() => _AddMedicineAdditionalInfoScreenState();
}

class _AddMedicineAdditionalInfoScreenState extends State<AddMedicineAdditionalInfoScreen> {
  bool reminderNotification = true;
  String notifyBefore = '20 minutes';
  final TextEditingController doctorNotesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(20.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => NavigationService.goBack(),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpace(16.w),
                  Text(
                    widget.isEdit ? 'Edit Medicine' : 'Add Medicine',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              
              // Progress bar
              Row(
                children: [
                  Expanded(child: Container(height: 4.h, color: const Color(0xffA6FF00))),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(child: Container(height: 4.h, color: const Color(0xffA6FF00))),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(child: Container(height: 4.h, color: const Color(0xffA6FF00))),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(child: Container(height: 4.h, color: const Color(0xffA6FF00))),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              
              Text(
                'Additional Information',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              UIHelper.verticalSpace(4.h),
              Text(
                'Optional details and reminders',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
              ),
              UIHelper.verticalSpace(24.h),
              
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.c181818,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reminder Notification',
                          style: TextFontStyle.textStyle14w500c242424.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        UIHelper.verticalSpace(4.h),
                        Text(
                          'Get notified before taking time',
                          style: TextFontStyle.textStyle14w500c242424.copyWith(
                            color: Colors.white54,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: reminderNotification,
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xffA6FF00),
                      onChanged: (value) {
                        setState(() {
                          reminderNotification = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(20.h),
              
              if (reminderNotification) ...[
                Text(
                  'Notify Before',
                  style: TextFontStyle.textStyle14w500c242424.copyWith(
                    color: Colors.white,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: notifyBefore,
                      isExpanded: true,
                      dropdownColor: AppColors.c181818,
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 24.sp),
                      style: TextFontStyle.textStyle14w500c242424.copyWith(color: Colors.white),
                      items: ['5 minutes', '10 minutes', '15 minutes', '20 minutes', '30 minutes'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            notifyBefore = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
                UIHelper.verticalSpace(20.h),
              ],
              
              Text(
                'Doctor Notes (Optional)',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              CustomTextfield(
                controller: doctorNotesController,
                hintText: 'Any special instructions from your\ndoctor.',
                maxline: 4,
                fillColor: AppColors.c181818,
                borderColor: Colors.transparent,
                hintTextSyle: TextFontStyle.textStyle14w500c242424.copyWith(color: Colors.white54),
                style: const TextStyle(color: Colors.white),
              ),
              
              const Spacer(),
              CustomButtonWidget(
                text: 'Save Medicine',
                onTap: () {
                  NavigationService.navigateToWithArgs(
                    Routes.addMedicineSuccessScreen,
                    {'isEdit': widget.isEdit},
                  );
                },
              ),
              UIHelper.verticalSpace(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
