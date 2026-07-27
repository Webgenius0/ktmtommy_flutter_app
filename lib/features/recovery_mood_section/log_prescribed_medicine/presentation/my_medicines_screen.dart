import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_prescribed_medicine/model/prescribed_medicine_model.dart';

class MyMedicinesScreen extends StatefulWidget {
  const MyMedicinesScreen({super.key});

  @override
  State<MyMedicinesScreen> createState() => _MyMedicinesScreenState();
}

class _MyMedicinesScreenState extends State<MyMedicinesScreen> {
  @override
  void initState() {
    super.initState();
    getPrescribedMedicinesRxObj.fetchPrescribedMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: StreamBuilder<PrescribedMedicineModel>(
          stream: getPrescribedMedicinesRxObj.getPrescribedMedicinesData,
          builder: (context, snapshot) {
            final List<PrescribedMedicineData> medicineList = snapshot.data?.data ?? [];
            final String prescriptionCount = snapshot.connectionState == ConnectionState.waiting
                ? 'Loading...'
                : '${medicineList.length} active prescription${medicineList.length == 1 ? '' : 's'}';

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpace(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => NavigationService.goBack,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Medicines',
                                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                prescriptionCount,
                                style: TextFontStyle.textStyle14w500c242424.copyWith(
                                  color: Colors.white54,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Wait for result and refresh list when returning
                          await NavigationService.navigateTo(Routes.addMedicineBasicInfoScreen);
                          getPrescribedMedicinesRxObj.fetchPrescribedMedicines();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: const Color(0xffA6FF00),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(30.h),
                  Expanded(
                    child: Builder(
                      builder: (context) {
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
                                  onPressed: () => getPrescribedMedicinesRxObj.fetchPrescribedMedicines(),
                                  child: const Text('Try Again', style: TextStyle(color: Color(0xffA6FF00))),
                                ),
                              ],
                            ),
                          );
                        }

                        if (medicineList.isEmpty) {
                          return Center(
                            child: Text(
                              'No prescribed medicines found',
                              style: TextFontStyle.textStyle14w500c242424.copyWith(
                                color: Colors.white54,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: medicineList.length,
                          itemBuilder: (context, index) {
                            final medicine = medicineList[index];
                            final String nameStr = medicine.medicineName ?? 'Unknown';
                            final String dosageStr = '${medicine.dosage ?? ''}${medicine.dosageType ?? ''}';
                            final String typeStr = medicine.medicineType ?? '';

                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: GestureDetector(
                                onTap: () {
                                  NavigationService.navigateToWithArgs(
                                    Routes.medicineDetailsScreen,
                                    {
                                      'id': medicine.id,
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.c181818,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            nameStr,
                                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          UIHelper.verticalSpace(4.h),
                                          Text(
                                            '$dosageStr • $typeStr',
                                            style: TextFontStyle.textStyle14w500c242424.copyWith(
                                              color: Colors.white54,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16.sp),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
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
}
