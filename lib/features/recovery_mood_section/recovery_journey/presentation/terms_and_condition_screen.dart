import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';

import '../../../../helpers/ui_helpers.dart' show UIHelper;




class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {

  final List<String> icon = [
    'assets/icons/acceptanceicon.svg',
    'assets/icons/usericon.svg',
    'assets/icons/subcriptionicon.svg',
    'assets/icons/liabilityicon.svg',
    'assets/icons/liabilityicon.svg',
    'assets/icons/liabilityicon.svg',
    'assets/icons/modificationicon.svg',
    'assets/icons/contactinformation.svg'

  ];

 final List<String> title = [
    'Acceptance of Terms',
    'User Responsibilities',
    'Subscription and Billing',
    'Liability Disclaimer',
    'Outrageous Tom Mode\nDisclaimer',
    'Intellectual Property',
    'Modifications to Terms',
    'Contact Information',

  ];


 final List<String> subtitle = [
    'By using the My Balance Day app, you agree to be bound by these Terms and Conditions, as well as our Privacy Policy. If you do not agree, do not use the app.',
    'Users agree to use the app for personal, non-commercial purposes only. You are responsible for ensuring any data you enter is accurate.',
    'My Balance Day offers both monthly and annual subscription options. Subscriptions are billed through the App Store or Google Play. Cancellations must be managed through the platform used for purchase.',
    'The app is intended for informational and tracking purposes only. It is not a substitute for professional medical advice, diagnosis, or treatment. The developer is not liable for any injuries, health outcomes, or misuse of the app.',
    'This mode contains intentionally harsh, motivational content and is not medical advice. Users must acknowledge a disclaimer before activating the mode. The developer is not liable for any consequences resulting from its use.',
    'All content within the app is the property of My Balance Day. You may not duplicate, share, or reverse engineer the app or its contents.',
    'We reserve the right to update or modify these terms at any time. Continued use of the app after changes constitutes acceptance of those changes.',
    'For questions or support, please use the contact form within the app or email our support team directly.',

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.restbacroundimage),fit: BoxFit.cover)
        ),
        child:   SafeArea(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 11.h),
                child: Column(
                  children: [
                    CustomAppbarWidget(
                      onTap: (){NavigationService.goBack;},
                      text: 'My Balance Day –\nTerms and Conditions',
                    ),
                    UIHelper.verticalSpace(24.h),
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.calandericon, height: 20.h),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                          'Date: August 02, 2025',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(24.h),
                  ],
                ),
              ),




              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,

                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          color: AppColors.c181818,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1,
                                color: AppColors.c454545
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(

                                children: [
                                  SvgPicture.asset(icon[index],height: 24.h),
                                  UIHelper.horizontalSpace(6.w),
                                  Text(
                                      title[index],
                                      style:  TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                          fontSize: 18.sp,fontWeight: FontWeight.w500
                                      )
                                  )
                                ],
                              ),
                              UIHelper.verticalSpace(8.h),
                              Text(
                                  subtitle[index],
                                  style: TextFontStyle.textStyle14w400cA3A3A3poppins.copyWith(
                                      fontSize: 16.sp,fontWeight: FontWeight.w400
                                  )
                              ),

                            ],
                          ),
                        ),
                      );

                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return UIHelper.verticalSpace(18.h);
                    },
                    itemCount: icon.length,

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
