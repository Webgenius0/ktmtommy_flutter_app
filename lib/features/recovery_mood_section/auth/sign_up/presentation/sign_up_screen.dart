import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:phone_form_field/phone_form_field.dart'; // 👈 New package
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

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
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            NavigationService.goBack;
                          },
                          child:
                              SvgPicture.asset(AppIcons.arrwbaciconwithcolor)),
                    ],
                  ),
                  Text('Create an Account',
                      textAlign: TextAlign.center,
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    'Hello there, please enter information\nto register 👍',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle14w400cE8E8E8poppins,
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
                      ),
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
                      ),
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
                      ),
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
                      ),
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
                            checkColor: AppColors.c87B842,
                            side: const BorderSide(
                              color: AppColors.c87B842,
                              width: 2,
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
                                      style: TextFontStyle
                                          .textStyle14w400cE8E8E8poppins,
                                    ),
                                    UIHelper.horizontalSpace(6.w),
                                    GestureDetector(
                                      onTap: () {
                                        NavigationService.navigateTo(
                                            Routes.termsAndConditionScreen);
                                      },
                                      child: Text(
                                        'terms & Condition',
                                        style: TextFontStyle
                                            .textStyle14w400c87B842poppins
                                            .copyWith(
                                          decoration:
                                          TextDecoration.underline,
                                          decorationColor: AppColors.c87B842,
                                          decorationStyle:
                                          TextDecorationStyle.solid,
                                          decorationThickness: 1.5,
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(6.w),
                                    Text(
                                      'and',
                                      style: TextFontStyle
                                          .textStyle14w400cE8E8E8poppins,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // NavigationService.navigateTo(
                                    //     Routes.privacyPolicyScreen);
                                  },
                                  child: Text(
                                    'Privacy Policy',
                                    style: TextFontStyle
                                        .textStyle14w400c87B842poppins
                                        .copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.c87B842,
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

                  UIHelper.verticalSpace(24.h),

                  // Sign Up Button
                  CustomButtonWidget(
                    textStyle: TextFontStyle.textStyle20w700c000000poppins,
                    image: DecorationImage(
                      image: AssetImage(AppImages.withbacrounbutton),
                    ),
                    text: 'SIGN UP',
                    onTap: () async {
                      // Validate form
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
                        appData.write(kKeyuserEmail, emailController.text);
                        appData.write(kKeyuserFullName, nameController.text);
                        appData.write(kKeyuserPhone, fullPhoneNumber);
                        appData.write(
                            kKeyuserPassword, confirmPasswordController.text);

                        // Show loading
                        EasyLoading.show(status: 'Registering...');
                        try {
                          // Get current system IANA timezone
                          String timezone = 'UTC';
                          try {
                            timezone = (await FlutterTimezone.getLocalTimezone()).identifier;
                          } catch (e) {
                            log("Error getting timezone: $e");
                          }

                          // Call API
                          bool success = await altheleteSignUpRx
                              .altheleteSignUpInfo(
                            termsAccepted: true,
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                            timezone: timezone,
                          );

                          if (success) {
                            EasyLoading.showSuccess('Registration Successful! 🎉');
                            log('Registration successful');
                            log('Full Name: ${appData.read(kKeyuserFullName)}');
                            log('Email: ${appData.read(kKeyuserEmail)}');
                            log('Phone: ${appData.read(kKeyuserPhone)}');

                            NavigationService.navigateToWithArgs(
                              Routes.verifyOtpScreen,
                              {'isFromSignUp': true},
                            );
                          } else {
                            EasyLoading.dismiss();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration failed. Please try again.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } catch (e) {
                          EasyLoading.dismiss();
                          log("Exception during registration: $e");
                        }
                      }
                    },
                  ),
                  UIHelper.verticalSpace(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextFontStyle.textStyle14w400cF3F3F3poppins,
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(Routes.loginScreenAthlet);
                        },
                        child: Text('Login now',
                            style: TextFontStyle.textStyle14w400cF55216poppins
                                .copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                            )),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}