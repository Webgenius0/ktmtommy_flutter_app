import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_prescribed_medicine/model/prescribed_medicine_details_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final int id;

  const MedicineDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  @override
  void initState() {
    super.initState();
    getPrescribedMedicineDetailsRxObj.fetchPrescribedMedicineDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: StreamBuilder<PrescribedMedicineDetailsModel>(
          stream: getPrescribedMedicineDetailsRxObj.getPrescribedMedicineDetailsData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xffA6FF00)),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.grey, size: 60),
                    UIHelper.verticalSpace(16.h),
                    Text(
                      'Connection failed',
                      style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                    ),
                    TextButton(
                      onPressed: () => getPrescribedMedicineDetailsRxObj.fetchPrescribedMedicineDetails(widget.id),
                      child: const Text('Try Again', style: TextStyle(color: Color(0xffA6FF00))),
                    ),
                  ],
                ),
              );
            }

            final data = snapshot.data?.data;
            if (data == null) {
              return Center(
                child: Text(
                  'No medicine details found',
                  style: TextStyle(color: Colors.white54, fontSize: 14.sp),
                ),
              );
            }

            final String medicineName = data.medicineName ?? 'Unknown';
            final String dosageStr = '${data.dosage ?? ''}${data.dosageType ?? ''}';
            final String typeStr = data.medicineType ?? '';

            return SingleChildScrollView(
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
                              onTap: () => NavigationService.goBack,
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
                                  medicineName,
                                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '$dosageStr • $typeStr',
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
                                  'id': widget.id,
                                  'name': medicineName,
                                  'dosage': data.dosage ?? '',
                                  'dosage_type': data.dosageType ?? 'mg',
                                  'type': typeStr,
                                  'taking_times': data.takingTimes,
                                  'start_date': data.startDate,
                                  'end_date': data.endDate,
                                  'before_meal': data.beforeMeal,
                                  'notification': data.notification,
                                  'notify_before': data.notifyBefore,
                                  'doctor_note': data.doctorNote,
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
                        _buildDailyScheduleCard(data.takingTimes ?? []),
                        UIHelper.verticalSpace(16.h),
                        _buildDurationCard(
                          startDate: data.startDate ?? '',
                          endDate: data.endDate ?? 'N/A',
                          beforeMeal: data.beforeMeal == true,
                        ),
                        UIHelper.verticalSpace(16.h),
                        _buildReminderSettingsCard(
                          enabled: data.notification == true,
                          notifyBefore: data.notifyBefore,
                        ),
                        UIHelper.verticalSpace(16.h),
                        _buildDoctorNotesCard(data.doctorNote),
                        UIHelper.verticalSpace(30.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildDailyScheduleCard(List<String> takingTimes) {
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
          if (takingTimes.isEmpty)
            Text(
              'No taking times selected',
              style: TextFontStyle.textStyle14w500c242424.copyWith(
                color: Colors.white54,
                fontSize: 14.sp,
              ),
            )
          else
            ...takingTimes.map((time) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _timeChip(time),
              );
            }),
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

  Widget _buildDurationCard({
    required String startDate,
    required String endDate,
    required bool beforeMeal,
  }) {
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
          _infoRow('Start Date', startDate),
          UIHelper.verticalSpace(12.h),
          _infoRow('End Date', endDate),
          UIHelper.verticalSpace(12.h),
          Divider(color: Colors.white12, thickness: 1.h),
          UIHelper.verticalSpace(12.h),
          _infoRow('Before Meal', beforeMeal ? 'Yes' : 'No'),
        ],
      ),
    );
  }

  Widget _buildReminderSettingsCard({
    required bool enabled,
    required int? notifyBefore,
  }) {
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
          _infoRow('Notifications', enabled ? 'Enabled' : 'Disabled'),
          if (enabled && notifyBefore != null) ...[
            UIHelper.verticalSpace(12.h),
            _infoRow('Notify Before', '$notifyBefore minutes'),
          ],
        ],
      ),
    );
  }

  Widget _buildDoctorNotesCard(String? notes) {
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
            (notes == null || notes.trim().isEmpty)
                ? 'No special instructions provided by your doctor.'
                : notes,
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
                        onTap: () async {
                          Navigator.pop(context); // close dialog
                          EasyLoading.show(status: 'Deleting...');
                          bool success = await deletePrescribedMedicineRxObj.deletePrescribedMedicineInfo(widget.id);
                          EasyLoading.dismiss();
                          if (success) {
                            getPrescribedMedicinesRxObj.fetchPrescribedMedicines();
                            NavigationService.goBack; // go back from details screen
                          }
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
