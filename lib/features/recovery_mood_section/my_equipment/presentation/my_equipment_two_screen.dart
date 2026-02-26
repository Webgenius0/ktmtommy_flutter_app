import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/model/get_all_equipment_model.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/tbi_recovery.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyEquipmentTwoScreen extends StatefulWidget {
  const MyEquipmentTwoScreen({super.key});

  @override
  State<MyEquipmentTwoScreen> createState() => _MyEquipmentTwoScreenState();
}

class _MyEquipmentTwoScreenState extends State<MyEquipmentTwoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> categories = ['All', 'Strength', 'Ca rdio', 'Flexibility'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    getAllEquipmentRxObj.getAllEquipmentApi();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Datum> filterEquipment(List<Datum> list, String category) {
    if (category == 'All') return list;
    return list.where((e) => e.type?.toLowerCase() == category.toLowerCase()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              child: TBIRecovery(title: 'My Equipment'),
            ),

            // Main Content
            Expanded(
              child: StreamBuilder<GetAllEquipmentModel>(
                stream: getAllEquipmentRxObj.dataFetcher,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.c87B842),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.wifi_off, color: Colors.grey, size: 60),
                          UIHelper.verticalSpace(16.h),
                          Text(
                            'Connection failed',
                            style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                          ),
                          TextButton(
                            onPressed: () => getAllEquipmentRxObj.getAllEquipmentApi(),
                            child: const Text('Try Again', style: TextStyle(color: AppColors.c87B842)),
                          ),
                        ],
                      ),
                    );
                  }

                  final List<Datum> equipmentList = snapshot.data?.data ?? [];
                  final bool hasEquipment = equipmentList.isNotEmpty;

                  // Empty State
                  if (!hasEquipment) {
                    return Column(
                      children: [
                        UIHelper.verticalSpace(32.h),
                        Image.asset(AppImages.copyImage, height: 196.h),
                        UIHelper.verticalSpace(48.h),
                        Text(
                          'No Equipment Added Yet!',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(fontWeight: FontWeight.w500),
                        ),
                        UIHelper.verticalSpace(12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Text(
                            'Start tracking the tools you use for your recovery or training. Add equipment to personalize your experience.',
                            textAlign: TextAlign.center,
                            style: TextFontStyle.textStyle16w400c757575poppins.copyWith(fontSize: 14.sp),
                          ),
                        ),

                        UIHelper.verticalSpace(32.h),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButtonWidget(
                            onTap: () {
                             NavigationService.navigateTo(Routes.addEquipmentScreen).then((_) {
                                getAllEquipmentRxObj.getAllEquipmentApi();
                              });
                            },
                            text: 'Add Equipment',
                          ),
                        ),



                        const Spacer(),
                      ],
                    );
                  }

            final totalItem = snapshot.data?.data?.length??0;

                  // Data Available → TabBar + List
                  return Column(
                    children: [
                      UIHelper.verticalSpace(16.h),

                      // TabBar
                      Container(
                        color: AppColors.c181818,
                        child: TabBar(
                          controller: _tabController,
                          indicatorColor: AppColors.c87B842,
                          indicatorWeight: 2.w,
                          unselectedLabelColor: Colors.white60,
                          labelStyle: TextFontStyle.textStyle14w400c87B842poppins,
                          tabs: categories.map((e) => Tab(text: e)).toList(),
                        ),
                      ),

                      UIHelper.verticalSpace(35.h),

                      // TabBarView
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: categories.map((category) {
                            final filtered = filterEquipment(equipmentList, category);

                            if (filtered.isEmpty) {
                              return Center(
                                child: Text(
                                  'No $category equipment yet',
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16.sp),
                                ),
                              );
                            }

                            return Column(
                              children: [
                                Container(
                                  width: 327,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF181818),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: const Color(0xFF87B842)
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Total Equipment",style: TextFontStyle.textStyle16w400c5C5C5C,),
                                        Text("${totalItem} items",style: TextFontStyle.headline18w500cFFFFFF,),

                                      ],
                                    ),

                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: const Color(0xFF87B842) /* Secondary-Color-2 */,
                                          ),
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),child: Text("$totalItem",style: TextFontStyle.textStyle20w700c000000poppins.copyWith(color: Colors.white),),
                                    )
                                    
                                  ],
                                ),
                                ),
                                UIHelper.verticalSpace(24),
                                Expanded(  // ← Add Expanded here
                                  child: ListView.builder(
                                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                                    itemCount: filtered.length,
                                    itemBuilder: (context, index) {
                                      final item = filtered[index];

                                      return Container(
                                        margin: EdgeInsets.only(bottom: 16.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.c181818,
                                          borderRadius: BorderRadius.circular(20.r),
                                          border: Border.all(color: AppColors.c454545, width: 1.w),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20.r),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Image from image_url (Full URL)
                                              SizedBox(
                                                height: 140.h,
                                                width: double.infinity,
                                                child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                                                    ? CachedNetworkImage(
                                                  imageUrl: item.imageUrl!,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => Container(
                                                    color: Colors.grey.shade800,
                                                    child: const Center(
                                                      child: CircularProgressIndicator(
                                                        color: AppColors.c87B842,
                                                        strokeWidth: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url, error) => Image.asset(
                                                    AppImages.copyImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                                    : Image.asset(AppImages.copyImage, fit: BoxFit.cover),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(16.w),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // Name
                                                    Text(
                                                      item.name ?? 'No Name',
                                                      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 18.sp,
                                                      ),
                                                    ),
                                                    UIHelper.verticalSpace(8.h),

                                                    // Type + Icon
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          _getIconForType(item.type),
                                                          height: 22.h,
                                                          color: AppColors.c87B842,
                                                        ),
                                                        UIHelper.horizontalSpace(8.w),
                                                        Text(
                                                          item.type ?? 'Others',
                                                          style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                                                            fontSize: 16.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Container(
        padding: EdgeInsets.all(6.w),
        decoration: const BoxDecoration(color: AppColors.c87B842, shape: BoxShape.circle),
        child: IconButton(
          icon: const Icon(Icons.add, color: AppColors.c181818, size: 28),
          onPressed: () {
            NavigationService.navigateTo(Routes.addEquipmentScreen).then((_) {
              getAllEquipmentRxObj.getAllEquipmentApi(); // Refresh after add
            });
          },
        ),
      ),
    );
  }

  String _getIconForType(String? type) {
    switch (type?.toLowerCase()) {
      case 'strength':
        return 'assets/icons/strengthicon.svg';
      case 'cardio':
        return 'assets/icons/cardioicon.svg';
      case 'flexibility':
        return 'assets/icons/flexibilityicon.svg';
      default:
        return 'assets/icons/othericon.svg';
    }
  }
}