import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AddMedicineDurationScreen extends StatefulWidget {
  final bool isEdit;
  const AddMedicineDurationScreen({super.key, this.isEdit = false});

  @override
  State<AddMedicineDurationScreen> createState() => _AddMedicineDurationScreenState();
}

class _AddMedicineDurationScreenState extends State<AddMedicineDurationScreen> {
  DateTime? startDate;
  DateTime? endDate;
  bool beforeMeal = false;

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (startDate ?? DateTime.now()) : (endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xffA6FF00),
              onPrimary: Colors.black,
              surface: Color(0xff181818),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xff181818),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

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
                  Expanded(child: Container(height: 4.h, color: Colors.white24)),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              
              Text(
                'Duration',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              UIHelper.verticalSpace(4.h),
              Text(
                'How long will you take this medicine?',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
              ),
              UIHelper.verticalSpace(24.h),
              
              Text(
                'Start Date',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              GestureDetector(
                onTap: () => _selectDate(context, true),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        startDate == null ? 'dd/mm/yyyy' : DateFormat('dd/MM/yyyy').format(startDate!),
                        style: TextFontStyle.textStyle14w500c242424.copyWith(
                          color: startDate == null ? Colors.white54 : Colors.white,
                        ),
                      ),
                      Icon(Icons.calendar_today_outlined, color: const Color(0xffA6FF00), size: 20.sp),
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(20.h),
              
              Text(
                'End Date (optional)',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        endDate == null ? 'dd/mm/yyyy' : DateFormat('dd/MM/yyyy').format(endDate!),
                        style: TextFontStyle.textStyle14w500c242424.copyWith(
                          color: endDate == null ? Colors.white54 : Colors.white,
                        ),
                      ),
                      Icon(Icons.calendar_today_outlined, color: const Color(0xffA6FF00), size: 20.sp),
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(20.h),
              
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
                          'Before Meal',
                          style: TextFontStyle.textStyle14w500c242424.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        UIHelper.verticalSpace(4.h),
                        Text(
                          'Take this medicine before eating',
                          style: TextFontStyle.textStyle14w500c242424.copyWith(
                            color: Colors.white54,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: beforeMeal,
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xffA6FF00),
                      onChanged: (value) {
                        setState(() {
                          beforeMeal = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              CustomButtonWidget(
                text: 'Next',
                onTap: () {
                  NavigationService.navigateToWithArgs(
                    Routes.addMedicineAdditionalInfoScreen,
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
