import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isChecked = false;
  bool _showCheckboxError = false;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
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
              image: AssetImage(AppImages.restbacroundimage),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbarWidget(
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
                UIHelper.verticalSpace(24.h),
                Text(
                  'Personal Information',
                  style: TextFontStyle.textStylePoppins.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.cFFFFFF,
                  ),
                ),
                UIHelper.verticalSpace(2.h),

                Text('Please provide us with the information to\ncontinue',
                    style: TextFontStyle.textStylePoppins.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.cFFFFFF,
                    )),
                UIHelper.verticalSpace(24.h),
// ===================== name ==========================//
                CustomTextfield(
                  borderColor: AppColors.cD1D1D1,
                  textAlign: TextAlign.start,
                  controller: nameController,
                  prefixIcon: Transform.scale(
                      scale: 0.50,
                      child: SvgPicture.asset(AppIcons.usernameicon,
                          height: 20.h)),
                  hintText: 'Type your full name',
                  hintTextSyle: TextFontStyle.textStyle14w400cE8E8E8poppins,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  style: TextStyle(color: AppColors.cFFFFFF),
                ),

                //============================== email =====================//
                UIHelper.verticalSpace(30.h),

                CustomTextfield(
                  textAlign: TextAlign.start,
                  controller: emailController,
                  borderColor: AppColors.cD1D1D1,
                  prefixIcon: Transform.scale(
                      scale: 0.50,
                      child: SvgPicture.asset(AppIcons.typeEmailicon,
                          height: 20.h)),
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
                  style: TextStyle(color: AppColors.cFFFFFF),
                ),
                UIHelper.verticalSpace(30.h),

                //================ Done ======================//
                //==================== Password =====================//
                CustomTextfield(
                  controller: passwordController,
                  borderColor: AppColors.cD1D1D1,
                  textAlign: TextAlign.start,
                  prefixIcon: Transform.scale(
                      scale: 0.50,
                      child: SvgPicture.asset(AppIcons.typepasswordicon,
                          height: 20.h)),
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
                  style: TextStyle(color: AppColors.cFFFFFF),
                ),
                UIHelper.verticalSpace(30.h),

                //================== confirmpassword ==================//
                CustomTextfield(
                  controller: confirmPasswordController,
                  borderColor: AppColors.cD1D1D1,
                  textAlign: TextAlign.start,
                  prefixIcon: Transform.scale(
                      scale: 0.50,
                      child: SvgPicture.asset(AppIcons.typepasswordicon,
                          height: 20.h)),
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
                  style: TextStyle(color: AppColors.cFFFFFF),
                ),
                UIHelper.verticalSpace(30.h),
//===================== checkbox ====================//

                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: AppColors.cFFFFFF,
                          checkColor: AppColors.c87B842,
                          side: BorderSide(color: AppColors.c87B842, width: 2),
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
                                  Text('I agree to the',
                                      style: TextFontStyle
                                          .textStyle14w400cE8E8E8poppins),
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
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.c87B842,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        decorationThickness: 1.5,
                                      ),
                                    ),
                                  ),
                                  UIHelper.horizontalSpace(6.w),
                                  Text('and',
                                      style: TextFontStyle
                                          .textStyle14w400cE8E8E8poppins),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
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
                        child: Text(
                          'Please accept the terms & condition',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
                UIHelper.verticalSpace(70.h),

                // Sign Up Button
                CustomButtonWidget(
                  text: 'Sign Up',
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (!_isChecked) {
                        setState(() {
                          _showCheckboxError = true;
                        });
                        return;
                      }
                      appData.write(kKeyuserEmail, emailController.text);
                      appData.write(kKeyuserFullName, nameController.text);
                      appData.write(kKeyuserPassword, confirmPasswordController.text);




                      log('++++++++++++Full Name: ${appData.read(kKeyuserFullName)}');
                      log('++++++++++++Email: ${appData.read(kKeyuserEmail)}');
                      log('++++++++++++Password: ${appData.read(kKeyuserPassword)}');

                      log("==========>>>>>>>go to tellUsAboutScreen");
                      NavigationService.navigateTo(Routes.tellUsAboutScreen);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
