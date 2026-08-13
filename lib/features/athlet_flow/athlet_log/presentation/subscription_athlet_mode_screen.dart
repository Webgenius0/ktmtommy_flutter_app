import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SubscriptionAthletModeScreen extends StatefulWidget {
  const SubscriptionAthletModeScreen({super.key});
  @override
  State<SubscriptionAthletModeScreen> createState() =>
      _SubscriptionAthletModeScreenState();
}

class _SubscriptionAthletModeScreenState
    extends State<SubscriptionAthletModeScreen> {
  StreamSubscription<bool>? _loadingSubscription;

  @override
  void initState() {
    super.initState();
    _loadingSubscription =
        subscriptionRxObj.isLoadingStream.listen((isLoading) {
      if (isLoading) {
        EasyLoading.show(status: 'Processing...');
      } else {
        EasyLoading.dismiss();
      }
    });
  }

  @override
  void dispose() {
    _loadingSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.restbacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigationService.goBack;
                      },
                      child: SvgPicture.asset(
                        AppIcons.arrwButton,
                      ),
                    ),
                    UIHelper.horizontalSpace(22.w),
                    Text(
                      'Choose Your Plan',
                      textAlign: TextAlign.center,
                      style:
                          TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await subscriptionRxObj.restorePurchases();
                      },
                      child: Text(
                        'Restore',
                        style: TextFontStyle.textStyle24w600cF55216poppins
                            .copyWith(
                          color: AppColors.cFFFFFF,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    // UIHelper.horizontalSpace(16.w),
                    // GestureDetector(
                    //   onTap: () {
                    //     NavigationService.navigateTo(
                    //         Routes.athletBottomNavigationBar);
                    //   },
                    //   child: Text(
                    //     'Skip',
                    //     style: TextFontStyle.textStyle24w600cF55216poppins
                    //         .copyWith(
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 14.sp,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Text(
                  'Get access to exclusive deals and offers',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                UIHelper.verticalSpace(18.h),
                Expanded(
                  child: StreamBuilder<int>(
                    stream: subscriptionRxObj.selectedPlanIndexStream,
                    initialData: subscriptionRxObj.selectedPlanIndex,
                    builder: (context, snapshot) {
                      final selectedPlanIndex = snapshot.data ?? -1;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            UIHelper.verticalSpace(12.h),

                            //======================================= Free =====================================//
                            Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: AppColors.orangeColor, width: 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Free',
                                    style: TextFontStyle
                                        .textStyle14w400cA3A3A3poppins
                                        .copyWith(
                                      color: AppColors.cFFFFFF,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$ 0',
                                            style: TextFontStyle
                                                .textStyle24w600cFFFFFFpoppins
                                                .copyWith(
                                              fontSize: 32.sp,
                                            ),
                                          ),
                                          UIHelper.horizontalSpace(4.w),
                                          Text(
                                            "/7days",
                                            style: TextFontStyle
                                                .textStyle24w600cFFFFFFpoppins
                                                .copyWith(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(16.h),
                                      ...[
                                        "Basic logging for 7 days",
                                        'View last 7 days of logs',
                                        ' Basic AI insights (1/week)',
                                        'Manual food entry only',
                                      ].map(
                                        (feature) => Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 12.h),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  AppIcons.orangesigneture,
                                                  height: 24.h),
                                              SizedBox(width: 24.w),
                                              Text(
                                                feature,
                                                style: TextFontStyle
                                                    .textStyle14w400cA3A3A3poppins
                                                    .copyWith(
                                                  color: AppColors.cFFFFFF,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      UIHelper.verticalSpace(16.h),
                                      CustomButton(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 32.w, vertical: 16.h),
                                        name: "Start 7-Day Free Trial",
                                        onCallBack: () async {
                                          subscriptionRxObj.selectPlan(0);
                                          await subscriptionRxObj
                                              .purchaseSubscription();
                                        },
                                        borderColor: AppColors.orangeColor,
                                        borderRadius: 28.r,
                                        color: selectedPlanIndex == 0
                                            ? AppColors.orangeColor
                                            : AppColors.c101010,
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.verticalSpace(24.h),

                            //=========================================== Plus Plan =============================//
                            Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: AppColors.orangeColor, width: 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Plus',
                                        style: TextFontStyle
                                            .textStyle14w400cA3A3A3poppins
                                            .copyWith(
                                          color: AppColors.cFFFFFF,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24.sp,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: 140.w,
                                        height: 31,
                                        decoration: BoxDecoration(
                                          color: AppColors.orangeColor,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppIcons.mostpopularicon,
                                                height: 18.h),
                                            UIHelper.horizontalSpace(4.w),
                                            Text(
                                              'Most Popular',
                                              style: TextFontStyle
                                                  .textStyle24w600cFFFFFFpoppins
                                                  .copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpace(12.h),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$4.99/',
                                            style: TextFontStyle
                                                .textStyle24w600cFFFFFFpoppins
                                                .copyWith(fontSize: 32.sp),
                                          ),
                                          UIHelper.horizontalSpace(4.w),
                                          Text(
                                            "month",
                                            style: TextFontStyle
                                                .textStyle24w600cFFFFFFpoppins
                                                .copyWith(fontSize: 16.sp),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(16.h),
                                      ...[
                                        "Unlimited logs ",
                                        'AI insights daily',
                                        'Basic food scanning with\nnutrition breakdown',
                                      ].map(
                                        (feature) => Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 12.h),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  AppIcons.orangesigneture,
                                                  height: 24.h),
                                              SizedBox(width: 24.w),
                                              Text(
                                                feature,
                                                style: TextFontStyle
                                                    .textStyle14w400cA3A3A3poppins
                                                    .copyWith(
                                                  color: AppColors.cFFFFFF,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      UIHelper.verticalSpace(16.h),
                                      CustomButton(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 32.w, vertical: 16.h),
                                        name: "Get Now",
                                        onCallBack: () async {
                                          subscriptionRxObj.selectPlan(1);
                                          await subscriptionRxObj
                                              .purchaseSubscription();
                                        },
                                        borderColor: AppColors.orangeColor,
                                        borderRadius: 28.r,
                                        color: selectedPlanIndex == 1
                                            ? AppColors.orangeColor
                                            : AppColors.c101010,
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.verticalSpace(24.h),

                            //========================================= Pro Plan ==============================================//
                            Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: AppColors.orangeColor, width: 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pro',
                                    style: TextFontStyle
                                        .textStyle14w400cA3A3A3poppins
                                        .copyWith(
                                      color: AppColors.cFFFFFF,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$89.99/',
                                            style: TextFontStyle
                                                .textStyle24w600cFFFFFFpoppins
                                                .copyWith(fontSize: 32.sp),
                                          ),
                                          UIHelper.horizontalSpace(4.w),
                                          Text(
                                            "year",
                                            style: TextFontStyle
                                                .textStyle24w600cFFFFFFpoppins
                                                .copyWith(fontSize: 16.sp),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(16.h),
                                      ...[
                                        "All Plus features",
                                        'Unlimited food scanning',
                                        'Basic food scanning with\nnutrition breakdown',
                                      ].map(
                                        (feature) => Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 12.h),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  AppIcons.orangesigneture,
                                                  height: 24.h),
                                              SizedBox(width: 24.w),
                                              Text(
                                                feature,
                                                style: TextFontStyle
                                                    .textStyle14w400cA3A3A3poppins
                                                    .copyWith(
                                                  color: AppColors.cFFFFFF,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      UIHelper.verticalSpace(16.h),
                                      CustomButton(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 32.w, vertical: 16.h),
                                        name: "Get Now",
                                        onCallBack: () async {
                                          subscriptionRxObj.selectPlan(2);
                                          await subscriptionRxObj
                                              .purchaseSubscription();
                                        },
                                        borderColor: AppColors.orangeColor,
                                        borderRadius: 28.r,
                                        color: selectedPlanIndex == 2
                                            ? AppColors.orangeColor
                                            : AppColors.c101010,
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.verticalSpace(18.h),

                            //====================================  7-day free trial available ===================================//
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppIcons.clockicon,
                                    height: 18.h,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.orangeColor,
                                        BlendMode.srcIn)),
                                UIHelper.horizontalSpace(7.w),
                                Text(
                                  '7-day free trial available',
                                  style: TextFontStyle
                                      .textStyle14w400cE8E8E8poppins
                                      .copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppIcons.orangesigneture,
                                    height: 18.h),
                                UIHelper.horizontalSpace(7.w),
                                Text(
                                  'Cancel anytime',
                                  style: TextFontStyle
                                      .textStyle14w400cE8E8E8poppins
                                      .copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(24.h),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
