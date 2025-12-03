import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button.dart';
import 'package:ktmtommy_apps/features/athlet_flow/profile_section_athlet/widget/custom_password_field_athlet.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/profile_section/widget/custom_password_field.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class ChangePasswordScreenAthlet extends StatefulWidget {
  const ChangePasswordScreenAthlet({super.key});

  @override
  State<ChangePasswordScreenAthlet> createState() => _ChangePasswordScreenAthletState();
}

class _ChangePasswordScreenAthletState extends State<ChangePasswordScreenAthlet> {
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? _validateCurrent(String? value) =>
      (value?.isEmpty ?? true) ? "Enter current password" : null;

  String? _validateNew(String? value) {
    if (value?.isEmpty ?? true) return "Enter new password";
    if (value!.length < 6) return "Minimum 6 characters required";
    return null;
  }

  String? _validateConfirm(String? value) {
    if (value?.isEmpty ?? true) return "Confirm your password";
    if (value != _newPassController.text) return "Passwords do not match";
    return null;
  }

  Future<void> _savePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.c181818,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppIcons.check_icon, width: 80.w, height: 80.h),
            UIHelper.verticalSpace(20.h),
            Text("Password Changed!",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            UIHelper.verticalSpace(12.h),
            Text("Your password has been updated successfully.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.cA3A3A3, fontSize: 14.sp)),
            UIHelper.verticalSpace(30.h),
            CustomButton(
              name: "Back to Profile",
              onCallBack: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              color: AppColors.c87B842,
              borderColor: AppColors.c87B842,
              height: 48.h,
              borderRadius: 999.r,
              context: context,
            ),
          ],
        ),
      ),
    );

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _currentPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                ///==========Appbar Section===========///
                ArrowButtonAtheleteFlow(
                  text: 'Update Password',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ///==========Form Section===========///
                UIHelper.verticalSpace(40.h),

                // Custom Password Fields
                CustomPasswordFieldAthlet(
                  controller: _currentPassController,
                  hintText: "Current Password",
                  validator: _validateCurrent,
                ),
                UIHelper.verticalSpace(20.h),

                CustomPasswordFieldAthlet(
                  controller: _newPassController,
                  hintText: "New Password",
                  validator: _validateNew,
                ),
                UIHelper.verticalSpace(20.h),

                CustomPasswordFieldAthlet(
                  controller: _confirmPassController,
                  hintText: "Confirm New Password",
                  validator: _validateConfirm,
                ),
                UIHelper.verticalSpace(50.h),
                Spacer(),
                // Update Button
                CustomButton(
                  name: _isLoading ? "Saving..." : "Update Password",
                  onCallBack: _isLoading ? () {} : _savePassword,
                  color: AppColors.cF55216,
                  borderColor: AppColors.cF55216,
                  height: 52.h,
                  borderRadius: 999.r,
                  textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  context: context,
                ),
                UIHelper.verticalSpace(40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
