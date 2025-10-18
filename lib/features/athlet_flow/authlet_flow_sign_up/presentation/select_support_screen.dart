
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/stepbar_select_goal.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_select_support.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';



class SelectSupportScreen extends StatefulWidget {
  const SelectSupportScreen({super.key});

  @override
  State<SelectSupportScreen> createState() => _SelectSupportScreenState();
}

class _SelectSupportScreenState extends State<SelectSupportScreen> {
  final List<String> title = [
    'RUNNING',
    'YOGA',
    'GYM',
    'FOOTBALL'
  ];

  int? selectedIndex;
  String? errorMessage;

  void _onNext() {
    if (selectedIndex == null) {
      setState(() {
        errorMessage = "⚠️ Please select a sport to continue";
      });
      return;
    }

    setState(() {
      errorMessage = null;
    });

    NavigationService.navigateTo(Routes.experienceLevelScreen);
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

     //========================================== Arrw Back ===============================//
                ArrowButtonAtheleteFlow(
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
                UIHelper.verticalSpace(12.h),

     //=============================== Text =================================//
                Text(
                    'Lets Personalize\nYour Program',
                    style: TextFontStyle.textStyle24w700cFFFFFFTeko.copyWith(
                        fontSize: 32.sp)
                ),
                UIHelper.verticalSpace(18.h),
                StepBarSelectGoal(
                  currentStep: 1,
                  onTap: () {
                    NavigationService.navigateTo(Routes.recoveryStepTwoScreen);
                  },
                  onStepTap: (int index) {},
                ),
                UIHelper.verticalSpace(18.h),
                Text(
                    'Select your Sport',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                ),
                UIHelper.verticalSpace(28.h),

  //============================== Listview Spared ============================//


                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: CustomSelectSupport(
                        title: title[index],
                        isSelected: isSelected,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return UIHelper.verticalSpace(24.h);
                  },
                  itemCount: title.length,
                ),
                // Error message
                if (errorMessage != null) ...[
                  UIHelper.verticalSpace(12.h),
                  Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                ],


    //=============================== Custom Button =========================================//
                UIHelper.verticalSpace(63.h),
                CustomButtonWidget(
                  onTap: _onNext,
                  textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                  image: DecorationImage(
                      image: AssetImage(AppImages.orangebutton)),
                  text: 'Next',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
