import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_form_field/phone_form_field.dart'; // 👈 Add this package
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class PersonalInformationSignUpScreen extends StatefulWidget {
  const PersonalInformationSignUpScreen({super.key});

  @override
  State<PersonalInformationSignUpScreen> createState() => _PersonalInformationSignUpScreenState();
}

class _PersonalInformationSignUpScreenState extends State<PersonalInformationSignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // 👇 Phone controller for the new package
  final PhoneController phoneController = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.US, nsn: ''),
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isChecked = false;
  bool _showCheckboxError = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.restbacroundimage),
                fit: BoxFit.cover
            )
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ArrowButtonAtheleteFlow(
                    onTap: () {
                      NavigationService.goBack;
                    },
                  ),
                  UIHelper.verticalSpace(24.h),
                  Text(
                      'Personal Information',
                      style: TextFontStyle.textStyle24w700cFFFFFFTeko
                  ),
                  UIHelper.verticalSpace(2.h),
                  Text(
                      'Please provide us with the information to\ncontinue',
                      style: TextFontStyle.textStyle14w400cD1D1D1poppins
                  ),
                  UIHelper.verticalSpace(24.h),

                  // Name Field
                  CustomTextfield(
                    borderColor: AppColors.cD1D1D1,
                    textAlign: TextAlign.start,
                    controller: nameController,
                    prefixIcon: Transform.scale(
                        scale: 0.50,
                        child: SvgPicture.asset(
                          AppIcons.usernameicon,
                          height: 20.h,
                          color: AppColors.orangeColor,
                        )
                    ),
                    hintText: 'Type your full name',
                    hintTextSyle: TextFontStyle.textStyle14w400cE8E8E8poppins,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    style: const TextStyle(color: AppColors.cFFFFFF),
                  ),

                  UIHelper.verticalSpace(30.h),

                  // Email Field
                  CustomTextfield(
                    textAlign: TextAlign.start,
                    controller: emailController,
                    borderColor: AppColors.cD1D1D1,
                    prefixIcon: Transform.scale(
                        scale: 0.50,
                        child: SvgPicture.asset(
                          AppIcons.typeEmailicon,
                          height: 20.h,
                          color: AppColors.orangeColor,
                        )
                    ),
                    hintText: 'Type your email',
                    hintTextSyle: TextFontStyle.textStyle14w400cE8E8E8poppins,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                    style: const TextStyle(color: AppColors.cFFFFFF),
                  ),

                  UIHelper.verticalSpace(30.h),

                  // 👇 Phone Number Field with phone_form_field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.cD1D1D1),
                    ),
                    child: PhoneFormField(
                      controller: phoneController,
                      style: const TextStyle(color: AppColors.cFFFFFF),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: AppColors.cE8E8E8,
                          fontSize: 14.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                      ),
                      validator: (PhoneNumber? phone) {
                        if (phone == null || phone.international.isEmpty) {
                          return 'Phone number is required';
                        }
                        if (!phone.isValid()) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      onChanged: (PhoneNumber? phone) {
                        // Handle phone number changes if needed
                      },
                      countrySelectorNavigator:
                      const CountrySelectorNavigator.dialog(),
                      isCountrySelectionEnabled: true,
                      isCountryButtonPersistent: true,
                      countryButtonStyle: CountryButtonStyle(
                        showFlag: true,
                        flagSize: 20,
                        textStyle: const TextStyle(
                          color: AppColors.cFFFFFF,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  UIHelper.verticalSpace(30.h),

                  // Password Field
                  CustomTextfield(
                    controller: passwordController,
                    borderColor: AppColors.cD1D1D1,
                    textAlign: TextAlign.start,
                    prefixIcon: Transform.scale(
                        scale: 0.50,
                        child: SvgPicture.asset(
                          AppIcons.typepasswordicon,
                          height: 20.h,
                          color: AppColors.orangeColor,
                        )
                    ),
                    hintText: 'Type your Password',
                    hintTextSyle: TextFontStyle.textStyle14w400cE8E8E8poppins,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    isObsecure: true,
                    isPass: true,
                    style: const TextStyle(color: AppColors.cFFFFFF),
                  ),

                  UIHelper.verticalSpace(30.h),

                  // Confirm Password Field
                  CustomTextfield(
                    controller: confirmPasswordController,
                    borderColor: AppColors.cD1D1D1,
                    textAlign: TextAlign.start,
                    prefixIcon: Transform.scale(
                        scale: 0.50,
                        child: SvgPicture.asset(
                          AppIcons.typepasswordicon,
                          height: 20.h,
                          color: AppColors.orangeColor,
                        )
                    ),
                    hintText: 'Confirm Password',
                    hintTextSyle: TextFontStyle.textStyle14w400cE8E8E8poppins,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm password is required';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    isObsecure: true,
                    isPass: true,
                    style: const TextStyle(color: AppColors.cFFFFFF),
                  ),

                  UIHelper.verticalSpace(30.h),

                  // Terms & Conditions Checkbox
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            activeColor: AppColors.cFFFFFF,
                            checkColor: AppColors.orangeColor,
                            side: BorderSide(
                                color: AppColors.orangeColor,
                                width: 2
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            value: _isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isChecked = newValue ?? false;
                                _showCheckboxError = false;
                              });
                            },
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        'I agree to the',
                                        style: TextFontStyle.textStyle14w400cE8E8E8poppins
                                    ),
                                    UIHelper.horizontalSpace(6.w),
                                    GestureDetector(
                                      onTap: () {
                                        NavigationService.navigateTo(
                                            Routes.athletTramsConditionScreen
                                        );
                                      },
                                      child: Text(
                                        'terms & Condition',
                                        style: TextFontStyle.textStyle24w600cF55216poppins.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.orangeColor,
                                          decorationStyle: TextDecorationStyle.solid,
                                          decorationThickness: 1.5,
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(6.w),
                                    Text(
                                        'and',
                                        style: TextFontStyle.textStyle14w400cE8E8E8poppins
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // NavigationService.navigateTo(
                                    //     Routes.privacyPolicyScreen
                                    // );
                                  },
                                  child: Text(
                                    'Privacy Policy',
                                    style: TextFontStyle.textStyle24w600cF55216poppins.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.orangeColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (_showCheckboxError)
                        Padding(
                          padding: EdgeInsets.only(left: 40.w, top: 4.h),
                          child: const Text(
                            'Please accept the terms & condition',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),

                  UIHelper.verticalSpace(70.h),

                  // Continue Button
                  CustomButtonWidget(
                    textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                    image: DecorationImage(
                        image: AssetImage(AppImages.orangebutton)
                    ),
                    text: 'CONTINUE',
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (!_isChecked) {
                          setState(() {
                            _showCheckboxError = true;
                          });
                          return;
                        }

                        // Get the full phone number with country code
                        String fullPhoneNumber =
                            phoneController.value?.international ?? '';

                        // Save data locally
                        appData.write(kKeyuserAthleteFullName, nameController.text);
                        appData.write(kKeyuserAthleteEmail, emailController.text);
                        appData.write(kKeyuserAthletePhone, fullPhoneNumber); // Save phone number
                        appData.write(kKeyuserAthletePassword, confirmPasswordController.text);

                        log("+++++++++++name: ${appData.read(kKeyuserAthleteFullName)}");
                        log("+++++++++++email: ${appData.read(kKeyuserAthleteEmail)}");
                        log("+++++++++++phone: ${appData.read(kKeyuserAthletePhone)}");
                        log("+++++++++++password: ${appData.read(kKeyuserAthletePassword)}");

                        // Get current system IANA timezone
                        String timezone = 'UTC';
                        try {
                          timezone = (await FlutterTimezone.getLocalTimezone()).identifier;
                        } catch (e) {
                          log("Error getting timezone: $e");
                        }

                        // Call API with phone number
                        bool success = await altheleteSignUpRx.altheleteSignUpInfo(
                            termsAccepted: true,
                            name: nameController.text,
                            email: emailController.text,
                            // phone: fullPhoneNumber, // Add phone parameter
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                            timezone: timezone,
                        );

                        if (success) {
                          NavigationService.navigateTo(Routes.welcomeAtheleteScreen);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registration failed. Please try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }

                        log("==========>>>>>>>go to welcomeAtheleteScreen");
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