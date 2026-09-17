import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/custom_duration.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/custom_notification.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/time_custom.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/custom_activity_calander.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class AthletLogActivityScreen extends StatefulWidget {
  const AthletLogActivityScreen({super.key});

  @override
  State<AthletLogActivityScreen> createState() => _AthletLogActivityScreenState();
}

class _AthletLogActivityScreenState extends State<AthletLogActivityScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> workoutTypes = ['Running', 'Cycling', 'Swimming', 'Weight Training', 'Yoga'];
  String? selectedWorkout;
  String selectedTime = '11:30:00';
  int selectedDurationMinutes = 30;
  int selectedNotificationMinutes = 10;
  bool _isSaving = false;

  @override
  void dispose() {
    dateController.dispose();
    nameController.dispose();
    notesController.dispose();
    super.dispose();
  }

  String _formatDateForApi(String text) {
    if (text.trim().isEmpty) {
      return DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
    try {
      if (text.contains('/')) {
        final parts = text.trim().split('/');
        if (parts.length == 3) {
          if (parts[0].length == 4) {
            return "${parts[0]}-${parts[1].padLeft(2, '0')}-${parts[2].padLeft(2, '0')}";
          } else {
            return "${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}";
          }
        }
      }
      return text.trim();
    } catch (e) {
      return text.trim();
    }
  }

  Future<void> _onAddWorkoutTap() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSaving = true;
      });

      final String name = nameController.text.trim();
      final String date = _formatDateForApi(dateController.text);
      final String time = selectedTime;
      final int duration = selectedDurationMinutes;
      final int notifyBefore = selectedNotificationMinutes;
      final String notes = notesController.text.trim().isEmpty
          ? "Note for $name"
          : notesController.text.trim();

      try {
        final bool success = await logActivityRxObj.storeActivityPostApi(
          name: name,
          date: date,
          time: time,
          duration_minutes: duration,
          notify_before_minutes: notifyBefore,
          notes: notes,
        );

        if (success && mounted) {
          await getRecentActivityLogRx.getAllActivityApi();
          NavigationService.navigateTo(Routes.athletActivityScreen);
        }
      } catch (e) {
        log("Error storing activity: $e");
      } finally {
        if (mounted) {
          setState(() {
            _isSaving = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  // Header Button
                  ArrowButtonAtheleteFlow(
                    text: 'Log activity',
                    onTap: () {
                      NavigationService.goBack;
                    },
                  ),
                  UIHelper.verticalSpace(24.h),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                            decoration: ShapeDecoration(
                              color: AppColors.c181818,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Activity Name Label
                                Text(
                                  'Activity Name',
                                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                ),
                                UIHelper.verticalSpace(4.h),

                                // Activity Name Textfield
                                CustomTextfield(
                                  controller: nameController,
                                  textAlign: TextAlign.start,
                                  isRead: true,
                                  style: const TextStyle(color: Colors.white),
                                  hintText: 'Select Workout type',
                                  hintTextSyle: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  fillColor: AppColors.c2A2A2A,
                                  borderRadius: 20.r,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                  suffixIcon: PopupMenuButton<String>(
                                    icon: SvgPicture.asset(
                                      AppIcons.bottomdrodwonicon,
                                      height: 18.h,
                                    ),
                                    color: AppColors.c2A2A2A,
                                    onSelected: (String value) {
                                      setState(() {
                                        selectedWorkout = value;
                                        nameController.text = value;
                                      });
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return workoutTypes.map((String value) {
                                        return PopupMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter activity type';
                                    }
                                    return null;
                                  },
                                  ontap: () {
                                    final state = _formKey.currentState;
                                    if (state != null) {
                                      state.save();
                                    }
                                  },
                                ),
                                UIHelper.verticalSpace(18.h),

                                // Date Label & Selector
                                Text(
                                  'Date',
                                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                ),
                                UIHelper.verticalSpace(4.h),

                                CustomActivityCalander(
                                  controller: dateController,
                                  hintText: 'Select Date',
                                ),
                                UIHelper.verticalSpace(18.h),

                                // Time Label & Selector
                                Text(
                                  'Time',
                                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                ),
                                UIHelper.verticalSpace(4.h),

                                TimeCustom(
                                  initialTime: selectedTime,
                                  onTimeSelected: (time) {
                                    setState(() {
                                      selectedTime = time;
                                    });
                                  },
                                ),
                                UIHelper.verticalSpace(18.h),

                                // Duration Label & Selector
                                Text(
                                  'Duration',
                                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                ),
                                UIHelper.verticalSpace(4.h),

                                CustomDuration(
                                  onDurationSelected: (minutes) {
                                    setState(() {
                                      selectedDurationMinutes = minutes;
                                    });
                                  },
                                ),
                                UIHelper.verticalSpace(18.h),

                                // Notification Label & Selector
                                Text(
                                  'Notification',
                                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                ),
                                UIHelper.verticalSpace(4.h),

                                CustomNotification(
                                  initialMinutes: selectedNotificationMinutes,
                                  onMinutesSelected: (minutes) {
                                    setState(() {
                                      selectedNotificationMinutes = minutes;
                                    });
                                  },
                                ),
                                UIHelper.verticalSpace(18.h),

                                // Notes Label & Textfield
                                Text(
                                  'Notes',
                                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                ),
                                UIHelper.verticalSpace(4.h),

                                CustomTextfield(
                                  controller: notesController,
                                  textAlign: TextAlign.start,
                                  maxline: 4,
                                  borderRadius: 20.r,
                                  fillColor: AppColors.c2A2A2A,
                                  hintText: 'Add notes here',
                                  hintTextSyle: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                  style: const TextStyle(color: AppColors.cFFFFFF),
                                ),
                                UIHelper.verticalSpace(18.h),
                              ],
                            ),
                          ),

                          UIHelper.verticalSpace(40.h),

                          // Add Workout Button
                          if (_isSaving)
                            const CircularProgressIndicator(
                              color: AppColors.orangeColor,
                            )
                          else
                            CustomButtonWidget(
                              textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                              image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                              onTap: _onAddWorkoutTap,
                              text: 'Add Workout',
                            ),
                          UIHelper.verticalSpace(30.h),
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
