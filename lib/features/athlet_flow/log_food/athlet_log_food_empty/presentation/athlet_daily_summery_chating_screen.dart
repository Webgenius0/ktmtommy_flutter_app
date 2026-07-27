import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_tablet/widget/log_activity_calander.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:ktmtommy_apps/helpers/toast.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/model/dietitian_settings_model.dart';

class AthletDailySummerySettingsScreen extends StatefulWidget {
  const AthletDailySummerySettingsScreen({super.key});

  @override
  State<AthletDailySummerySettingsScreen> createState() =>
      _AthletDailySummerySettingsScreenState();
}

class _AthletDailySummerySettingsScreenState
    extends State<AthletDailySummerySettingsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  bool isEnabled = true;
  DateTime? selectedTime;
  StreamSubscription? _subscription;
  bool isPageLoading = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _subscription = dietitianSettingsRxObj.dietitianSettingsStream.listen((event) {
      if (event.data != null) {
        setState(() {
          nameController.text = event.data?.name ?? "";
          emailController.text = event.data?.dietitianEmail ?? "";
          isEnabled = event.data?.isEnabled ?? true;
          isPageLoading = false;

          if (event.data?.sendTime != null) {
            try {
              final timeParts = event.data!.sendTime!.split(':');
              final hour = int.parse(timeParts[0]);
              final minute = int.parse(timeParts[1]);
              final now = DateTime.now();
              selectedTime = DateTime(now.year, now.month, now.day, hour, minute);
              timeController.text = DateFormat('h:mm a').format(selectedTime!);
            } catch (e) {
              // Fallback
            }
          }
        });
      }
    }, onError: (err) {
      setState(() {
        isPageLoading = false;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dietitianSettingsRxObj.getDietitianSettings().then((_) {
        if (mounted) {
          setState(() {
            isPageLoading = false;
          });
        }
      }).catchError((_) {
        if (mounted) {
          setState(() {
            isPageLoading = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    nameController.dispose();
    emailController.dispose();
    timeController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    if (nameController.text.trim().isEmpty) {
      ToastUtil.showShortToast("Please enter your name");
      return;
    }
    if (emailController.text.trim().isEmpty) {
      ToastUtil.showShortToast("Please enter dietitian email");
      return;
    }
    if (selectedTime == null) {
      ToastUtil.showShortToast("Please select a daily send time");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final formattedTime = DateFormat('HH:mm').format(selectedTime!);
    final result = await dietitianSettingsRxObj.postDietitianSettings(
      isEnabled: isEnabled ? "1" : "0",
      name: nameController.text.trim(),
      dietitianEmail: emailController.text.trim(),
      sendTime: formattedTime,
    );

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }

    if (result?.success == true) {
      ToastUtil.showShortToast(result?.message ?? "Settings saved successfully");
      NavigationService.goBack();
    } else {
      ToastUtil.showShortToast("Failed to save settings");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.bacroundColorBlack,
        body: SafeArea(
          child: Column(
            children: [
              UIHelper.verticalSpace(20),
              ArrowButtonAtheleteFlow(
                onTap: () => NavigationService.goBack,
                text: 'Settings',
                subtitle: 'Manage your dietitian email preferences',
              ),
              UIHelper.verticalSpace(20),
              Expanded(
                child: isPageLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.orangeColor,
                        ),
                      )
                    : SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColors.c181818,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Daily Summary',
                                          style: TextFontStyle.textStyle20w700c000000poppins.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Switch(
                                        value: isEnabled,
                                        activeColor: AppColors.orangeColor,
                                        onChanged: (v) {
                                          setState(() {
                                            isEnabled = v;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpace(4),
                                  Text(
                                    'Share your daily food intake with your dietitian',
                                    style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  UIHelper.verticalSpace(20),
                                  Text('Your Name', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                                  UIHelper.verticalSpace(6),
                                  CustomTextfield(
                                    controller: nameController,
                                    fillColor: AppColors.c2A2A2A,
                                    borderRadius: 20.r,
                                    textAlign: TextAlign.start,
                                    hintText: 'Enter your name',
                                    hintTextSyle: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                    style: const TextStyle(color: AppColors.cFFFFFF),
                                  ),
                                  UIHelper.verticalSpace(20),
                                  Text('Dietitian Email Address', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                                  UIHelper.verticalSpace(6),
                                  CustomTextfield(
                                    textAlign: TextAlign.start,
                                    controller: emailController,
                                    fillColor: AppColors.c2A2A2A,
                                    borderRadius: 20.r,
                                    hintText: 'dietitian@example.com',
                                    hintTextSyle: TextFontStyle.textStyle14w400cA3A3A3poppins,
                                    style: const TextStyle(color: AppColors.cFFFFFF),
                                  ),
                                  UIHelper.verticalSpace(20),
                                  Text('Daily Send Time', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
                                  UIHelper.verticalSpace(6),
                                  LogActivityTimePicker(
                                    controller: timeController,
                                    hintText: '3:30 PM',
                                    onTimeSelected: (DateTime t) {
                                      setState(() {
                                        selectedTime = t;
                                        timeController.text = DateFormat('h:mm a').format(t);
                                      });
                                    },
                                  ),
                                  UIHelper.verticalSpace(8),
                                  Text(
                                    selectedTime != null
                                        ? 'Summary will be sent daily at ${timeController.text}'
                                        : 'Summary will be sent daily at 3:30 PM',
                                    style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.verticalSpace(16),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColors.c181818,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      UIHelper.horizontalSpace(6),
                                      Text(
                                        '📧 How it works',
                                        style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                                          color: AppColors.orangeColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpace(8),
                                  _bullet('Daily summaries include all meals logged'),
                                  _bullet('Each entry shows food name, calories, timestamp, and notes'),
                                  _bullet('Grouped by meal type: Breakfast, Lunch, Dinner, and Snacks'),
                                  _bullet('Automatically sent at your specified time each day'),
                                ],
                              ),
                            ),
                            UIHelper.verticalSpace(16),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColors.c181818,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Icon(
                                      Icons.lock_outline,
                                      color: AppColors.orangeColor,
                                      size: 18.sp,
                                    ),
                                  ),
                                  UIHelper.horizontalSpace(8),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Privacy Notice",
                                          style: TextFontStyle.headline18w500cFFFFFF.copyWith(
                                            color: AppColors.orangeColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'This demo app is not meant for collecting PII or securing sensitive health data. Please consult your healthcare provider for professional medical advice.',
                                          style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.verticalSpace(90),
                          ],
                        ),
                      ),
              ),
              if (!isPageLoading)
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: CustomButtonWidget(
                    text: 'Save Settings',
                    isLoading: isLoading,
                    image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                    onTap: _saveSettings,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•  ',
            style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
              color: AppColors.orangeColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}