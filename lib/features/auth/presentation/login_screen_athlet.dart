import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class LoginScreenAthlet extends StatefulWidget {
  const LoginScreenAthlet({super.key});

  @override
  State<LoginScreenAthlet> createState() => _LoginScreenAthletState();
}

class _LoginScreenAthletState extends State<LoginScreenAthlet> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ✅ Fake login function (you can replace it with API call later)
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      EasyLoading.showError('Please fill all fields correctly');
      return;
    }

    EasyLoading.show(status: 'Logging in...');


    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    bool success = await loginRxObj.logIn(
      email: email,
      password: password,
    );

    if (success) {
      EasyLoading.showSuccess('Login Successful! 🎉');

      NavigationService.navigateTo(Routes.athletBottomNavigationBar);
    } else {
      EasyLoading.showError('Invalid email or password 😔');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.bacroundimage), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SafeArea(
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
                  UIHelper.verticalSpace(107.h),
                  Text('Login to your Account',
                      textAlign: TextAlign.center,
                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    'Hello there, please enter email and\npassword to login 👍',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle14w400cE8E8E8poppins,
                  ),
                  UIHelper.verticalSpace(24.h),
                  CustomTextfield(
                    textAlign: TextAlign.start,
                    borderColor: AppColors.cD1D1D1,
                    controller: emailController,
                    prefixIcon: Transform.scale(
                      scale: 0.50,
                      child: SvgPicture.asset(AppIcons.mailIcon, height: 20.h),
                    ),
                    hintText: 'Type your email',
                    hintTextSyle: TextFontStyle.textStyle14w400cE8E8E8poppins,
                    inputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    style: TextStyle(color: AppColors.cE8E8E8),
                  ),
                  UIHelper.verticalSpace(30.h),
                  CustomTextfield(
                    textAlign: TextAlign.start,
                    borderColor: AppColors.cD1D1D1,
                    controller: passwordController,
                    prefixIcon: Transform.scale(
                      scale: 0.50,
                      child:
                          SvgPicture.asset(AppIcons.accessicon, height: 20.h),
                    ),
                    hintText: 'Type your Password',
                    hintTextSyle: TextFontStyle.textStyle14w400cE8E8E8poppins,
                    isObsecure: !showPassword,
                    isPass: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.c5C5C5C,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                    inputType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    style: TextStyle(color: AppColors.cE8E8E8),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(Routes.sentOtpScreen);
                        },
                        child: Text('Forgot Password? ',
                            style: TextFontStyle.textStyle14w400cE8E8E8poppins),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(30.h),

                  // ✅ LOGIN BUTTON with EasyLoading
                  CustomButtonWidget(
                    textStyle: TextFontStyle.textStyle20w700c000000poppins,
                    image: DecorationImage(
                      image: AssetImage(AppImages.withbacrounbutton),
                    ),
                    text: 'LOGIN',
                    onTap: _handleLogin,
                  ),

                  UIHelper.verticalSpace(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: TextFontStyle.textStyle14w400cF3F3F3poppins,
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(Routes.chooseModeScreen);
                        },
                        child: Text('Register now',
                            style: TextFontStyle.textStyle14w400cF55216poppins
                                .copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
