import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class MedicineDetailsScreen extends StatelessWidget {
  final String name;
  final String dosage;
  final String type;

  const MedicineDetailsScreen({
    super.key,
    this.name = 'Napa Extra',
    this.dosage = '500mg',
    this.type = 'Tablet',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => NavigationService.goBack(),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xffA6FF00), width: 1.5),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: const Color(0xffA6FF00),
                              size: 20.sp,
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpace(16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '$dosage • $type',
                              style: TextFontStyle.textStyle14w500c242424.copyWith(
                                color: Colors.white54,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white54,
                        size: 24.sp,
                      ),
                      color: const Color(0xff222222),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text(
                            'Edit',
                            style: TextFontStyle.textStyle14w500c242424.copyWith(color: Colors.white),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text(
                            'Delete',
                            style: TextFontStyle.textStyle14w500c242424.copyWith(color: Colors.redAccent),
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'edit') {
                          NavigationService.navigateToWithArgs(
                            Routes.addMedicineBasicInfoScreen,
                            {
                              'name': name,
                              'dosage': dosage.replaceAll(RegExp(r'[^0-9.]'), ''),
                              'type': type,
                              'isEdit': true,
                            },
                          );
                        } else if (value == 'delete') {
                          _showDeleteDialog(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(16.h),
              Divider(color: Colors.white12, thickness: 1.h),
              UIHelper.verticalSpace(16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    _buildDailyScheduleCard(),
                    UIHelper.verticalSpace(16.h),
                    _buildDurationCard(),
                    UIHelper.verticalSpace(16.h),
                    _buildReminderSettingsCard(),
                    UIHelper.verticalSpace(16.h),
                    _buildDoctorNotesCard(),
                    UIHelper.verticalSpace(30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyScheduleCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.c181818,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, color: const Color(0xffA6FF00), size: 20.sp),
              UIHelper.horizontalSpace(8.w),
              Text(
                'Daily Schedule',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(16.h),
          _timeChip('08:00 AM'),
          UIHelper.verticalSpace(10.h),
          _timeChip('10:00 PM'),
        ],
      ),
    );
  }

  Widget _timeChip(String time) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xff222222),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        time,
        style: TextFontStyle.textStyle14w500c242424.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDurationCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.c181818,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month_outlined, color: const Color(0xffA6FF00), size: 20.sp),
              UIHelper.horizontalSpace(8.w),
              Text(
                'Duration',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(16.h),
          _infoRow('Start Date', 'May 1, 2026'),
          UIHelper.verticalSpace(12.h),
          _infoRow('End Date', 'May 31, 2026'),
          UIHelper.verticalSpace(12.h),
          Divider(color: Colors.white12, thickness: 1.h),
          UIHelper.verticalSpace(12.h),
          _infoRow('Before Meal', 'No'),
        ],
      ),
    );
  }

  Widget _buildReminderSettingsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.c181818,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications_none_outlined, color: const Color(0xffA6FF00), size: 20.sp),
              UIHelper.horizontalSpace(8.w),
              Text(
                'Reminder Settings',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(16.h),
          _infoRow('Notifications', 'Enabled'),
          UIHelper.verticalSpace(12.h),
          _infoRow('Notify Before', '20 minutes'),
        ],
      ),
    );
  }

  Widget _buildDoctorNotesCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.c181818,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medical_information_outlined, color: const Color(0xffA6FF00), size: 20.sp),
              UIHelper.horizontalSpace(8.w),
              Text(
                'Doctor Notes',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Please take this medicine when your stomach is full. Do not take it in empty stomach.',
            style: TextFontStyle.textStyle14w500c242424.copyWith(
              color: Colors.white70,
              height: 1.5,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle14w500c242424.copyWith(
            color: Colors.white54,
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: TextFontStyle.textStyle14w500c242424.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xff181818),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 24.w), // spacing for center alignment
                    Expanded(
                      child: Text(
                        'Delete Prescribed\nMedicine',
                        textAlign: TextAlign.center,
                        style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white54, width: 1),
                        ),
                        child: Icon(Icons.close, color: Colors.white54, size: 14.sp),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(16.h),
                Text(
                  'Are you sure want to Delete this\nprescribed medicine?',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle14w500c242424.copyWith(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(color: Colors.white24, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextFontStyle.textStyle14w500c242424.copyWith(
                                color: Colors.white54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    UIHelper.horizontalSpace(12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // close dialog
                          NavigationService.goBack(); // go back from details screen
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: const Color(0xffD32F2F),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Center(
                            child: Text(
                              'Delete',
                              style: TextFontStyle.textStyle14w500c242424.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
