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




class SentOtpScreen extends StatefulWidget {
  const SentOtpScreen({super.key});

  @override
  State<SentOtpScreen> createState() => _SentOtpScreenState();
}

class _SentOtpScreenState extends State<SentOtpScreen> {

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.bacroundimage),fit: BoxFit.cover)
        ),child:

      SingleChildScrollView(
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
                        onTap: (){NavigationService.goBack;},
                        child: SvgPicture.asset(AppIcons.arrwbaciconwithcolor)),
                  ],
                ),
                Lottie.asset('assets/lottie/lightlock.json',height: 230.h,width: 230.w),

                UIHelper.verticalSpace(30.h),
                Text(
                  'Reset Password',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 20.sp
                  )
                ),
                UIHelper.verticalSpace(2.h),
                Text(
                  'Please enter email to reset',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle14w400cE8E8E8poppins
                ),
                UIHelper.verticalSpace(24.h),

                CustomTextfield(
                  textAlign: TextAlign.start,
                  borderColor: AppColors.cD1D1D1,
                  controller: emailController,
                  prefixIcon: Transform.scale(
                    scale: 0.50,
                    child: SvgPicture.asset(AppIcons.mailIcon,height: 20.h),
                  ),
                  hintText: 'Type your email',
                  hintTextSyle: TextFontStyle.textStyle14w400cE8E8E8poppins,

                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  style: TextStyle(color:AppColors.cE8E8E8),

                ),
                UIHelper.verticalSpace(30.h),


                 CustomButtonWidget(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        NavigationService.navigateTo(Routes.verifyOtpScreen);

                      }
                    },
                    textStyle: TextFontStyle.textStyle20w700c000000poppins,
                    image: DecorationImage(
                      image: AssetImage(AppImages.withbacrounbutton),
                    ),

                    text: 'SEND OTP'),






              ],
            ),
          ),
        ),
      ),
      ),

    );
  }
}
