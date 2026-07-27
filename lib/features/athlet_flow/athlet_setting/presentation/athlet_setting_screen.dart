
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class AthletSettingScreen extends StatefulWidget {
  const AthletSettingScreen({super.key});

  @override
  State<AthletSettingScreen> createState() => _AthletSettingScreenState();
}

class _AthletSettingScreenState extends State<AthletSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:  Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.restbacroundimage),fit: BoxFit.cover)
          ),
          child:  SafeArea(
            child: Column(
              children: [

                ArrowButtonAtheleteFlow(
                  text: 'My Profile & Settings',
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
                UIHelper.verticalSpace(20.h),


     //==================================== Container ==================================//
                Expanded(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      padding: EdgeInsets.all(24),
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(1.00, 0.50),
                          end: Alignment(-0.00, 0.50),
                          colors: [const Color(0xFF0C0A0A), const Color(0xFF44291F)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'COMING SOON!!',
                        textAlign: TextAlign.center,
                        style: TextFontStyle.textStyle24w600cF55216poppins.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )


    );
  }
}
