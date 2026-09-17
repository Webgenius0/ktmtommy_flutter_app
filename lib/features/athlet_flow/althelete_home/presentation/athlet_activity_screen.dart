import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/model/recent_activity_log_model.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class AthletActivityScreen extends StatefulWidget {
  const AthletActivityScreen({super.key});

  @override
  State<AthletActivityScreen> createState() => _AthletActivityScreenState();
}

class _AthletActivityScreenState extends State<AthletActivityScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await getRecentActivityLogRx.getAllActivityApi();
    } catch (e) {
      log("Error loading activities: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleDeleteActivity(int index, String id) async {
    try {
      final currentData = getRecentActivityLogRx.dataFetcher.value;
      if (currentData.data != null && currentData.data!.isNotEmpty) {
        currentData.data!.removeAt(index);
        getRecentActivityLogRx.dataFetcher.sink.add(currentData);
        await deleteActivityRxObj.deleteActivityPostApi(id: id);
      }
    } catch (e) {
      log("Delete Error: $e");
      await _loadActivities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.restbacroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                // Header
                ArrowButtonAtheleteFlow(
                  text: 'Recent activity log',
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
                UIHelper.verticalSpace(20.h),

                // Content
                Expanded(
                  child: StreamBuilder<GetRecentActivityModel>(
                    stream: getRecentActivityLogRx.ActivityLogScreen,
                    builder: (context, snapshot) {
                      if (_isLoading && (!snapshot.hasData || snapshot.data?.data == null)) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.orangeColor,
                          ),
                        );
                      }

                      final activities = snapshot.data?.data ?? [];

                      if (activities.isEmpty) {
                        return Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.signureicon,
                                      height: 64.h,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.orangeColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    UIHelper.verticalSpace(16.h),
                                    Text(
                                      "No activity found right now",
                                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    UIHelper.verticalSpace(8.h),
                                    Text(
                                      "Tap the button below to add your first activity.",
                                      style: TextFontStyle.textStyle16w400c757575poppins.copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomButtonWidget(
                              textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                              image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                              onTap: () {
                                NavigationService.navigateTo(Routes.athletLogActivityScreen);
                              },
                              icon: SvgPicture.asset(AppIcons.pluseadd),
                              text: 'Add  New Log',
                            ),
                            UIHelper.verticalSpace(20.h),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 13.h,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: AppColors.c181818,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: activities.length,
                                      itemBuilder: (context, index) {
                                        final item = activities[index];

                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: 12.h),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppIcons.signureicon,
                                                height: 24.h,
                                                colorFilter: const ColorFilter.mode(
                                                  AppColors.orangeColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              UIHelper.horizontalSpace(20.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            item.name ?? '',
                                                            style: TextFontStyle
                                                                .textStyle24w600cFFFFFFpoppins
                                                                .copyWith(
                                                              fontSize: 16.sp,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                        UIHelper.horizontalSpace(10.w),
                                                        Text(
                                                          "${item.durationMinutes ?? 0} mins",
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
                                                      "${item.date ?? ''}${item.time != null ? ', ${item.time}' : ''}",
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
                                                  onTap: () => _handleDeleteActivity(
                                                    index,
                                                    item.id.toString(),
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(4.w),
                                                    child: SvgPicture.asset(
                                                      AppIcons.deleteicon,
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
                                      },
                                    ),
                                  ),
                                  UIHelper.verticalSpace(20.h),
                                ],
                              ),
                            ),
                          ),
                          CustomButtonWidget(
                            textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                            image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                            onTap: () {
                              NavigationService.navigateTo(Routes.athletLogActivityScreen);
                            },
                            icon: SvgPicture.asset(AppIcons.pluseadd),
                            text: 'Add  New Log',
                          ),
                          UIHelper.verticalSpace(20.h),
                        ],
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
