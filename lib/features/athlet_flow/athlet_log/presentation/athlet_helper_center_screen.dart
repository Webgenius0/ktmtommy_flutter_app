import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class AthletHelperCenterScreen extends StatefulWidget {
  const AthletHelperCenterScreen({super.key});

  @override
  State<AthletHelperCenterScreen> createState() => _AthletHelperCenterScreenState();
}

class _AthletHelperCenterScreenState extends State<AthletHelperCenterScreen> {

  final List<String> icon = [
    'assets/icons/contacticon.svg',
    'assets/icons/whatssapp.svg',
    'assets/icons/instragram.svg',
    'assets/icons/fachbookicon.svg',
  ];

  final List<String> title = [
    'Contact us',
    'WhatsApp',
    'Instagram',
    'Facebook',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.restbacroundimage),fit: BoxFit.cover)
        ),
        child:   SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 14.h),
          child: SafeArea(
            child: Column(
              children: [

//=============================== Arrw Button ===================================//
                ArrowButtonAtheleteFlow(
                  text: 'Help Center',
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
                UIHelper.verticalSpace(24.h),


//======================================= Listview ======================================//

                ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,

                  itemBuilder: (BuildContext context, int index) {
                    return  Container(
                        width: double.infinity,
                        padding:  EdgeInsets.all(24),
                        decoration: ShapeDecoration(
                          color: AppColors.c181818,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),child:Row(
                      children: [
                        SvgPicture.asset(
                          icon[index],
                          height: 24.h,
                          color: AppColors.orangeColor,

                        ),
                        UIHelper.horizontalSpace(16.w),
                        Text(
                            title[index],
                            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                fontSize: 18.sp,fontWeight: FontWeight.w500
                            )
                        )


                      ],
                    )
                    );

                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return UIHelper.verticalSpace(16.h);
                  },
                  itemCount: icon.length,

                ),

              ],
            ),
          ),
        ),
      )


    );
  }
}
