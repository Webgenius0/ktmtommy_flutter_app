import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  final List<String> icon = [
    'assets/icons/signureicon.svg',
    'assets/icons/signureicon.svg',
    'assets/icons/signureicon.svg',
    'assets/icons/signureicon.svg',
    'assets/icons/signureicon.svg',
  ];

  final List<String> title = [
    'Swimming',
    'Swimming',
    'Swimming',
    'Swimming',
    'Swimming',
  ];

  final List<String> subtitle = [
    'Yesterday, 3:30 PM',
    'Yesterday, 3:30 PM',
    'Yesterday, 3:30 PM',
    'Yesterday, 3:30 PM',
    'Yesterday, 3:30 PM',
  ];

  final List<String> mg = [
    '30 mins',
    '30 mins',
    '30 mins',
    '30 mins',
    '30 mins',
  ];

  final List<String> deleteIcon = [
    'assets/icons/deleteicon.svg',
    'assets/icons/deleteicon.svg',
    'assets/icons/deleteicon.svg',
    'assets/icons/deleteicon.svg',
    'assets/icons/deleteicon.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppbarWidget(
                onTap: (){NavigationService.goBack;},

                text: 'Recent Activity Log',
              ),
              UIHelper.verticalSpace(20.h),

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
                              SvgPicture.asset(icon[index], height: 24.h),
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

                              // SvgPicture.asset(deleteIcon[index], height: 24.h),
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
              UIHelper.verticalSpace(250.h),
              CustomButtonWidget(
                onTap: (){NavigationService.navigateTo(Routes.logActivityScreen);},
                icon: SvgPicture.asset(AppIcons.pluseadd),
                  text: 'Add  New Log')
            ],
          ),
        ),
      ),
    );
  }
}
