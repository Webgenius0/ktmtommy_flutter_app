import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  final screenLoading = true.obs;
  final actionLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _loadRecentActivities();
  }

  // Load recent activities from API
  Future<void> _loadRecentActivities() async {
    screenLoading.value = true;
    try {
      await getRecentActivityLogRx.getAllActivityApi();
    } catch (e) {
      log("Load recent activity error: $e");
    } finally {
      screenLoading.value = false;
    }
  }

  // Format date and time for subtitle
  String _formatSubtitle(String date, String time) {
    return "$date, $time";
  }

  // Handle delete activity with immediate UI update
  Future<void> _handleDeleteActivity(int index, String id) async {
    actionLoading.value = true;

    try {
      // Get current data and remove item immediately for instant UI feedback
      final currentData = getRecentActivityLogRx.dataFetcher.value;
      if (currentData.data!.isNotEmpty) {
        final removedItem = currentData.data!.removeAt(index);
        getRecentActivityLogRx.dataFetcher; // Trigger UI update

        // Call delete API in background
        await deleteActivityRxObj.deleteActivityPostApi(id: id);
      }
    } catch (e) {
      log("============>>>>>>>>>Delete Error: $e");
    } finally {
      actionLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: CustomAppbarWidget(
                onTap: () => NavigationService.goBack(),
                text: 'Recent Activity Log',
              ),
            ),
            UIHelper.verticalSpace(20.h),

            // Content
            Expanded(
              child: Obx(() {
                if (screenLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.c87B842),
                  );
                }

                final data = getRecentActivityLogRx.dataFetcher.value;

                // Empty state
                if (data.success == false ||
                    (data.data ?? []).isEmpty) {
                  return Center(
                    child: Text(
                      "No activity found",
                      style: TextFontStyle.textStyle16w400c757575poppins
                          .copyWith(fontSize: 14.sp),
                    ),
                  );
                }

                final activities = data.data!;

                return Stack(
                  children: [
                    // Activity List
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          // Activities Container
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 13.h),
                            decoration: ShapeDecoration(
                              color: AppColors.c181818,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
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
                                      // Activity Icon
                                      SvgPicture.asset(
                                        'assets/icons/signureicon.svg',
                                        height: 24.h,
                                      ),
                                      UIHelper.horizontalSpace(20.w),

                                      // Activity Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                UIHelper.horizontalSpace(30.w),
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
                                              _formatSubtitle(item.date ?? '',
                                                  item.time ?? ''),
                                              style: TextFontStyle
                                                  .textStyle16w400c757575poppins
                                                  .copyWith(fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Delete Button
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          onTap: () => _handleDeleteActivity(
                                              index, item.id.toString()),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.w),
                                            child: SvgPicture.asset(
                                              AppIcons.deleteicon,
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
                          ),

                          // Add New Log Button
                          UIHelper.verticalSpace(25.h),
                          CustomButtonWidget(
                            onTap: () => NavigationService.navigateTo(
                                Routes.logActivityScreen),
                            icon: SvgPicture.asset(AppIcons.pluseadd),
                            text: 'Add New Log',
                          ),
                          UIHelper.verticalSpace(40.h),
                        ],
                      ),
                    ),

                    // Loading Overlay during delete
                    if (actionLoading.value)
                      Container(
                        color: Colors.black38,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.c87B842,
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
