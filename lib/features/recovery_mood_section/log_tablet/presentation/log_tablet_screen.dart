import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/model/all_medication_model.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/custom_acetaminophen.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/date_time.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/medication_details.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/water_intake.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:ktmtommy_apps/networks/endpoints.dart';

class LogTabletScreen extends StatefulWidget {
  const LogTabletScreen({super.key});

  @override
  State<LogTabletScreen> createState() => _LogTabletScreenState();
}

class _LogTabletScreenState extends State<LogTabletScreen> {
  // Form keys for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _medicationFormKey = GlobalKey<FormState>();

  // Text controllers for input fields
  final TextEditingController notesController = TextEditingController();
  final TextEditingController medicationNameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();

  // Selected date and time for medication
  DateTime? _selectedDateTime;

  // Loading state for form submission
  bool isLoading = false;

  // Icons for UI
  final String checkIcon = 'assets/icons/signureicon.svg';
  final List<String> deleteIcon = [
    'assets/icons/deleteicon.svg',
    'assets/icons/deleteicon.svg',
  ];

  // State variables for wellness tracking
  bool isOn = false;
  bool isOf = false;
  int currentGlassCount = 0;
  bool isAMSelected = true;

  @override
  void initState() {
    super.initState();
    // Initialize with current date and time
    _selectedDateTime = DateTime.now();
    // Fetch all medications on screen initialization
    getAllMedicationRxObj.getAllMedicationApi();
  }

  @override
  void dispose() {
    // Dispose controllers and streams to prevent memory leaks
    notesController.dispose();
    medicationNameController.dispose();
    dosageController.dispose();
    storeRxObj.dataFetcher.close();
    super.dispose();
  }

  // Show confirmation dialog for deletion
  Future<bool?> _showDeleteConfirmationDialog(BuildContext context, String medicationName, String medicationId) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.c181818,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: Text(
            'Delete Medication',
            style: TextFontStyle.textStyle16w700primaryColor2PlusJakartaSans.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          content: Text(
            'Are you sure you want to delete $medicationName?',
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
              color: AppColors.cFFFFFF,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel deletion
              },
              child: Text(
                'Cancel',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  color: AppColors.cFFFFFF,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm deletion
              },
              child: Text(
                'Confirm',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  color: AppColors.cCC1F28,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Appbar with back button and title
                CustomAppbarWidget(
                  onTap: () {
                    NavigationService.goBack();
                  },
                  text: 'Log Tablet',
                ),
                UIHelper.verticalSpace(20.h),
                // Medication Details Section
                Text(
                  'Medication Details',
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Medication name and dosage input
                        MedicationDetails(
                          title: 'Medication Name',
                          nameController: medicationNameController,
                          dosageController: dosageController,
                          formKey: _medicationFormKey,
                        ),
                        UIHelper.verticalSpace(18.h),
                        // Time Taken Section
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.timetoken, height: 18.h),
                            UIHelper.horizontalSpace(8.w),
                            Text(
                              'Time Taken',
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(12.h),
                        // Date and time selector
                        DateTimeSelector(
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime selectedDateTime) {
                            setState(() {
                              _selectedDateTime = selectedDateTime;
                            });
                            // Log selected date and time
                            print('Selected DateTime: $selectedDateTime');
                          },
                          restrictToCurrentMonth: true,
                        ),
                        UIHelper.verticalSpace(18.h),
                        // Wellness Tracking Section
                        Text(
                          'Wellness Tracking',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 13.h,
                          ),
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Column(
                            children: [
                              // Upright Posture Switch
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Upright Posture',
                                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 0.90,
                                    child: Switch(
                                      activeColor: AppColors.cFFFFFF,
                                      activeTrackColor: AppColors.cCC1F28,
                                      inactiveTrackColor: AppColors.cE9E9EA,
                                      inactiveThumbColor: AppColors.c87B842,
                                      value: isOf,
                                      onChanged: (bool value) {
                                        setState(() => isOf = value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpace(16.h),
                              // Water Intake Tracker
                              WaterIntake(
                                onGlassCountChanged: (count) {
                                  setState(() => currentGlassCount = count);
                                },
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(18.h),
                        // Notes Section
                        Text(
                          'Notes',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(18),
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Column(
                            children: [
                              CustomTextfield(
                                textAlign: TextAlign.start,
                                controller: notesController,
                                borderRadius: 4,
                                borderColor: Colors.transparent,
                                maxline: 3,
                                fillColor: AppColors.c2A2A2A,
                                hintText: 'Add notes about symptom or Side effect',
                                hintTextSyle: TextFontStyle.textStyle16w400c757575poppins.copyWith(fontSize: 12.sp),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(24.h),
                        // Log Now Button
                        CustomButtonWidget(
                          textStyle: TextFontStyle.textStylePoppins,
                          onTap: () async {
                            // Validate forms before submission
                            if (_medicationFormKey.currentState!.validate() && _formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                // Collect form data
                                final name = medicationNameController.text;
                                final dosage = double.tryParse(dosageController.text) ?? 0.0;
                                const dosageUnit = "mg";
                                const isPrescribed = true;
                                final takenAt = _selectedDateTime != null
                                    ? DateFormat('yyyy-MM-dd HH:mm:ss').format(_selectedDateTime!)
                                    : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
                                final uprightPosture = isOf;
                                final waterIntake = currentGlassCount > 0;
                                final glassOfWater = currentGlassCount;
                                final notes = notesController.text;

                                // Log collected data for debugging
                                print('>>>>>>===========<<<<<');
                                print('===========>>>Medication Name: $name');
                                print('===========>>>Dosage: $dosage $dosageUnit');
                                print('===========>>>Is Prescribed: $isPrescribed');
                                print('===========>>>Taken At: $takenAt');
                                print('===========>>>Upright Posture: $uprightPosture');
                                print('===========>>>Water Intake: $waterIntake');
                                print('===========>>>Glass of Water: $glassOfWater');
                                print('===========>>>Notes: $notes');
                                print('>>>>>>===========<<<<<');

                                // Call API to save medication
                                bool success = await storeRxObj.postStoreApi(
                                  name: name,
                                  dosage: dosage,
                                  dosageUnit: dosageUnit,
                                  isPrescribed: isPrescribed,
                                  takenAt: takenAt,
                                  uprightPosture: uprightPosture,
                                  waterIntake: waterIntake,
                                  glassOfWater: glassOfWater,
                                  notes: notes,
                                );

                                if (success) {
                                  // Log success and navigate to recent medication screen
                                  print('==========>>>>>>Success medication saved');
                                  NavigationService.navigateTo(Routes.recentMedicationScreen);
                                }
                              } catch (e) {
                                // Log error and show toast
                                print('================>>>>>>>>>>Error saving medication: $e');

                                ToastUtil.showShortToast("Failed to save medication. Please try again.");
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          text: 'Log Now',
                          child: isLoading
                              ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3,
                          )
                              : Text(
                            'Log Now',
                            style: TextFontStyle.textStylePoppins.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(24.h),
                        // Recent Medication Section
                        Text(
                          'Recent Medication',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),
                        // Recent Medication List
                        GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(Routes.recentMedicationScreen);
                          },
                          child: StreamBuilder(
                            stream: getAllMedicationRxObj.dataFetcher,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                // Log error if fetching fails
                                print('Error fetching medication data: ${snapshot.error}');
                                return Center(child: Text('Error: ${snapshot.error}'));
                              }

                              final medication = snapshot.data?.data ?? [];
                              if (medication.isEmpty) {
                                return const SizedBox.shrink();
                              }

                              // Limit to first 2 medications
                              final limitedMedication = medication.take(2).toList();

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: limitedMedication.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = limitedMedication[index];
                                  // Track deletion state for individual item
                                  bool isDeleting = false;

                                  return StatefulBuilder(
                                    builder: (context, setItemState) {
                                      return CustomAcetaminophen(
                                        title: item.name?.toString() ?? '',
                                        icon: checkIcon,
                                        mg: '${item.dosage ?? 0} ${item.dosageUnit ?? ''}',
                                        subtitle: item.takenAt != null
                                            ? DateFormat('yyyy-MM-dd HH:mm').format(item.takenAt!)
                                            : 'No date available',
                                        deleteIcon: index < deleteIcon.length ? deleteIcon[index] : 'assets/icons/default_delete_icon.svg',
                                        onDelete: () async {
                                          print('Initiating deletion for Medication ID: ${item.id}, Name: ${item.name}');
                                          final shouldDelete = await _showDeleteConfirmationDialog(context, item.name ?? 'Unknown', item.id.toString());

                                          if (shouldDelete != true) {
                                            print('Deletion cancelled for Medication ID: ${item.id}');
                                            return;
                                          }

                                          setItemState(() {
                                            isDeleting = true;
                                          });

                                          final backupMedication = List.from(medication); // Backup the current list

                                          // Optimistic UI update
                                          setState(() {
                                            medication.removeWhere((m) => m.id == item.id);
                                          });

                                          try {
                                            bool success = await deleteMedicationRxObj.deleteMedicationApi(id: item.id.toString());
                                            if (success) {
                                              print('Successfully deleted Medication ID: ${item.id}');
                                              EasyLoading.showSuccess('Medication deleted successfully 🎉');
                                              await getAllMedicationRxObj.getAllMedicationApi();
                                            } else {
                                              EasyLoading.showError('Failed to delete medication 😔');
                                            }
                                          } catch (error) {
                                            print('=============>>>>>>Error deleting Medication ID: ${item.id}, Error: $error');
                                            setState(() {
                                              medication.clear();
                                              medication.addAll(backupMedication.map((item) => item is Datum ? item : Datum.fromJson(item)));
                                            });
                                          } finally {
                                            setItemState(() {
                                              isDeleting = false;
                                            });
                                          }
                                        },

                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
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
    );
  }
}