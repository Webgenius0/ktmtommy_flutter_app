import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/custom_acetaminophen.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';

class RecentMedicationScreen extends StatefulWidget {
  const RecentMedicationScreen({super.key});

  @override
  State<RecentMedicationScreen> createState() => _RecentMedicationScreenState();
}

class _RecentMedicationScreenState extends State<RecentMedicationScreen> {
  final String checkIcon = 'assets/icons/signureicon.svg';
  final String deleteIcon = 'assets/icons/deleteicon.svg';

  @override
  void initState() {
    super.initState();
    getAllMedicationRxObj.getAllMedicationApi();
  }

  Future<bool?> _showDeleteConfirmationDialog(
      BuildContext context, String medicationName, String medicationId) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.c181818,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: Text('Delete Medication',
              style: TextFontStyle.textStyle16w700primaryColor2PlusJakartaSans
                  .copyWith(color: AppColors.primaryColor)),
          content: Text(
            'Are you sure you want to delete $medicationName?',
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                color: AppColors.cFFFFFF,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Cancel',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    color: AppColors.cFFFFFF,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Confirm',
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      color: AppColors.cCC1F28,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)
                  // Red color for confirm
                  ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppbarWidget(
                onTap: () => NavigationService.goBack,
                text: 'Recent Medication Log',
              ),
              UIHelper.verticalSpace(20.h),

              ///===============StreamBuilder Section===========================
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
                decoration: ShapeDecoration(
                  color: AppColors.c181818,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: StreamBuilder(
                  stream: getAllMedicationRxObj.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Log error if fetching data fails
                      print(
                          'Error fetching medication data: ${snapshot.error}');
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextFontStyle.textStyle16w400c757575poppins,
                        ),
                      );
                    }

                    final medication = snapshot.data?.data ?? [];

                    if (medication.isEmpty) {
                      return Center(
                        child: Text(
                          'No medication data...',
                          style: TextFontStyle.textStyle16w400c757575poppins
                              .copyWith(
                            fontSize: 16.sp,
                            color: AppColors.cFFFFFF,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: medication.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = medication[index];
                        return CustomAcetaminophen(
                          title: item.name ?? 'Unknown',
                          icon: checkIcon,
                          mg: '${item.dosage ?? 0} ${item.dosageUnit ?? ''}',
                          subtitle: item.takenAt ?? '',
                          deleteIcon: deleteIcon,
                          onDelete: () async {
                            log('=========>>>>>Initiating deletion for Medication ID: ${item.id}, Name: ${item.name}');

                            final shouldDelete =
                                await _showDeleteConfirmationDialog(context,
                                    item.name ?? 'Unknown', item.id.toString());

                            if (shouldDelete != true) {
                              log('===========>>>>>>>>>Deletion cancelled for Medication ID: ${item.id}');
                              return;
                            }

                            setState(() {
                              medication.removeAt(index);
                            });

                            try {
                              bool success = await deleteMedicationRxObj
                                  .deleteMedicationApi(id: item.id.toString());

                              if (success) {
                                log('==========>>>>>>>Successfully deleted Medication ID: ${item.id}');
                                await getAllMedicationRxObj
                                    .getAllMedicationApi();
                              } else {
                                log('==========>>>>>>>>>>>>Failed to delete Medication ID: ${item.id}');

                                setState(() {});
                                await getAllMedicationRxObj
                                    .getAllMedicationApi();
                              }
                            } catch (error) {
                              log('========++++++Error deleting Medication ID: ${item.id}, Error: $error');
                              await getAllMedicationRxObj.getAllMedicationApi();
                            }
                          },
                          id: item.id.toString(),
                          onTap: () {
                            log('=================>>>>>>>Selected Medication ID: ${item.id}');
                            NavigationService.navigateToWithArgs(
                                Routes.editMedicationScreen, {
                              'id': item.id,
                              'name': item.name,
                              'dosage': item.dosage,
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              UIHelper.verticalSpace(250.h),

              ///=============Button Section====================================
              CustomButtonWidget(
                onTap: () =>
                    NavigationService.navigateTo(Routes.logTabletScreen),
                icon: SvgPicture.asset(AppIcons.pluseadd),
                text: 'Add New Log',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
