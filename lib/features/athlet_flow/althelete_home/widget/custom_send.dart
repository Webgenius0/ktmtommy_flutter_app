import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class CustomSend extends StatefulWidget {
  const CustomSend({
    super.key,
  });

  @override
  State<CustomSend> createState() => _CustomSendState();
}

class _CustomSendState extends State<CustomSend> {
  final TextEditingController _questionController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  void _onSend() {
    final String text = _questionController.text.trim();
    if (text.isNotEmpty) {
      sendMessageRx.addChat(message: text);
      _questionController.clear();
    }
    NavigationService.navigateTo(Routes.aiChatScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.c181818,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2F2F2F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.coochsicon,
                height: 20.h,
                colorFilter: const ColorFilter.mode(
                  AppColors.orangeColor,
                  BlendMode.srcIn,
                ),
              ),
              UIHelper.horizontalSpace(8.w),
              Text(
                'Ask your coach',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          CustomTextfield(
            controller: _questionController,
            textAlign: TextAlign.start,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            borderRadius: 20.r,
            fillColor: const Color(0xFF101010),
            hintText: 'Why is my pace dropping',
            hintTextSyle: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: const Color(0xFF757575),
            ),
            style: const TextStyle(color: Colors.white),
            suffixIcon: GestureDetector(
              onTap: _onSend,
              child: Transform.scale(
                scale: 0.64,
                child: SvgPicture.asset(
                  AppIcons.sendicon,
                  height: 24.h,
                  colorFilter: const ColorFilter.mode(
                    AppColors.orangeColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}