import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_athlete_app_bar.dart';
import 'package:ktmtommy_apps/features/athlet_flow/authlet_flow_sign_up/widget/custom_complete_select.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class SelectGoalScreen extends StatefulWidget {
  const SelectGoalScreen({super.key});

  @override
  State<SelectGoalScreen> createState() => _SelectGoalScreenState();
}

class _SelectGoalScreenState extends State<SelectGoalScreen> {
  final List<String> title = [
    'COMPLETE\nTRIATHLON',
    'IMPROVE 5K\nPACE',
    'BUILD MUSCLE\nMASS',
    'IMPROVE\nENDURANCE',
    'MONITOR ENERGY &\nPERFORMANCE',
  ];

  int? selectedIndex;
  String? errorMessage;

  void _onNext() {
    if (selectedIndex == null) {
      setState(() {
        errorMessage = "⚠️ Please select a goal to continue";
      });
      return;
    }

    setState(() {
      errorMessage = null;
    });

    appData.write(kKeyAthleteSelectGoal, title[selectedIndex!]);
    log("Selected Goal: ${title[selectedIndex!]}");
    NavigationService.navigateTo(Routes.personalSetupScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(12.h),
                const CustomAthleteAppBar(
                  title: 'Select Goal',
                  subtitle: 'Tell us what do you want to achieve',
                  currentStep: 0,
                  totalSteps: 4,
                ),
                UIHelper.verticalSpace(24.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: CustomCompleteSelect(
                        title: title[index],
                        isSelected: isSelected,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return UIHelper.verticalSpace(16.h);
                  },
                  itemCount: title.length,
                ),
                if (errorMessage != null) ...[
                  UIHelper.verticalSpace(12.h),
                  Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                ],
                UIHelper.verticalSpace(36.h),
                CustomButtonWidget(
                  onTap: _onNext,
                  textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                  image: DecorationImage(
                    image: AssetImage(AppImages.orangebutton),
                  ),
                  text: 'Set My Target',
                ),
                UIHelper.verticalSpace(24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
