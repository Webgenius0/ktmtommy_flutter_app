import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class RecentSupplementLogScreen extends StatefulWidget {
  const RecentSupplementLogScreen({super.key});

  @override
  State<RecentSupplementLogScreen> createState() => _RecentSupplementLogScreenState();
}

class _RecentSupplementLogScreenState extends State<RecentSupplementLogScreen> {
  final List<String> icon = [
    'assets/icons/signureicon.svg',
    'assets/icons/signureicon.svg',
    'assets/icons/signureicon.svg',

  ];

  final List<String> title = [
    'Swimming',
    'Swimming',
    'Swimming',

  ];

  final List<String> subtitle = [
    'Yesterday, 3:30 PM',
    'Yesterday, 3:30 PM',
    'Yesterday, 3:30 PM',

  ];

  final List<String> mg = [
    '30 mins',
    '30 mins',
    '30 mins',

  ];

  final List<String> deleteIcon = [
    'assets/icons/deleteicon.svg',
    'assets/icons/deleteicon.svg',
    'assets/icons/deleteicon.svg',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.restbacroundimage),fit: BoxFit.cover)
          ),child:  SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [

                //============================== Arrw Button ===========================//

                ArrowButtonAtheleteFlow(
                  text: 'Recent activity log',
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
                UIHelper.verticalSpace(20.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
                          decoration: ShapeDecoration(
                            color: AppColors.c181818,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: title.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12.h),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(icon[index], height: 24.h,color: AppColors.orangeColor,),
                                        UIHelper.horizontalSpace(20.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    title[index],
                                                    style: TextFontStyle
                                                        .textStyle24w600cFFFFFFpoppins
                                                        .copyWith(
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  UIHelper.horizontalSpace(30.w),
                                                  Text(
                                                    mg[index],
                                                    style: TextFontStyle
                                                        .textStyle24w600cFFFFFFpoppins
                                                        .copyWith(
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              UIHelper.verticalSpace(4.h),
                                              Text(
                                                subtitle[index],
                                                style: TextFontStyle
                                                    .textStyle16w400c757575poppins
                                                    .copyWith(fontSize: 12.sp),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              debugPrint(
                                                'Delete icon tapped at index $index',
                                              );
                                            },
                                            borderRadius: BorderRadius.circular(8.r),
                                            child: Padding(
                                              padding: EdgeInsets.all(4.w),
                                              child: SvgPicture.asset(
                                                deleteIcon[index],
                                                height: 24.h,
                                                color: AppColors.orangeColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(350.h),
                        CustomButtonWidget(
                            textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                            image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                            onTap: (){NavigationService.navigateTo(Routes.logSupplementScreen);},
                            icon: SvgPicture.asset(AppIcons.pluseadd),
                            text: 'Add  New Log'),

                      ],
                    ),
                  ),
                )



              ],
            ),
          ),
        ),
        )


    );
  }
}
