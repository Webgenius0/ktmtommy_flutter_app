import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:lottie/lottie.dart';



class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confrimPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please retype your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }


  @override
  void dispose() {
    passwordController.dispose();
    confrimPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage(AppImages.bacroundimage),
         fit: BoxFit.cover,
    ),
    ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: (){NavigationService.goBack;},
                          child: SvgPicture.asset(AppIcons.arrwbaciconwithcolor)),
                    ],
                  ),
                  Lottie.asset('assets/lottie/lightlock.json',height: 230.h,width: 230.w),

                  UIHelper.verticalSpace(40),

                  
                  Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontSize: 20.sp
                    ),
                  ),
                  UIHelper.verticalSpace(2.h),
                  Text(
                    'Please create new password',
                    style: TextFontStyle.textStyle20w700cEEE6DApoppins.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(24.h),



                  CustomTextfield(
                    textAlign: TextAlign.start,
                    borderColor: AppColors.cD1D1D1,
                    controller: passwordController,
                    prefixIcon: Transform.scale(
                      scale: 0.50,
                      child: SvgPicture.asset(AppIcons.accessicon,height: 20.h),
                    ),
                    hintText: 'Type your Password',
                    hintTextSyle: TextFontStyle.textStyle14w400cE8E8E8poppins,
                    isObsecure: true,
                    isPass: true,
                    validator: _validatePassword,
                    style: TextStyle(color:AppColors.cFFFFFF),

                  ),



                  UIHelper.verticalSpace(30.h),

                  CustomTextfield(
                    textAlign: TextAlign.start,
                    borderColor: AppColors.cD1D1D1,
                    hintText: 'Confirm Password',
                    hintTextSyle: TextFontStyle.textStyle14w400cE8E8E8poppins,
                    controller:   confrimPasswordController,
                    isObsecure: true,
                    isPass: true,
                    validator: _validatePassword,
                    style: TextStyle(color:AppColors.cFFFFFF),
                    prefixIcon: Transform.scale(
                      scale: 0.50,
                      child: SvgPicture.asset(AppIcons.accessicon,height: 20.h),
                    ),
                  ),
                  UIHelper.verticalSpace(30.h),


                  CustomButtonWidget(
                    textStyle: TextFontStyle.textStyle20w700c000000poppins,
                    image: DecorationImage(
                      image: AssetImage(AppImages.withbacrounbutton),
                    ),
                    text: 'RESET',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        NavigationService.navigateTo(Routes.backToResentPasswordScreen);

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
