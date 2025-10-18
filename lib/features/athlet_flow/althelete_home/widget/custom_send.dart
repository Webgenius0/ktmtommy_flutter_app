import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomSend extends StatefulWidget {
  const CustomSend({
    super.key,
  });

  @override
  State<CustomSend> createState() => _CustomSendState();
}

class _CustomSendState extends State<CustomSend> {

  bool _showSuccess = false;
  final TextEditingController _questionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color:AppColors.c090809,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x11F55216),
            blurRadius: 50,
            offset: Offset(0, 25),
            spreadRadius: 0,)
        ],
      ),
      child:Padding(
        padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppIcons.coochsicon,height: 20.h,),
                UIHelper.horizontalSpace(7.w),
                Text(
                    'Ask your coach',
                    textAlign: TextAlign.center,
                    style:  TextFontStyle.textStyle20w700cFFFFFFTeko.copyWith(
                        fontSize: 18.sp,fontWeight: FontWeight.w400
                    )
                )
              ],
            ),
            UIHelper.verticalSpace(10.h),
            CustomTextfield(
              controller: _questionController,
              textAlign: TextAlign.start,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              borderRadius: 20.r,
              fillColor: AppColors.c181818,
              hintText: 'Drop a message here...',
              hintTextSyle: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp
              ),
              style: TextStyle(color: Colors.white),
              suffixIcon: GestureDetector(
                onTap: () {
                  if (_questionController.text.isNotEmpty) {
                    setState(() {
                      _showSuccess = true;
                    });
                    Future.delayed(Duration(seconds: 3), () {
                      if (mounted) {
                        setState(() {
                          _showSuccess = false;
                        });
                      }
                    });
                    _questionController.clear();
                  }
                },
                child: Transform.scale(
                  scale: 0.64,
                  child: SvgPicture.asset(AppIcons.sendicon, height: 24.h),
                ),
              ),
            ),
            if (_showSuccess)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  '✓ Sent successfully',
                  style: TextStyle(
                    color: AppColors.c87B842,
                    fontSize: 14.sp,
                  ),
                ),
              ),





          ],
        ),
      ) ,
    );
  }
}